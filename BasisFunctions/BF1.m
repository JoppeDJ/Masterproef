function [f, grad] = BF1(t, maxl, minl)
    tk = ((k-1)/d) * maxl;
    f = relu(t - tk);
    grad = dlgradient(f,t);
end

