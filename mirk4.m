function [t, u] = mirk4(t0, tfin, N, x0, f, par)
% MÉTODO DE RK - orden 4

% DATOS DE ENTRADA
%
% t0 - tiempo inicial
% tfin - tiempo final T
% N - número de pasos
% x0 - valor inicial, columna
% f - rhs de la ode
% par - parámetros

% DATOS DE SALIDA
%
% t - vector fila de tiempos t(n)
% u - matriz de valores x(t(n))

% Definimos el paso h
h = (tfin-t0)/N;

% Generamos el mallado de tiempos
t = t0:h:tfin; % Eq a linspace(t0,tfin,N+1)

% Inicializamos u, añadiendo el valor inicial
u = [x0, zeros(size(x0,1),N)];

% Definimos el tablero
c = [0 1/2 1/2 1];
A = [0  0   0   0; 
    1/2 0   0   0;
    0   1/2 0   0; 
    0   0   1   0];
b = [1/6 2/6 2/6 1/6];

% Inicializamos K = [K1,K2,K3,K4]
K = zeros(size(x0,1),4);

% Iteramos N veces
for i=1:N
    
    % Obtenemos los K
    for j=1:4
        K(:,j) = f(t(i) + h*c(j), u(:,i) + h*K*A(j,:)', par);
    end
    
    u(:,i+1) = u(:,i) + h*K*b';
end

end

