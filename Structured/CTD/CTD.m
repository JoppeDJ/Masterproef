function [W, V, H, c] = CTD(J, bf, r, samples)
%CTD Constrained tensor based approach
%   Constrained tensor based approach for learning flexbile activation
%   functions.

[~, m, N] = size(J);
d = length(bf);

X = zeros(r*N, r*d);
c = zeros(r*d,1);

V = rand(m,r);
H = rand(N,r);

lastErr = 0;

for i=1:50
    W = tens2mat(J, 1, [2, 3]) / kr(H,V)';

    V = tens2mat(J, 2, [1, 3]) / kr(H,W)';

    H = tens2mat(J, 3, [1, 2]) / kr(V,W)';

    for l=1:r
        Xl = zeros(N, d);        
        for j=1:N
            xl = dlarray(V(:,l)' * samples(:,j));
        
            for k=1:d
                [~, grad] = dlfeval(bf{k},xl);
                Xl(j,k) = grad;
            end
        end           
        X(((l-1)*N) + 1:l * N, ((l-1)*d) + 1:l * d) = Xl;
    end

    c = (reshape(H, numel(H), 1)'/ X')';
    
    for l=1:r
        H(:,l) = X(((l-1)*N) + 1:l * N, ((l-1)*d) + 1:l * d) * c((l-1) * d + 1: l * d);
    end

    U = {W, V, H};
    err = frob(cpdres(J, U)) / frob(J)
    if (err < 0.005 || abs(err-lastErr) <0.000005)
        break;
    end

    lastErr = err;
end

err
end

