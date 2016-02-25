function [t, u] = mieulertr(t0, tfin, N, x0, f, par)
% M�TODO DE EULER-TRAPECIO - Predictor Corrector

% DATOS DE ENTRADA
%
% t0 - tiempo inicial
% tfin - tiempo final T
% N - n�mero de pasos
% x0 - valor inicial, columna
% f - rhs de la ode
% par - par�metros

% DATOS DE SALIDA
%
% t - vector fila de tiempos t(n)
% u - matriz de valores x(t(n))

% Definimos el paso h
h = (tfin-t0)/N;

% Generamos el mallado de tiempos
t = t0:h:tfin; % Eq a linspace(t0,tfin,N+1)

% Inicializamos u, a�adiendo el valor inicial
u = [x0, zeros(size(x0,1),N)];

% Iteramos N veces
for i=1:N
    
    %Predictor. Iteramos una vez con Euler expl�cito
    %para obtener una aproximaci�n del punto fijo (z)
    ff = f(t(i),u(:,i),par);
    z = u(:,i) + h*ff;
    
    %Corrector
    u(:,i+1) = u(:,i) + h/2*ff + h/2*f(t(i+1),z,par);
end

end

