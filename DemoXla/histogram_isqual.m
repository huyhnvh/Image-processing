function y = histogram_isqual(x)
[m n] = size(x);
y = zeros(m,n);
freg = zeros(1,256);
for i = 1:m
    for j = 1:n
        freg(x(i,j)+1) = freg(x(i,j)+1) +1;
    end
end
freg = double(freg);
freg = freg/(m*n);
T = zeros(1,256);
for i = 1:256
    for j = 1:i
        T(i) = T(i) + freg(j);
    end
    index = find(x == i-1);
    y(index) = uint8(255*T(i));
end
end