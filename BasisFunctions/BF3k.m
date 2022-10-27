function [f, grad] = BF3k(t, maxl, minl)
    tk = ((k-1)/(d-1)) * maxl;
    f = relu(t - tk);
    grad = dlgradient(f,t);
end

