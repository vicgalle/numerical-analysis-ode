close all
mispracticas;
h0 = 10^(-6);
hmin = 10^(-100);
TOL = 10^(-10);
[t, u, H] = midp45(tinic, tfin, x0, h0, hmin, TOL, fun, par);
misgraficas;
figure, plot(t(2:end), H), title('Pasos utilizados')