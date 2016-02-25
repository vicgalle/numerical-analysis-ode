function f = funcpendulolin(~, x, par)
beta = par(1);
l = par(2);    g = par(3);
f = [x(2); -2*beta*x(2)-g/l*x(1)];
end