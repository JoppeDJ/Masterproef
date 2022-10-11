function [weightList, Hlist, coefList] = generalCTD(Jlist, BFlist, Rlist, sampleList)
%generalCTD general Constrained tensor based approach
%   Constrained tensor based approach for learning flexbile activation
%   functions. More general than the standard CTD in the sense that this
%   method allows for learning multiple layers with flexible activation
%   functions.

[m, ~] = size(Jlist);

weightList = cell(2*m,1);
Hlist = cell(m,1);
coefList = cell(m,1);

[weightList{1}, weightList{2}, Hlist{1}, coefList{1}] = ...
    CTD(Jlist{1}, BFlist{1}, Rlist{1}, sampleList{1});

for i= 3:2:2*m
  [weightList{i}, weightList{i+1}, Hlist{(i+1) / 2}, coefList{(i+1)/2}] = ...
    CTD(Jlist{(i+1)/2}, BFlist{(i+1)/2}, Rlist{(i+1)/2}, sampleList{(i+1)/2});%, weightList{i}');
end

%weightList = flipud(weightList);
%coefList = flipud(coefList);
end

