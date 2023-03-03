test = load('mnist_test.csv');
labels = test(:,1);
y = zeros(10,10000);
for i = 1:10000
    y(labels(i)+1,i) = 1;
end

images = test(:,2:785);
images = images/255;

images = images';

we34 = matfile('MNIST/parameters/wfour.mat');
w4 = we34.w34;
we23 = matfile('MNIST/parameters/wthree.mat');
w3 = we23.w23;
we12 = matfile('MNIST/parameters/wtwo.mat');
w2 = we12.w12;
bi34 = matfile('MNIST/parameters/bfour.mat');
b4 = bi34.b34;
bi23 = matfile('MNIST/parameters/bthree.mat');
b3 = bi23.b23;
bi12 = matfile('MNIST/parameters/btwo.mat');
b2 = bi12.b12;
success = 0;
n = 10000;

for i = 1:n
out2 = elu(w2*images(:,i)+b2);
out3 = elu(w3*out2+b3);
out = elu(w4*out3+b4);
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