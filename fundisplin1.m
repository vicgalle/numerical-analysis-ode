function dx = fundisplin1(t, x, pqr)

dx(1) = x(2);
%dx(2) = feval(pqr{1},t)*x(2) + feval(pqr{2},t)*x(1) + feval(pqr{3},t);
dx(2) = pqr{1}(t)*x(2) + pqr{2}(t)*x(1) + pqr{3}(t);