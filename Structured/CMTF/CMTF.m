function [W, V, H, Z, c] = CMTF(J, F, bf, r, fit_param, samples)
%CTD Constrained tensor based approach
%   Constrained tensor based approach for learning flexbile activation
%   functions.

[~, m, N] = size(J);
d = length(bf);

X = zeros(r*N, r*d);
c = zeros(r*(d+1),1);

V = rand(m,r);
H = rand(N,r);
Z = rand(N,r);

lastErr = 0;

for i=1:150
    %W = (tens2mat(J, 1, [2, 3]) * kr(H,V) + fit_param^2 * F * Z) / ...
    %((H'*H) .* (V'*V) + fit_param^2 * (Z'*Z));
    
    W = [tens2mat(J, 1, [2, 3]) , fit_param * F] / [kr(H,V)', fit_param * Z'];

    V = tens2mat(J, 2, [1, 3]) / kr(H,W)';

    H = tens2mat(J, 3, [1, 2]) / kr(V,W)';

    Z = (W \ F)';

    for l=1:r
        Xl = zeros(N, d+1);
        Yl = ones(N, d+1);
    
        for j=1:N
            xl = dlarray(V(:,l)' * samples(:,j));
        
            for k=2:d+1
                [fval, grad] = dlfeval(bf{k-1},xl);
                Xl(j,k) = grad;
                Yl(j,k) = fval;
            end
        end           
        X(((l-1)*N) + 1:l * N, ((l-1)*(d+1)) + 1:l * (d+1)) = Xl;
        Y(((l-1)*N) + 1:l * N, ((l-1)*(d+1)) + 1:l * (d+1)) = Yl;
    end

    c = [X; (fit_param * Y)] \ ...
        [reshape(H, numel(H), 1); fit_param * reshape(Z, numel(Z), 1)];
    
    for l=1:r
        index1 = ((l-1)*N) + 1:l * N;
        index2 = ((l-1)*(d+1)) + 1:l * (d+1);
        index3 = (l-1) * (d+1) + 1;

        H(:,l) = X(index1, index2) * c(index3: l * (d+1));
        Z(:,l) = Y(index1, index2) * c(index3: l * (d+1));
    end

    U = {W, V, H};
    err = frob(cpdres(J, U)) / frob(J);   
    if (err < 0.005 || abs(err-lastErr) <0.00005)
        break;
    end

    lastErr = err;
end

err
end


