function newImag = edgeFilter(imag)
    % Edge detecting filter using sobel kernel.
    image = double(imag);
        
    Gx = [-1 0 1; -2 0 2; -1 0 1];
    Gy = [1 2 1; 0 0 0; -1 -2 -1];
    
    % Apply Sobel operators
    Ix = conv2(image, Gx, 'same');
    Iy = conv2(image, Gy, 'same');
    
    newImag = sqrt(Ix.^2 + Iy.^2);
    
    newImag = cast(newImag, 'like', imag);
end
