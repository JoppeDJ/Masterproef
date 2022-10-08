function [W, V, H, c] = DPBF(J, r, bf, samples, y)
%DPBF Decoupling Multivariate Polynomial in polynomial basis functions

[n, ~, N] = size(J);
[~, d] = size(bf);

U = cpd(J,r);
err = frob(cpdres(J, U)) / frob(J)

W = U{1};
V = U{2};
H = U{3};

Xk = zeros(N*r,(d+1)*r);
Wblock = zeros(N*n, N*r);
for i=1:N
    X = zeros(r,(d+1)*r);
    points = V' * samples(:,i);

    for j=1:r
        X(j,(j-1)*(d+1) + 1) = 1;
        for k=2:(d+1)
            [f, ~] = dlfeval(bf{k-1}, dlarray(points(j)));
            X(j,(j-1)*(d+1) + k) = f;
        end
    end

    Wblock((i-1)*n+1:i*n, (i-1)*r+1:i*r) = W;
    Xk((i-1)*r+1:i*r, :) = X;
end

Rk = Wblock * Xk;

c = Rk \ y;

end

