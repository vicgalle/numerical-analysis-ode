function [ t, u, H, ERROR, rechazo ] = midp45( t0, tfin, x0, h0, hmin, TOL, f, par)
% MÉTODO DE Dormand-Prince

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
a = [ 0 0 0 0 0 0 0;
      1/5 0 0 0 0 0 0;
      3/40 9/40 0 0 0 0 0;
      44/45 -56/15 32/9 0 0 0 0;
      19372/6561 -25360/2187 64448/6561 -212/729 0 0 0;
      9017/3168 -355/33 46732/5247 49/176 -5103/18656 0 0;
      35/384 0 500/1113 125/192 -2187/6784 11/84 0];
  
b_int = [5179/57600 0 7571/16695 393/640 -92097/339200 187/2100 1/40];

b_ext = [35/384 0 500/1113 125/192 -2187/6784 11/84 0];

c= [ 0;
    1/5;
    3/10;
    4/5;
    8/9;
    1;
    1];

hmax = (tfin-t0)/10; % Por ejemplo
fac = 0.9; % Factor de seguridad
facmax = 5; % Factor de contracción/dilatación

% Inicializamos K
K = zeros(7,size(x0,1));


u(:,1) = x0;
t(1) = t0;
h = h0;
H = [];
n = 1;
rechazo = 0;
ERROR = [];

% Se cunple la propiedad FSAL
K(1,:) = f(t(n)+c(1)*h, u(:,n) + h *(a(1,:)*K)',par);

while t(n) < tfin
    
   if t(n)+h > tfin
       h = tfin - t(n);
   end
   
   for i = 2:7
        K(i,:) = f(t(n)+c(i)*h, u(:,n) + h *(a(i,:)*K)',par);
   end
    
   ERR = norm((b_int - b_ext)*K);
   ERROR = [ERROR, ERR];
    
    if ERR < TOL
        u(:,n+1) = u(:,n)+h*(b_ext*K)'; 
        t(n+1) = t(n) + h;
        n = n+1;
        H = [H,h];
    elseif h < hmin
        disp('Paso demasiado pequeño');
        break;
    else
        rechazo = rechazo +1;
    end
    
    h = min(hmax, h*min(facmax, fac*(TOL/ERR)^(1/5)) ); % ##########################################
    K(1,:) = K(7,:);
    %H = [H, h];
end

end

