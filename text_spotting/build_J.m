% Builds jacobian tensor for splitted network.

%clear all
addpath(genpath('./'));

dset = {};
model = {};
classchans = {};

%% Case-insensitive
dset{end+1} = 'eccv2014_textspotting/data/case-insensitive-train.mat';
model{end+1} = 'eccv2014_textspotting/models/cov_first_part.mat';
model{end+1} = 'eccv2014_textspotting/models/cov_second_part.mat';
classchans{end+1} = 2:37;  % ignore background class

%% Load 10 data items from each class

% load data
s = load(dset{1});
images = s.gt.images;

nb_per_class = 10;
nb_of_classes = size(images,2);
random_samples = zeros(24,24,nb_per_class * nb_of_classes);
for i=1:nb_of_classes
    cc = images{i}; % Current Class
    
    msize = numel(cc);
    idx = randperm(msize);
    for j=1:nb_per_class
        random_samples(:,:,(i-1) * nb_per_class + j) = cc{idx(1,j)};
    end
end

%% Send random_samples through first part of the network

nn = cudaconvnet_to_mconvnet(model{1});

input_size = 8 * 8 * 64;

inputs = zeros(input_size,size(random_samples,3));
for i=1:1 %size(random_samples, 3)
    ims = [];
    ims = cat(4, ims, random_samples(:,:,i));
    ims = single(ims);

    % preprocess
    data = reshape(ims, [], size(ims,4));
    mu = mean(data, 1);
    data = data - repmat(mu, size(data,1), 1);
    v = std(data, 0, 1);
    data = data ./ (0.0000001 + repmat(v, size(data,1), 1));
    ims = reshape(data, size(ims));
    
    clear data;

     nn = nn.forward(nn, struct('data', single(ims)));
     
     inputs(:,i) = reshape(squeeze(nn.Xout(:,:,:,:)), input_size, 1);
end

size(inputs)

%% Rebuild second network as fully connected neural network

load('eccv2014_textspotting/models/cov_second_part.mat');

% Hidden layer 1
W8 = squeeze(layer8.weights);
b8 = layer8.biases;

W9 = squeeze(layer9.weights);
b9 = layer9.biases;

W10 = squeeze(layer10.weights);
b10 = layer10.biases;

W11 = squeeze(layer11.weights);
b11 = layer11.biases;

% Hidden layer 2
W13 = squeeze(layer13.weights);
b13 = layer13.biases;

W14 = squeeze(layer14.weights);
b14 = layer14.biases;

W15 = squeeze(layer15.weights);
b15 = layer15.biases;

W16 = squeeze(layer16.weights);
b16 = layer16.biases;

%% Try to get gradient of second part of network

nn2 = cudaconvnet_to_mconvnet(model{2});

[ftest, gtest] = test_part_2(nn2, dlarray(reshape(inputs(:,1), 8,8,64)));

function [f, grad] = test_part_2(net, data)
    net = net.forward(net, struct('data', single(data)));

    f = squeeze(net.Xout(:,:,2:37,:));
    
    outputs = 36;
    grad = zeros(outputs, 4096);
    for i=1:outputs
        grad(i, :) = dlgradient(f(i), data);
    end
end

