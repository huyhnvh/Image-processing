function Image = low_frequency_filter(gray_image, filter_type, D0, n, c, gammaH, gammaL)
    % low pass frequency filter
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
    Image = frequency_processing(gray_image, filter_type, H);
end

