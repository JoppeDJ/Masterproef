function [wFac, vFac, hFac, zFac, coefList] = Spec_CMTF(J, F, slice_points, ...
    bfList, rankList, fit_param, samples)
%SPEC_DEC Summary of this function goes here
%   Detailed explanation goes here

JacList = {};
FList = {};
[n1, ~, ~] = size(J);
[n2, ~] = size(slice_points);

slice_start = 1;
for i=1:n2+1
    if i == n2+1
        slice_end = n1;
    else
        slice_end = slice_points(i);
    end

    JacList{end +1} = J(slice_start:slice_end,:,:);
    FList{end +1} = F(slice_start:slice_end,:);

    if i ~= n2+1
        slice_start = slice_points(i) + 1;
    end
end

vFac = {};
wFac = {};
hFac = {};
zFac = {};
coefList = {};

for i=1:n2+1
    [wFac{end + 1}, vFac{end + 1}, hFac{end + 1}, zFac{end + 1}, coefList{end + 1}] = ...
        CMTF(JacList{i}, FList{i}, bfList{i}, rankList(i), fit_param, samples);
end

end

