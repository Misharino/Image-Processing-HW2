function [newImag] = gausFilter(imag, x, y, sigmaX, sigmaY)
% Apply a gausian kernel (filtering) smoothing on an image.
% guasFilter(imag, x, y, sigmaX, sigmaY) - where imag is the target image,
% x is the horizontal demension of the kernel, y is the vertical dimension
% of the kernel, sigmaX is the var of the X axis and sigma Y is the var of
% the Y axis.
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

    G = (1 / (sqrt(2 * pi * sigmaX * sigmaY))) * exp(-(X.^2 / (2 * sigmaX^2) + Y.^2 / (2 * sigmaY^2)));
    kernel = G./sum(G(:));

    newImag = conv2(imag, kernel, 'same');
    newImag = uint8(newImag);

end

