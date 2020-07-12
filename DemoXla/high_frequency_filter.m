function Image = high_frequency_filter(gray_image, filter_type, D0, n, c, gammaH, gammaL)
    % high pass frequency filter
    % @ gray_image: input image
    % @ filter_type: "ideal", "gaussian", "butterworth", "homomorphie"
    % @ D0: cut frequency
    % @ n: order of filter, higher for more ringing effect
    % @ c: 
    % @ gammaL, gammaH: parameters of homomorphie filter
    % @-> Image: image after processing

    [M, N] = size(gray_image);
    [U, V] = dftuv(M, N);
    D = sqrt(U.^2 + V.^2);
    % get H
    H = get_H(filter_type, D, D0, n, c, gammaH, gammaL);
    if strcmp(filter_type, 'homomorphie') == 0
        H = 1 - H;
    end
    Image = frequency_processing(gray_image, filter_type, H);
end

