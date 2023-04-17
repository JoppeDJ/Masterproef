function [f, grad] = Bf4(t,power)
    f = t^power;
    grad = dlgradient(f, t);
end

