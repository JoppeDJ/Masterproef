% Builds jacobian tensor for splitted network.

clear all
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
for i=1:nb_of_classes %size(images,2)
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
