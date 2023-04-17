function [f, grad] = BF2(t, maxl, minl)
    tk = minl + ((k-1)/d) * (maxl - minl);
    f = relu(t - tk);
    grad = dlgradient(f,t);
end

