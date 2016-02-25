% TODO

function [t, u] = midispnolingen(t0, T, N, a, b, ffxfy, C0, C1, TOL, m)
 
% Funciones F para la obtención del error
if C1 < 2
    Ff = @(v) v(1+C1, end) - b(2);
    Ffp = @(v) v(3+C1, end); % Derivada de Ff resp. s
else
    Ff = @(v) v(2, end) + b(1)*v(1, end) - b(2); 
    Ffp = @(v) v(4, end) + b(1)*v(3, end);
end

if strcmp(m,'newton')
     
    F = Inf; 
    s = (b(2)-a(2))/(T-t0);
    while abs(F) > TOL
       v0 = [a(2);s;0;1]*(C0==0) + [s;a(2);1;0]*(C0==1) + [(a(2)-s)/a(1);s;-1/a(1);1]*(C0==2);
       [t,v] = mirk4(t0,T,N,v0, @fundispnolin, ffxfy); 
       F = Ff(v);
       s = s - F/Ffp(v);
    end
    
elseif strcmp(m,'secante')
    
    F = Inf;
    s = (b(2)-a(2))/(T-t0);
    ss = Inf;
    while abs(F) > TOL
        v0 = [a(2);s;0;1]*(C0==0) + [s;a(2);1;0]*(C0==1) + [(a(2)-s)/a(1);s;-1/a(1);1]*(C0==2);
        [t,v] = mirk4(t0,T,N,v0 , @fundispnolin, ffxfy);
        FF = F;
        F = Ff(v);
        saux = s;
        if ss == Inf
            s = s - F/(T-t0);
        else
            s = s - F/(F-FF)*(s-ss);
        end
        ss = saux;
    end
end

% Construímos la solución del PCL (tb nos llevamos su derivada)
u = v(1:2,:);