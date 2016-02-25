mispracticas;
[t ,u]= ode45(fun, tinic:((tfin-tinic)/N):tfin, x0);
u = u.';
misgraficas;