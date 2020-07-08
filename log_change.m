function y = log_change(x,c)
x = double(x);
y = c*log(x+1);
y = uint8(y);
end