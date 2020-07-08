function [y, filter] = space_processing(x, layer_size, type, sigma, alpha)
switch type
    case 'sobelx'
        filter = [-1 0 1; -2 0 2; -1 0 1];
    case 'sobely'
        filter = [1 2 1; 0 0 0; -1 -2 -1];
    case 'laplacian'
        filter = fspecial(type, alpha);
    case 'gaussian'
        filter = fspecial(type, layer_size, sigma);
    case 'log'
        filter = fspecial(type,layer_size, sigma);
    case 'average'
        filter = fspecial(type, layer_size);
    otherwise
        filter = [];
end
if strcmp(type, 'median')
    y = medfilt2(x,[layer_size layer_size]);
else
    y = uint8(conv2(x,filter,'same'));
end
end
