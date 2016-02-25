function f = funclorenz(~, x, par)
sigma = par(1); beta = par(2);
rho = par(3);

f = [sigma*(x(2)-x(1)); rho*x(1)-x(2)-x(1)*x(3);x(1)*x(2)-beta*x(3)];
end