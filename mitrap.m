function [t,u, numfun] = mitrap(t0, tfin, N, x0, f, par, jac, itmax)
% MÉTODO DEL TRAPECIO - orden 2

% DATOS DE ENTRADA
%
% t0 - tiempo inicial
% tfin - tiempo final T
% N - número de pasos
% x0 - valor inicial, columna
% f - rhs de la ode
% par - parámetros
% jac - función con el jacobiano de f
% itmax - número máximo de iteraciones para Newton

% DATOS DE SALIDA
%
% t - vector fila de tiempos t(n)
% u - matriz de valores x(t(n))
% numfun - número de evaluaciones de f

numfun = 0;
dim = size(x0,1);
h = (tfin-t0)/N;

% Inicializamos u con los datos iniciales, y t
u = [x0, zeros(dim,N)];
t = t0:h:tfin;

% Inicializamos z, punto sobre el cual aplicaremos Newton
z = x0;

for i=1:N
    
    % Newton para resolver la ec implícita
    G = z - (u(:,i) + h/2*f(t(i),u(:,i),par))-h/2*f(t(i)+h,z,par);
    DG = eye(dim) - h/2*jac(t(i),z,par);
    numfun = numfun + 2;
    w = DG \ G; % Resolvemos DGw = G
    it = 1;
    while norm(w, inf) >= h^3 && it < itmax
        z = z-w;
        G = z - (u(:,i) + h/2*f(t(i),u(:,i),par))-h/2*f(t(i)+h,z,par);
        DG = eye(dim) - h/2*jac(t(i),z,par);
        numfun = numfun + 2;
        w = DG \ G;
        it = it+1;
    end
    z = z-w;
    % Ahora ya tenemos una buena aproximación z = x(t_n+1)
    u(:,i+1) = u(:,i) + h/2*f(t(i),u(:,i),par) + h/2*f(t(i+1),z,par);
    z = u(:,i+1); % Para la siguiente iteración
end
end

