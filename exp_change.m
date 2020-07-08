function y = exp_change(x, c, epsilon, gamma)
[n,m] = size(x);
y = zeros(n,m);
x = double(x);
for i = 1:n
    for j = 1:m
        y(i,j) = (c*(x(i,j)+epsilon))^gamma;
    end
end
y = uint8(y);
end