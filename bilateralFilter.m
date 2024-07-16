function [newImag] = bilateralFilter(imag, x, y, sigmaX, sigmaY, sigmaR)
%BILATERALFILTER Summary of this function goes here
%   Detailed explanation goes here
    try
        if mod(x, 2) == 0 || mod(y, 2) == 0
            error('Kernel dimensions must be odd numbers.')
        end

    catch ME
        rethrow(ME);
    end

    imag = double(imag);
    x = -(floor(x/2)):floor(x/2); %Filter locations
    y = -(floor(y/2)):floor(y/2);
    [X Y] = meshgrid(x,y);
    [n m] = size(imag);
    newImag = zeros(n, m);
    
    halfY = floor(y/2);
    halfX = floor(x/2);

    G = (1 / (sqrt(2 * pi * sigmaX * sigmaY))) * exp(-(X.^2 / (2 * sigmaX^2) + Y.^2 / (2 * sigmaY^2)));

    for i = 1:n % x iter
        for j = 1:m % y iter
            iMin = max(i - halfY, 1);
            iMax = min(i + halfY, n);
            jMin = max(j - halfX, 1);
            jMax = min(j + halfX, m);

            startx = i + x(end);
            starty = j + y(end);
            neighbor = imag(startx + x, starty + y); % get values around pixel
            f = (1 / sqrt(2*pi*sigmaR)) * exp(-(neighbor - imag(startx + x, starty + y)).^2 / (2 * sigmaR^2));
            g = G((iMin:iMax) - i + y(end) + 1, (iMin:iMax) - j + x(end + 1));
            prod = g.*f;

            newImag(i, j) = uint8(sum(prod(:) .* neighbor(:)) / sum(prod(:)));
        end
    end

    

end

