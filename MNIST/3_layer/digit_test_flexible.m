% Classical MNIST
test = load('mnist_test.csv');

% MNIST-1D
%test = load('mnist1d_test.csv');
labels = test(:,1);
y = zeros(10,size(test,1));
for i = 1:size(test,1)
    y(labels(i)+1,i) = 1;
end

images = test(:,2:size(test,2));
images = images/255;

images = images';

we45 = matfile('MNIST/3_layer/parameters/wfive.mat');
%we45 = matfile('MNIST/3_layer/final_parameters/wfive.mat');
w5 = we45.w45;
we34 = matfile('MNIST/3_layer/parameters/wfour.mat');
%we34 = matfile('MNIST/3_layer/final_parameters/wfour.mat');
w4 = we34.w34;
we23 = matfile('MNIST/3_layer/parameters/wthree.mat');
%we23 = matfile('MNIST/3_layer/final_parameters/wthree.mat');
w3 = we23.w23;
we12 = matfile('MNIST/3_layer/parameters/wtwo.mat');
%we12 = matfile('MNIST/3_layer/final_parameters/wtwo.mat');
w2 = we12.w12;

bi45 = matfile('MNIST/3_layer/parameters/bfive.mat');
%bi45 = matfile('MNIST/3_layer/final_parameters/bfive.mat');
b5 = bi45.b45;
bi34 = matfile('MNIST/3_layer/parameters/bfour.mat');
%bi34 = matfile('MNIST/3_layer/final_parameters/bfour.mat');
b4 = bi34.b34;
bi23 = matfile('MNIST/3_layer/parameters/bthree.mat');
%bi23 = matfile('MNIST/3_layer/final_parameters/bthree.mat');
b3 = bi23.b23;
bi12 = matfile('MNIST/3_layer/parameters/btwo.mat');
%bi12 = matfile('MNIST/3_layer/final_parameters/btwo.mat');
b2 = bi12.b12;
success = 0;
n = size(test,1);

% compute bias correction
% zero = zeros(40,1);
% 
% out2 = elu(w2*zero+b2);
% out3 = elu(w3*out2+b3);
% out4 = elu(w4*out3+b4);
% out = elu(w5*out4+b5);
% 
% out_hat = flexible(out2, We, Vte, Zte, cD1e, cD2e, r1, r2);
% 
% bias_correction = out - out_hat;

for i = 1:n
    % Non compressed part
    out2 = elu(w2*images(:,i)+b2);

    % Compressed part
    out = elu(flexible(out2, We, Vte, Zte, cD1e, cD2e, r1, r2));
    %out = elu(flexibleCPD(out2, W_toy, V_toy, c_toy, r));
    % add bias correction
    %out = out + bias_correction;

    big = 0;
    num = 0;
    for k = 1:10
        if out(k) > big
            num = k-1;
            big = out(k);
        end
    end
    
    if labels(i) == num
        success = success + 1;
    end
end

fprintf('Accuracy: ');
fprintf('%f',success/n*100);
disp(' %');