mispracticas;
h0 = (tfin-tinic)/N;
hmin = 0.0001;
TOL = 10^(-3);
metodo = @mirk4;
orden = 4;
[t, u, H] = mimetadap(tinic, tfin, x0, h0, hmin, TOL,metodo,orden, fun, par);
misgraficas;
figure, plot(t(2:end), H), title('Pasos utilizados')