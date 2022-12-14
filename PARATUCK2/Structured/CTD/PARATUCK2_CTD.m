function [W, D2, Vt, D1, Zt, cD1, cD2] = PARATUCK2_CTD(Jac, bf1, bf2, r1, r2, samples)
%PARATUCK2 Computes PARATUCK2 decomposition of given three-way tensor
%taking into account the neural network structure.

    [I, J, K] = size(Jac);
    d1 = length(bf1);
    d2 = length(bf2);

    lambda1 = 1;
    lambda2 = 1;
    
    cD1 = zeros(r1*d1,1);
    cD2 = zeros(r2*d2,1);
    
    W =randn(I, r2);
    D2 = randn(K, r2);
    Vt = randn(r2, r1);
    D1 = randn(K, r1);
    Zt = randn(r1, J);

    Zt = updateZt(Jac, W, D1, Vt, D2, I, J, K, r1);

    D1 = updateD1(Jac, W, Vt, Zt, D2, K, r1);
    
    Vt = updateVt(Jac, W, D1, D2, Zt, I, J, K, r1, r2);        

    D2 = updateD2(Jac, W, Vt, Zt, D1, K, r2);

    W = updateW(Jac, D2, Vt, D1, Zt, I, J, K, r2);

    lastError = 1e5;
    
    for i=1:100
       
        Zt = updateZt(Jac, W, D1, Vt, D2, I, J, K, r1);

        D1 = updateD1(Jac, W, Vt, Zt, D2, K, r1);
        
        % Projectie strategie
        [cD1, D1] = update_cD1(cD1, D1, Zt, samples, bf1, K, r1, d1, lambda1);

        Vt = updateVt(Jac, W, D1, D2, Zt, I, J, K, r1, r2);        

        D2 = updateD2(Jac, W, Vt, Zt, D1, K, r2);
        
        % Projectie strategie
        [cD2, D2] = update_cD2(cD2, D2, Vt, Zt, samples, cD1, bf1, bf2, K, r2, d2, lambda2);
        
        W = updateW(Jac, D2, Vt, D1, Zt, I, J, K, r2);
    
        apprJac = zeros(I, J, K);
        for j=1:K
            apprJac(:,:,j) = ...
                W * diag(D2(j,:)) * Vt * diag(D1(j,:)) * Zt;
        end
        
        error = frob(Jac - apprJac)^2 / frob(Jac)^2
        if(error < 0.001 || abs(error-lastError) < 0.00005)
            break
        end

        lastError = error;
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

function [cD1, D1] = update_cD1(cD1, D1, Zt, samples, bf1, K, r1, d1, lambda1)
    % Projectiestrategie
    X = zeros(r1*K, r1*d1);
    for l=1:r1
        Xl = zeros(K, d1);
        for j=1:K
            xl = dlarray(Zt(l,:) * samples(:,j));

            for k=1:d1
                [~, grad] = dlfeval(bf1{k},xl);
                Xl(j,k) = grad;
            end
        end
        X(((l-1)*K) + 1:l * K, ((l-1)*d1) + 1:l * d1) = Xl;
    end

    not_converged = true;
    while not_converged
        obj1 = frob(reshape(D1, numel(D1), 1) - X * cD1)^2 + lambda1 * frob(cD1)^2;
        if obj1 < 100
            not_converged = false;
        else
            cD1 = ...
                pinv(X'*X + lambda1 * eye(r1*d1))*X'*reshape(D1, numel(D1), 1);
            for l=1:r1
                D1(:,l) = X(((l-1)*K) + 1:l * K, ((l-1)*d1) + 1:l * d1) * cD1((l-1) * d1 + 1: l * d1);
            end
        end
    end
    %cD1 = (reshape(D1, numel(D1), 1)'/ X')';
end

function [cD2, D2] = update_cD2(cD2, D2, Vt, Zt, samples, cD1, bf1, bf2, K, r2, d2, lambda2)
    % Projectiestrategie
    X = zeros(r2*K, r2*d2);
    for l=1:r2
        Xl = zeros(K, d2);
        for j=1:K
            inner_sample = Zt * samples(:,j);
            sample = applyFlexibleFunctions(inner_sample, cD1, bf1);

            xl = dlarray(Vt(l,:) * sample);

            for k=1:d2
                [~, grad] = dlfeval(bf2{k},xl);
                Xl(j,k) = grad;
            end
        end
        X(((l-1)*K) + 1:l * K, ((l-1)*d2) + 1:l * d2) = Xl;
    end

    not_converged = true;
    while not_converged
        obj2 = frob(reshape(D2, numel(D2), 1) - X * cD2)^2 + lambda2 * frob(cD2)^2;
        if obj2 < 200
            not_converged = false;
        else
            cD2 = ...
                pinv(X'*X + lambda2 * eye(r2*d2))*X'*reshape(D2, numel(D2), 1);
            for l=1:r2
                D2(:,l) = X(((l-1)*K) + 1:l * K, ((l-1)*d2) + 1:l * d2) * cD2((l-1) * d2 + 1: l * d2);
            end
        end
    end

    %cD2 = (reshape(D2, numel(D2), 1)'/ X')';
end

function [result] = applyFlexibleFunctions(inputVec, c, bf)
    d = length(bf);
    n = length(inputVec);
    result = zeros(n,1);

    for i=1:n
        val = 0;
        for j=1:d
            x = dlarray(inputVec(i));
            [f, ~] = dlfeval(bf{j}, x);

            val = val + c((i-1)*d + j) * f;
        end

        result(i) = val;
    end
end
