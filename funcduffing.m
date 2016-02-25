function f = funcduffing(~, x, par)
alfa = par(1);

f = [x(2); -alfa*x(2)-x(1)^3-x(1)];
end