function y = bit_plane(x, plane)
k = 256/(8-plane);
[m n] = size(x);
y = zeros(m,n);
for i = 1:m
    for j = 1:n
        y(i,j) = mod(uint8(x(i,j)/k),2);
    end
end
end