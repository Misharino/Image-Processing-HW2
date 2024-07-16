function [imagNew] = medianFilter(imag, x, y)
    % Median filter kernel.
    % medianFilter(imag, x, y) where imag is the image matrix, x is the
    % horizontal dimension of the kernel and y is the vertical dimension of
    % the kernel.
    % Kernel dimensions must be odd numbers.
    try
        if mod(x, 2) == 0 || mod(y, 2) == 0
            error('Kernel dimensions must be odd numbers.')
        end

    catch ME
        rethrow(ME);
    end

    imagPadded = padarray(imag, [floor(x/2) floor(y/2)]); 

    [n, m] = size(imag);  
    imagNew = zeros(n, m, 'uint8'); %Initiazlize

    x = -(floor(x/2)):floor(x/2); %Filter locations
    y = -(floor(y/2)):floor(y/2);

    for i = 1:n % x iter
        for j = 1:m % y iter
            startx = i + x(end);
            starty = j + y(end);
            neighbor = imagPadded(startx + x, starty + y); % get values around pixel
            vec = neighbor(:); % turn into a 1d
            imagNew(i, j) = median(vec);
        end
    end
end
