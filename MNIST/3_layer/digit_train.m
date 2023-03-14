
% Classical MNIST
data = load('mnist_train.csv');

% MNIST-1D
%data = load('mnist1d_train.csv');

labels = data(:,1);
y = zeros(10,size(data,1)); %Correct outputs vector
for i = 1:size(data,1)
    y(labels(i)+1,i) = 1;
end

images = data(:,2:size(data,2));
images = images/255;

images = images'; %Input vectors

hn1 = 80; %Number of neurons in the first hidden layer
hn2 = 60; %Number of neurons in the second hidden layer
hn3 = 40; %Number of neurons in the second hidden layer

%Initializing weights and biases
w12 = randn(hn1,size(data,2) - 1)*sqrt(2/(size(data,2) - 1));
w23 = randn(hn2,hn1)*sqrt(2/hn1);
w34 = randn(hn3,hn2)*sqrt(2/hn2);
w45 = randn(10,hn3)*sqrt(2/hn3);

b12 = randn(hn1,1);
b23 = randn(hn2,1);
b34 = randn(hn3,1);
b45 = randn(10,1);

%learning rate
eta = 0.0058;

%Initializing errors and gradients
error5 = zeros(10,1);
error4 = zeros(hn3,1);
error3 = zeros(hn2,1);
error2 = zeros(hn1,1);
errortot5 = zeros(10,1);
errortot4 = zeros(hn3,1);
errortot3 = zeros(hn2,1);
errortot2 = zeros(hn1,1);
grad5 = zeros(10,1);
grad4 = zeros(hn3,1);
grad3 = zeros(hn2,1);
grad2 = zeros(hn1,1);

epochs = 50;

m = 10; %Minibatch size

for k = 1:epochs %Outer epoch loop
    
    batches = 1;
    
    for j = 1:size(data,1)/m
        error5 = zeros(10,1);
        error4 = zeros(hn3,1);
        error3 = zeros(hn2,1);
        error2 = zeros(hn1,1);
        errortot5 = zeros(10,1);
        errortot4 = zeros(hn3,1);
        errortot3 = zeros(hn2,1);
        errortot2 = zeros(hn1,1);
        grad5 = zeros(10,1);
        grad4 = zeros(hn3,1);
        grad3 = zeros(hn2,1);
        grad2 = zeros(hn1,1);

        for i = batches:batches+m-1 %Loop over each minibatch
        
            %Feed forward
            a1 = images(:,i);
            z2 = w12*a1 + b12;
            a2 = elu(z2);
            z3 = w23*a2 + b23;
            a3 = elu(z3);
            z4 = w34*a3 + b34;
            a4 = elu(z4); 
            z5 = w45*a4 + b45;
            a5 = elu(z5); %Output vector
            
            %backpropagation
            error5 = (a5-y(:,i)).*elup(z5);
            error4 = (w45'*error5).*elup(z4);
            error3 = (w34'*error4).*elup(z3);
            error2 = (w23'*error3).*elup(z2);
               
            errortot5 = errortot5 + error5;
            errortot4 = errortot4 + error4;
            errortot3 = errortot3 + error3;
            errortot2 = errortot2 + error2;
            
            grad5 = grad5 + error5*a4';
            grad4 = grad4 + error4*a3';
            grad3 = grad3 + error3*a2';
            grad2 = grad2 + error2*a1';
    
        end
    
        %Gradient descent
        w45 = w45 - eta/m*grad5;
        w34 = w34 - eta/m*grad4;
        w23 = w23 - eta/m*grad3;
        w12 = w12 - eta/m*grad2;
        b45 = b45 - eta/m*errortot5;
        b34 = b34 - eta/m*errortot4;
        b23 = b23 - eta/m*errortot3;
        b12 = b12 - eta/m*errortot2;
        
        batches = batches + m;
    
    end
    fprintf('Epochs:');
    disp(k) %Track number of epochs
    [images,y] = shuffle(images,y); %Shuffles order of the images for next epoch
end

disp('Training done!')
%Saves the parameters
% save('MNIST/3_layer/final_parameters/wfive.mat','w45');
% save('MNIST/3_layer/final_parameters/wfour.mat','w34');
% save('MNIST/3_layer/final_parameters/wthree.mat','w23');
% save('MNIST/3_layer/final_parameters/wtwo.mat','w12');
% 
% save('MNIST/3_layer/final_parameters/bfive.mat','b45');
% save('MNIST/3_layer/final_parameters/bfour.mat','b34');
% save('MNIST/3_layer/final_parameters/bthree.mat','b23');
% save('MNIST/3_layer/final_parameters/btwo.mat','b12');

save('MNIST/3_layer/parameters/wfive.mat','w45');
save('MNIST/3_layer/parameters/wfour.mat','w34');
save('MNIST/3_layer/parameters/wthree.mat','w23');
save('MNIST/3_layer/parameters/wtwo.mat','w12');

save('MNIST/3_layer/parameters/bfive.mat','b45');
save('MNIST/3_layer/parameters/bfour.mat','b34');
save('MNIST/3_layer/parameters/bthree.mat','b23');
save('MNIST/3_layer/parameters/btwo.mat','b12');