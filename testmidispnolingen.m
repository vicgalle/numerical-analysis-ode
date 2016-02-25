close all
mispracticas;
TOL = 0.01;

tic
[t, u] = midispnolingen(tinic, tfin, N, a, b, ffxfy, C0, C1, TOL, 'secante');
toc
subplot(211)
plot(t, u(1,:), 'r')
hold on
subplot(212)
plot(t, u(2,:), 'g')