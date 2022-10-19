function [vWeights, wWeights, coefList] = SPEC_DEC(J, slice_points, bfList, rankList, samples)
%SPEC_DEC Summary of this function goes here
%   Detailed explanation goes here

JacList = {};
[n1, ~, ~] = size(J);
[n2, ~] = size(slice_points);

slice_start = 1;
for i=1:n2
    if i == n2
        slice_end = n1;
    else
        slice_end = slice_points(i);
    end

    JacList{end +1} = J(slice_start:slice_end,:,:);

    if i ~= n2
        slice_start = slice_points(i) + 1;
    end
end

vWeights = {};
wWeights = {};
coefList = {};

for i=1:n2+1
    [wWeights{end + 1}, vWeights{end + 1}, ~, coefList{end + 1}] = ...
        CTD(JacList{i}, bfList{i}, rankList(i), samples);
end

end

