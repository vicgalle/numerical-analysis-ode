function M = jacvanderpol(~,x,~)
    M=[  0  1;
        -1-2*x(1)*x(2) -(x(1)^2-1)];
end