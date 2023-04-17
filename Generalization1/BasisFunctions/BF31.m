function [f, grad] = BF31(t, maxl, minl)
    f = relu(-t);
    grad = dlgradient(f,t);
end

