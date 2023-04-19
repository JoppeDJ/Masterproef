warning("off")

bf1 = {@theta1, @theta2, @theta3, @theta4};%, @theta5};%, @theta6, @theta7, @theta8, @theta9, @theta10};
bf1d = {@theta1d, @theta2d, @theta3d, @theta4d};%, @theta5d};
bf2 = {@theta1, @theta2, @theta3, @theta4};%, @theta5};%, @theta6, @theta7, @theta8, @theta9, @theta10};
bf2d = {@theta1d, @theta2d, @theta3d, @theta4d};%, @theta5d};%, @theta6, @theta7, @theta8, @theta9, @theta10};

r1 = 36;
r2 = 36;

tic
[We, D2e, Vte, D1e, Zte, Ht, cD1e, cD2e] = PARATUCK2_CMTF_REG(Jac, F, bf1, bf1d, bf2, bf2d, r1, r2, inputs);
toc

%% Functions

function [f] = theta1(x)
    f = x;
end

function [f] = theta1d(x)
    f = 1;
end

function [f] = theta2(x)
    f = x^2;
end

function [f] = theta2d(x)
    f = 2*x;
end

function [f] = theta3(x)
    f = x^3;
end

function [f] = theta3d(x)
    f = 3*x^2;
end

function [f] = theta4(x)
    f = x^4;
end

function [f] = theta4d(x)
    f = 4*x^3;
end

function [f] = theta5(x)
    f = x^5;
end

function [f] = theta5d(x)
    f = 5*x^4;
end