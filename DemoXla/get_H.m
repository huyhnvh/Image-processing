function H = get_H(filter_type, D, D0, n, c, gammaH, gammaL)
    switch filter_type
        case 'ideal'
            H = double(D < D0);
        case 'gaussian'
            H = exp(-c .* (D .^ 2) ./ (D0 .^ 2));
        case 'butterworth'
            H = 1 ./ (1 + (D ./ D0) .^ (2 * n));
        case 'homomorphie'
            H = (gammaH - gammaL) .* (1 - exp( -c .* (D .^ 2) ./ (D0 .^ 2))) + gammaL;
        case 'laplacian'
            H = D;
        otherwise
            H = double(D < D0);
    end
end