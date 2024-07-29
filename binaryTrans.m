function [newImag] = binaryTrans(imag,c)
% Transfers images either to 1 or 0, depends on the threshold, for uint8.
newImag = (imag > c) * 255;
end

