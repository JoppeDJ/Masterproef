function [Ws, Ds] = PARATUCK_Z(A, rList)
%PARATUCK2 Computes PARATUCK2 decomposition of given three-way tensor

    [I, J, K] = size(A);
    nbOfDiags = size(rList, 2);

    Ws = cell(nbOfDiags + 1,1);
    Ds = cell(nbOfDiags);
    for i=1:nbOfDiags
        if(i == nbOfDiags)
            Ws(i+1) = randn(I, rList(i));
        else
            Ws(i+1) = randn(rList(i+1), rList(i));
        end

        Ds(i) = randn(rList(i), rList(i));
        
    end

    
    for i=1:100
        Ws(1) = updateW0(X, D2, Vt, D1, Zt, I, J, K, r2);
    
        %D2 = updateD2(X, W, Vt, Zt, D1, K, r2);
    
        %Vt = updateVt(X, W, D1, D2, Zt, I, J, K, r1, r2);
    
        %D1 = updateD1(X, W, Vt, Zt, D2, K, r1);
        
        Ws(end) = updateWz(X, W, D1, Vt, D2, I, J, K, r1);

        apprX = zeros(I, J, K);
        for j=1:K
            apprX(:,:,j) = ...
                W * diag(D2(j,:)) * Vt * diag(D1(j,:)) * Zt;
        end
        
        error = frob(X - apprX)^2 / frob(X)^2;
        if(error < 0.000001)
            break
        end
    
    end
    error
end

% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [W] = updateW(X, D2, Vt, D1, Zt, I, J, K, r2)
    unfoldX = zeros(I, J*K);
    for i=1:K
        unfoldX(:, (i-1) * J + 1 : i * J) = X(:,:,i);
    end

    F = zeros(r2, J*K);
    for i=1:K
        F(:,(i-1) * J + 1 : i * J) = ...
            diag(D2(i,:)) * Vt * diag(D1(i,:)) * Zt;
    end

    W = unfoldX / F; % Paper gebruikt F^T (lijkt verkeerd)
end

function [D2] = updateD2(X, W, Vt, Zt, D1, K, r2)
    D2 = zeros(K, r2);
    for k=1:K
        Fk = Zt' * diag(D1(k,:)) * Vt';
        xk = reshape(X(:,:,k), numel(X(:,:,k)), 1);

        D2(k,:) = (kr(Fk, W) \ xk)'; % transpose van kathri-rao nodig (?)
    end
end

% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [Vt] = updateVt(X, W, D1, D2, Zt, I, J, K, r1, r2)
    x = zeros(I*J*K, 1);
    for k=1:K
        x((k-1) * I * J + 1 : k * I * J, :) = reshape(X(:,:,k), 1, numel(X(:,:,k)));
    end

    Z = zeros(I*J*K, r1 * r2);
    for i=1:K
        Z((i-1) * I * J + 1 : i * I * J, :) = ...
            kron(Zt'*diag(D1(i,:)), W*diag(D2(i,:)));
    end

    vt = Z \ x; 

    Vt = reshape(vt, r2, r1); % Afhankelijk van hoe reshape gebeurd kan dit fout zijn
end

function [D1] = updateD1(X, W, Vt, Zt, D2, K, r1)
    D1 = zeros(K, r1);
    for k=1:K
        Fk = W * diag(D2(k,:))' * Vt;
        xk = reshape(X(:,:,k)', numel(X(:,:,k)), 1);

        D1(k,:) = (kr(Fk, Zt') \ xk)'; % transpose van kathri-rao nodig (?)
    end
end

% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [Zt] = updateZt(X, W, D1, Vt, D2, I, J, K, r1)
    unfoldX = zeros(I*K, J);
    for i=1:K
        unfoldX((i-1) * I + 1 : i * I,:) = X(:,:,i);
    end

    F = zeros(I * K, r1);
    for i=1:K
        F((i-1) * I + 1 : i * I,:) = ...
            W*diag(D2(i,:))*Vt*diag(D1(i,:));
    end

    Zt = F \ unfoldX; % Paper gebruikt F^T (lijkt verkeerd)
end
