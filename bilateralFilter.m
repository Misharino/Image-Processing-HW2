    function [newImag] = bilateralFilter(imag, x, y, sigmaX, sigmaY, sigmaR)
%Apply a bilateral filter to the image.
% bilatFilter(imag, x, y, sigmaX, sigmaY, sigmaR) - where imag is the target image,
% x is the horizontal demension of the kernel, y is the vertical dimension
% of the kernel, sigmaX is the var of the X axis, sigma Y is the var of
% the Y axis and sigma R is the var of the range factor.
    
        imag = double(imag);
    
        [X, Y] = meshgrid(-floor(x/2):floor(x/2), -floor(y/2):floor(y/2));
        spatialGaussian = exp(-(X.^2/(2*sigmaX^2) + Y.^2/(2*sigmaY^2)));
    
        newImag = zeros(size(imag));
    
        % Pad the image to handle the borders
        padX = floor(x/2);
        padY = floor(y/2);
        paddedImag = padarray(imag, [padY, padX]);
    
        % Perform the bilateral filter
        for i = 1:size(imag, 1)
            for j = 1:size(imag, 2)
                % Extract the local region
                localRegion = paddedImag(i:i+2*padY, j:j+2*padX);
    
                % Calculate the range Gaussian
                rangeGaussian = exp(-((localRegion - imag(i, j)).^2) / (2*sigmaR^2));
    
                % Calculate the combined filter
                combinedFilter = spatialGaussian .* rangeGaussian;
                combinedFilter = combinedFilter / sum(combinedFilter(:));
    
                newImag(i, j) = sum(sum(combinedFilter .* localRegion));
            end
        end
    
        % Convert the result back to the original data type
        newImag = uint8(newImag);
    end
