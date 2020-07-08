function y = level_change(x, type, sl, sh, a, b)
[m n] = size(x);
y = zeros(m,n);
for i = 1:m
    for j = 1:n
        if(x(i,j)>=a & x(i,j)<=b)
            y(i,j) = sh;
        elseif strcmp(type, 'background')
            y(i,j) = x(i,j);
        elseif strcmp(type, 'no_background')
            y(i,j) = sl;
        end
    end
end
y = uint8(y);
end
            
            