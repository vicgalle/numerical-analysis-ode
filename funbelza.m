function f = funbelza(~, x, par)
alfa = par(1); beta = par(2);
gamma = par(3); delta = par(4);

f = [alfa*(x(2)-x(1)*x(2)+x(1)-beta*x(1)^2);1/alfa*(gamma*x(3)-x(2)-x(1)*x(2)); delta*(x(1)-x(3))];
end