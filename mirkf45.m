function [ t, u, H, ERROR, rechazo ] = mirkf45( t0, tfin, x0, h0, hmin, TOL, f, par)
% MÉTODO DE Runge-Kutta-Fehlberg

% DATOS DE ENTRADA
%
% t0 - tiempo inicial
% tfin - tiempo final T
% x0 - valor inicial, columna
% h0 - paso inicial
% hmin - paso mínimo
% TOL - tolerancia para el error local
% f - rhs de la ode
% par - parámetros

% DATOS DE SALIDA
%
% t - vector fila de tiempos t(n)
% u - matriz de valores x(t(n))
% H - vector fila de pasos
% ERROR - vector fila de errores
% rechazo - número de veces que se rechaza el cálculo

% Generamos el tablero
a = [ 0 0 0 0 0 0;
      1/4 0 0 0 0 0;
      3/32 9/32 0 0 0 0;
      1932/2197 -7200/2197 7296/2197 0 0 0;
      439/216 -8 3680/513 -845/4104 0 0;
      -8/27 2 -3544/2565 1859/4104 -11/40 0];
  
b_int = [25/216 0 1408/2565 2197/4104 -1/5 0];

b_ext = [16/135 0 6656/12825 28561/56430 -9/50 2/55];

c= [ 0;
    1/4;
    3/8;
    12/13;
    1;
    1/2];

hmax = (tfin-t0)/10; % Por ejemplo
fac = 0.9; % Factor de seguridad
facmax = 5; % Factor de contracción/dilatación

% Inicializamos K
K = zeros(6,size(x0,1));


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
   
   for i = 1:6
        K(i,:) = f(t(n)+c(i)*h, u(:,n) + h *(a(i,:)*K)',par);
   end
    
   ERR = norm((b_int - b_ext)*K);
   ERROR = [ERROR, ERR];
    
    if ERR < TOL
        u(:,n+1) = u(:,n)+h*(b_int*K)';
        t(n+1) = t(n) + h;
        n = n+1;
        H = [H,h];
    elseif h < hmin
        disp('Paso demasiado pequeño');
        break;
    else
        rechazo = rechazo +1;
    end
    
    h = min(hmax, h*min(facmax, fac*(TOL/ERR)^(1/4)) );
    %H = [H, h];
end

end

