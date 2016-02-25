function [t, u] = midisplin(t0, T, N, a, b, pqr, C0, C1)
% Para una versión optimizada (y detallada con comentarios)
% en la que también se puede usar 
% condiciones tipo Robin, veáse midisplingen.m

if C0 == 0
    if C1 == 0
        % Dirichlet
        [t, v1] = mirk4(t0, T, N, [a;0], @fundisplin1, pqr);
        [~, v2] = mirk4(t0, T, N, [0;1], @fundisplin2, pqr);
        % Construímos la solución del PCL (tb nos llevamos su derivada)
        x = v1(1,:) + (b-v1(1,end))/v2(1,end) * v2(1,:);
        xx = v1(2,:) + (b-v1(1,end))/v2(1,end) * v2(2,:); 
    elseif C1 == 1 
        % Dirichmann
        [t, v1] = mirk4(t0, T, N, [a;0], @fundisplin1, pqr);
        [~, v2] = mirk4(t0, T, N, [0;1], @fundisplin2, pqr);
        % Construímos la solución del PCL (tb nos llevamos su derivada)
        x = v1(1,:) + (b-v1(2,end))/v2(2,end) * v2(1,:);
        xx = v1(2,:) + (b-v1(2,end))/v2(2,end) * v2(2,:); 
    end
elseif C0 == 1
    if C1 == 0
       % Neumlet
       [t, v1] = mirk4(t0, T, N, [0;a], @fundisplin1, pqr);
       [~, v2] = mirk4(t0, T, N, [1;0], @fundisplin2, pqr);
       x = v1(1,:) + (b-v1(1,end))/v2(1,end) * v2(1,:);
       xx = v1(2,:) + (b-v1(1,end))/v2(1,end) * v2(2,:); 
    elseif C1 == 1
       % Neumann
       [t, v1] = mirk4(t0, T, N, [0;a], @fundisplin1, pqr);
       [~, v2] = mirk4(t0, T, N, [1;0], @fundisplin2, pqr);
       x = v1(1,:) + (b-v1(2,end))/v2(2,end) * v2(1,:);
       xx = v1(2,:) + (b-v1(2,end))/v2(2,end) * v2(2,:); 
    end
end

u = [x;xx];

end