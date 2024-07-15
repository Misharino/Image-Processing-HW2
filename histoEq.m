function [equalized_imag] = histoEq(imag, h)
% Perform histogram equalization on the image.
% histoEq(imag, h) - where imag is the image 2d vector and h is the
% histogram count values.

[x y] = size(imag); % size of the image

cdf_h = cumsum(h) / (x*y); % CDF calc

equalized_imag = zeros(size(imag), 'uint8');
for i = 1:x
    for j = 1:y
        equalized_imag(i,j) = (255 * cdf_h(imag(i,j) + 1));
    end
end

end
