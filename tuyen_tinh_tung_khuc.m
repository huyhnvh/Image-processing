function y = tuyen_tinh_tung_khuc(x, r1, s1, r2, s2)
[m n] =  size(x);
y = zeros(m,n);
for i = 1:m
    for j = 1:n
        if(x(i,j)<=r1)
            y(i,j) = double(x(i,j))/r1 * s1;
        elseif(x(i,j)<=r2)
            y(i,j) = double(x(i,j)-r1)/(r2-r1)*(s2-s1);
        else
            y(i,j) = double(x(i,j)-r2)/(255-r2)*(255-s2);
        end
    end
end
y = uint8(y)
end
