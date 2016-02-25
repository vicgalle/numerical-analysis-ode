function [ t, u, H, ERROR, rechazo ] = mimetadap( t0, tfin, x0, h0, hmin, TOL, metodo, orden, f, par)
% MÉTODO ADAPTATIVO (ESQUEMA GENERAL EN DOS PASOS)

% DATOS DE ENTRADA
%
% t0 - tiempo inicial
% tfin - tiempo final T
% x0 - valor inicial, columna
% h0 - paso inicial
% hmin - paso mínimo
% TOL - tolerancia para el error local
% método - el que vamos a usar
% orden - de método
% f - rhs de la ode
% par - parámetros

% DATOS DE SALIDA
%
% t - vector fila de tiempos t(n)
% u - matriz de valores x(t(n))
% H - vector fila de pasos
% ERROR - vector fila de errores
% rechazo - número de veces que se rechaza el cálculo

hmax = (tfin-t0)/10; % Por ejemplo
fac = 0.9; % Factor de seguridad
facmax = 5; % Factor de contracción/dilatación

u(:,1) = x0;
t(1) = t0;
h = h0;
H = [];
n = 1;
rechazo = 0;
ERROR = [];

while t(n) < tfin
    
   if t(n)+h > tfin
       h = tfin - t(n);
   end
   
   % x es con 1 paso, xx con 2 pasos
   [~, x] = metodo(t(n), t(n) + h, 1, u(:,n), f, par);
   [~, xx] = metodo(t(n), t(n) + h, 2, u(:,n), f, par);
    
   ERR = norm(x(:,2)-xx(:,3))/h;
   ERROR = [ERROR, ERR];
    
    if ERR < TOL
        u(:,n+1) = x(:,2);
        t(n+1) = t(n) + h;
        n = n+1;
        H = [H, h];
    elseif h < hmin
        disp('Paso demasiado pequeño');
        break;
    else
        rechazo = rechazo + 1;
    end
    
    h = min(hmax, h*min(facmax, fac*(TOL/ERR)^(1/orden)) );
    %H = [H, h];
end

end

