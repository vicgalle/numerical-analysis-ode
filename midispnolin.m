function [t, u] = midispnolin(t0, T, N, a, b, ffxfy, C0, C1, TOL, m)

% Inicialización (parámetro inicial)
% F = Inf;
% if C0 == 0
%    if C1 == 0
%         s = (b-a)/(T-t0);
%    else
%         s = b;
%    end
% else
%     if C1 == 0
%         s=b-(tfin-tinic)*a;
%     else
%         s = (b-a)/(T-t0);
%     end
% end

if strcmp(m,'newton')
%     %Error cometido: F = x(T,s)-b
%     F = Inf; 
%     s = (b-a)/(T-t0);
%     if C0 == 0 && C1 == 0
%         while abs(F) > TOL
%             [t, v] = mirk4(t0, T, N, [a;s;0;1], @fundispnolin, ffxfy);
%             F = v(1,end)-b;
%             % Actualizamos s
%             s = s - F/v(3,end);
%         end
%     elseif C0 == 0 && C1 == 1
%          while abs(F) > TOL
%             [t, v] = mirk4(t0, T, N, [a;s;0;1], @fundispnolin, ffxfy);
%             F = v(2,end)-b;
%             % Actualizamos s
%             s = s - F/v(4,end);
%          end   
%     elseif C0 == 1 && C1 == 0
%         while abs(F) > TOL
%             [t, v] = mirk4(t0, T, N, [s;a;1;0], @fundispnolin, ffxfy);
%             F = v(1,end)-b;
%             % Actualizamos s
%             s = s - F/v(3,end);
%         end
%     elseif C0 == 1 && C1 == 1
%         while abs(F) > TOL
%             [t, v] = mirk4(t0, T, N, [s;a;1;0], @fundispnolin, ffxfy);
%             F = v(2,end)-b;
%             % Actualizamos s
%             s = s - F/v(4,end);
%         end
%     end

    F = Inf; 
    s = (b-a)/(T-t0);
    while abs(F) > TOL
       [t,v] = mirk4(t0,T,N, [a;s;0;1]*(C0<1) + [s;a;1;0]*(C0>0), @fundispnolin, ffxfy); 
       F = v(1+C1, end)-b;
       s = s - F/v(3+C1, end);
    end
    
elseif strcmp(m,'secante')
    
    F = Inf; 
    s = (b-a)/(T-t0);
    ss = Inf;
    while abs(F) > TOL
        [t,v] = mirk4(t0,T,N, [a;s;0;1]*(C0<1) + [s;a;1;0]*(C0>0), @fundispnolin, ffxfy);
        FF = F;
        F = v(1+C1, end) - b;
        saux = s;
        if ss == Inf
            s = s + (b-v(1+C1,end))/(T-t0);
        else
            s = s - F/(F-FF)*(s-ss);
        end
        ss = saux;
    end
    
    
end

% Construímos la solución del PCL (tb nos llevamos su derivada)
u = v(1:2,:);