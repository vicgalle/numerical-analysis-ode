close all
mispracticas;

[t, u] = midisplin(tinic, tfin, N, a, b, pqr, C0, C1);

subplot(211)
plot(t, u(1,:), 'r')
subplot(212)
plot(t, u(2,:), 'g')