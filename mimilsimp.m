function [t, u] = mimilsimp(t0, tfin, N, x0, f, par)
% MÉTODO DE Milne (4 pasos) con
% Simpson (3 pasos) - Predictor Corrector (O 4)

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

% Inicializamos con RK4
[~,u(:,1:4)] = mirk4(t0,t(4),3,x0,f,par);

% Guardaremos evaluaciones de f para pasar de hacer 4 evaluaciones en cada
% iteración a sólo 1 (en la fase de predicción)
ff = zeros(size(x0,1),N);

for i=1:4
    ff(:,i) = f(t(i),u(:,i),par);
end

% Iteramos N-4+1 veces
for i=4:N
    
    %Predictor. Iteramos una vez con Milne (explícito)
    %para obtener una aproximación del punto fijo (z)
    z = u(:,i-3) + 4*h/3*(2*ff(:,i)-ff(:,i-1)+2*ff(:,i-2));
   
    %Corrector
    u(:,i+1) = u(:,i-1) + h/3*(f(t(i+1),z,par) + 4*ff(:,i) + ff(:,i-1));
    ff(:,i+1) = f(t(i+1),u(:,i+1),par);
end

end