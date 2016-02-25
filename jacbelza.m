function M = jacbelza(~,x,par)
alfa = par(1); beta = par(2);
gamma = par(3); delta = par(4);

    M=[  alfa*(-x(2)+1-2*beta*x(1)), alfa*(1-x(1)) ,0;
        -x(2)/alfa, 1/alfa*(-1-x(1)), gamma/alfa;
        delta, 0, -delta];
end