function [result] = NMSE(ref, approx)
%TENSOR_NMSE Computes NMSE between reference tensor and approximated tensor.

result = (frob(ref - approx)/ frob(ref))^2;

end

