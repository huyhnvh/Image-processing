function Image = frequency_processing(gray_image, filter_type, H)
    if strcmp(filter_type, 'homomorphie')
        I = im2double(gray_image);
        fftlogim = fft2(log(I + 0.01)); % add 0.01 to avoid log(0) = Inf
        s = H .* fftlogim;
        s = real(ifft2(s));
        Image = exp(s);
    else 
        F = fft2(gray_image);
        Image = real(ifft2(H .* F));
        Image = uint8(Image);
    end
end