close all
mispracticas;
TOL = 0.001;

tic
[t, u] = midispnolin(tinic, tfin, N, a, b, ffxfy, C0, C1, TOL, 'newton');
toc
subplot(211)
plot(t, u(1,:), 'r')
hold on
subplot(212)
plot(t, u(2,:), 'g')