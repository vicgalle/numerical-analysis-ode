function [t, u] = midisplingen(t0, T, N, a, b, pqr, C0, C1)
% Generalizado con condiciones tipo Robin (Ci == 2)
% x'(t0) + a(1)x(t0) = a(2) (C0 == 2)
% x'(T) + b(1)x(T) = b(2)   (C1 == 2)

% Elegimos los valores iniciales para v1 y v2 en función de C0.
% Estos datos se obtienen cambiando la condición en T (*) por otra condición
% en t0, y separando en dos sistemas (uno sin s (particular), el de v1), 
% y otro en el que saquemos la s factor común (homogéneo, el de v2)
% NOTA: si C0 < 2, poner a(1) ~= 0 (aunque no se use)
v0 = [[a(2);0]*(C0 == 0) + [0;a(2)]*(C0 == 1) + [a(2)/a(1);0]*(C0 == 2);
      [0; 1]*(C0 == 0) + [1; 0]*(C0 == 1) + [-1/a(1);1]*(C0 == 2)     ];

% Resolvemos los dos sistemas
[t, v1] = mirk4(t0, T, N, v0(1:2), @fundisplin1, pqr);
[~, v2] = mirk4(t0, T, N, v0(3:4), @fundisplin2, pqr);

% Despejamos s, obteniéndola al imponer que se satisfaga lo resuelto (vi) en
% la condición que hemos quitado al principio (*). Depende de C1.
s = (C1 < 2)*(b(2)-v1(1+C1*(C1 < 2),end))/v2(1+C1*(C1 < 2),end) + (b(2)-v1(2,end)-b(1)*v1(1,end))/(v2(2,end)+b(1)*v2(1,end))*(C1 == 2);

% Reconstruímos la solución
x = v1(1,:) + s * v2(1,:);
xx = v1(2,:) + s * v2(2,:); 
u = [x;xx];

end