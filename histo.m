function [h] = histo(imag)
%Calculates the histogram counts of the image, returns the values.
%histo(imag) - where imag is the image 2d vector.

[x y] = size(imag);

h = zeros(1, 256);

for i = 1:x
    for j = 1:y
        h(imag(i,j) + 1) = h(imag(i,j) + 1) + 1;
    end
end

end

