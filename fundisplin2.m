function dx = fundisplin2(t, x, pqr)
dx = zeros(2,1);
dx(1) = x(2);
dx(2) = feval(pqr{1},t)*x(2) + feval(pqr{2},t)*x(1);