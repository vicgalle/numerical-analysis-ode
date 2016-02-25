function f = funcdeppresa(~, x, par)
a = par(1); b = par(2);
c = par(3); d = par(4);

f = [a*x(1)-b*x(1)*x(2); -c*x(2)+d*x(1)*x(2)];
end