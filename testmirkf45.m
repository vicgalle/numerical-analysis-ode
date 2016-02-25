mispracticas;
h0 = 10^(-2);
hmin = 10^(-6);
TOL = 10^(-6);
[t, u, H] = mirkf45(tinic, tfin, x0, h0, hmin, TOL, fun, par);
misgraficas;
figure, plot(t(2:end), H), title('Pasos utilizados')