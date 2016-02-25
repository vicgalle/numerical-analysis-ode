function f = funcpendulo(~, x, par)
beta = par(1); M = par(2);
l = par(3);    g = par(4);
f = [x(2); M-2*beta*x(2)-g/l*sin(x(1))];
end