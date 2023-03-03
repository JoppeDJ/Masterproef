function [Ws, Ds, error] = PARATUCK_Z(A, rList)
%PARATUCK2 Computes PARATUCK2 decomposition of given three-way tensor

    [I, J, K] = size(A);
    nbOfDiags = size(rList, 2);

    Ws = cell(nbOfDiags + 1,1);
    Ds = cell(nbOfDiags,1);
    for i=1:nbOfDiags
        if(i == nbOfDiags)
            Ws{i+1} = randn(I, rList(i));
        else
            Ws{i+1} = randn(rList(i+1), rList(i));
        end

        Ds{i} = randn(K, rList(i));
        
    end

    lastError = 0;
    for i=1:1000
        Ws{1} = updateW0(A, Ws(2:end), Ds, I, J, K, nbOfDiags);

        for j=2:2*nbOfDiags
            ind = floor(log2(j));

            if (mod(j,2) == 0)
                Ds{ind} = updateDind(A, Ws(1:ind), Ds(1:ind-1), ...
                    Ws(ind+1:end), Ds(ind+1:end), K, rList(ind));
            else
                Ws{ind+1} = updateWind(A, Ws(1:ind), Ds(1:ind), ...
                    Ws(ind+2:end), Ds(ind+1:end), I, J, K);
            end
        end

        
        Ws{end} = updateWz(A, Ws(1:end-1), Ds, I, J, K, nbOfDiags);

        apprA = zeros(I, J, K);
        for k=1:K
            apprSlice = 1;
            for j=nbOfDiags:-1:1
                Dj = Ds{j};
                apprSlice = apprSlice * ...
                    Ws{j+1} * diag(Dj(k,:));                                
            end
            apprSlice = apprSlice * Ws{1};
            apprA(:,:,k) = apprSlice;
        end
        
        error = frob(A - apprA)^2 / frob(A)^2;
        if(error < 0.0001 || error >= 1 || abs(error - lastError) < 0.000005)
            break
        end

        lastError = error;
    end
end

% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [W0] = updateW0(A, Ws, Ds, I, J, K, nbOfDiags)
    unfoldA = zeros(I*K, J);
    for i=1:K
        unfoldA((i-1) * I + 1 : i * I,:) = A(:,:,i);
    end
    
    r1 = size(Ds{1},2);
    F = zeros(I * K, r1);
    for i=1:K
        Fi = 1;
        for j=nbOfDiags:-1:1
            Dj = Ds{j};
            Fi = Fi * ...
                Ws{j} * diag(Dj(i,:));
        end
        F((i-1) * I + 1 : i * I,:) = Fi;
    end

    W0 = F \ unfoldA;
end


function [Dind] = updateDind(A, Ws1, Ds1, Ws2, Ds2, K, rind)
    Dind = zeros(K, rind);
    nbOfDiags1 = size(Ds1,1);
    nbOfDiags2 = size(Ds2,1);
    for k=1:K
        FkT = 1;
        for j=nbOfDiags1:-1:1
            Dj = Ds1{j};
            FkT = FkT * ...
                Ws1{j+1} * diag(Dj(k,:));
        end
        FkT = FkT * Ws1{1};

        Gk = Ws2{nbOfDiags2+1};
        for j=nbOfDiags2:-1:1
            Dj = Ds2{j};
            Gk = Gk * ...
                diag(Dj(k,:)) * Ws2{j};
        end

        ak = reshape(A(:,:,k), numel(A(:,:,k)), 1);
        
        Dind(k,:) = (kr(FkT', Gk) \ ak)';
    end
end


% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [Wind] = updateWind(A, Ws1, Ds1, Ws2, Ds2, I, J, K)
    a = zeros(I*J*K, 1);
    for k=1:K
        a((k-1) * I * J + 1 : k * I * J, :) = reshape(A(:,:,k), 1, numel(A(:,:,k)));
    end
    
    nbOfDiags1 = size(Ds1,1);
    nbOfDiags2 = size(Ds2,1);
    r1 = size(Ds1{end},2);
    r2 = size(Ds2{1},2);
    Z = zeros(I*J*K, r1 * r2);
    for i=1:K
        FiT = 1;
        for j=nbOfDiags1:-1:1
            Dj = Ds1{j};
            FiT = FiT * ...
                diag(Dj(i,:)) * Ws1{j};
        end
        Gi = 1;
        for j=nbOfDiags2:-1:1
            Dj = Ds2{j};
            Gi = Gi * ...
                Ws2{j} * diag(Dj(i,:));
        end
        Z((i-1) * I * J + 1 : i * I * J, :) = ...
            kron(FiT', Gi);
    end

    Wind = Z \ a; 

    Wind = reshape(Wind, r2, r1);
end

% Optimalisatie mogelijk: element per element output berekenen i.p.v.
% in 1 keer zoals nu gebeurd.
function [Wz] = updateWz(A, Ws, Ds, I, J, K, nbOfDiags)
    unfoldA = zeros(I, J*K);
    for i=1:K
        unfoldA(:, (i-1) * J + 1 : i * J) = A(:,:,i);
    end

    rz = size(Ds{end},2);
    F = zeros(rz, J*K);
    for i=1:K
        Fi = 1;
        for j=nbOfDiags:-1:1
            Dj = Ds{j};
            Fi = Fi * ...
                diag(Dj(i,:)) * Ws{j};
        end

        F(:,(i-1) * J + 1 : i * J) = Fi;
    end

    Wz = unfoldA / F;
end
