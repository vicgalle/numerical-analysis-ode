x = [1/3, 1/3]; % Datos iniciales
N = 20;
for i=3:N+1
   x = [x, funcecdif(x(i-2:i-1))]; 
end
