function f = funcvanderpol(~, x, par)
alfa = par(1); beta = par(2);

f = [x(2); -x(1)-alfa*(x(1)^2-beta)*x(2)];
end