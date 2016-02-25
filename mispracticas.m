% Un corazón
%fun=@funccorazon; x0 = [0; 2]; tinic = 0; tfin = 2*pi; N = 1000; par=[];

% El clásico oscilador
%fun=@funcvanderpol; x0 = [0.4; 0.2]; tinic = 0; tfin = 100; N = 1000;jac=@jacvanderpol; par = [30,1];

% Una ecuación rígida (8)
%fun=@funcrigida; x0 = 0; tinic = 0; tfin = pi/2; N = 300;jac=@jacrigida; par=[];

% Péndulo linealizado y no lineal (9)
fun=@funcpendulolin; x0 = [0.1;0]; tinic=0; tfin=10; N=1000;par=[1.4,1, 9.8];
%fun=@funcpendulo; x0 = [0.1;0]; tinic=0; tfin=10; N=1000;par=[1.4, 0, 1, 9.8];

% Lobos y conejos
%fun = @funcdeppresa; x0 = [100;50]; tinic=0; tfin=100; N=10000; par=[0.4,0.01,0.3,0.005]; 

% Competition
%fun = @funccompet; x0 = [3;2]; tinic=0; tfin=10; N = 1000; par=[1,1,1,0.2,0.4,0.0001];

% Otro oscilador, by Duffing
%fun = @funcduffing; x0 = [0.1;0.05];tinic=0; tfin=10; N = 1000; par=0;

% Prediciendo la atmósfera con Lorenz
%fun = @funclorenz; x0=[0;5;75]; tinic=0; tfin=10; N=10000; par=[10,8/3,100.795];

% Química y rigidez by BZ
%fun=@funbelza; x0 = [0.25;0.75;0.25]; tinic = 0; tfin = 1; N = 30000;jac=@jacbelza; itmax=200; par = [2e4, 8e-4, 5000, 0.75];
%fun=@funbelza; x0 = [0;0.1;1]; tinic = 0; tfin = 10; N = 3000;jac=@jacbelza; itmax=20; par = [2e4, 8e-4, 5000, 0.75];

% Explosión en tiempo finito
%fun=@func22_1; x0 = 1; tinic = 0; tfin = 2; N = 3000; itmax=20; par = [];

% Otra explosión
%fun=@func22_2; x0 = 1; tinic = 0; tfin = 10; N = 3000; itmax=20; par = [];

% Oscilaciones malas para Euler
%fun=@funcoscil; x0 = exp(-1); tinic = 0; tfin = 8; N = 3000; itmax=20; par = [];

% PCL's
%pqr={@(t) 0, @(t) 4, @(t) -4*t};tinic = 0; tfin = 1; N=1000;a=2;b=2;C0=0;C1=0;
%pqr={@(t) 3, @(t) 2, @(t) 3*cos(t)};tinic=0;tfin = 5;N = 3000;a=-2;b=1;C0=0;C1=1;
%pqr={@(t) 0, @(t) cos(t), @(t) t};tinic=0;tfin=10;N=3000;a=-2;b=-1;C0=1;C1=0;
%pqr={@(t) 1-sin(t), @(t) cos(t), @(t) sin(t)};tinic=0;tfin=10;a=-2;b=-1;C1=1;C1=1;

% PCNL's
%ffxfy={@(t,x,y) 2*x^3, @(t,x,y) 6*x^2, @(t,x,y) 0 };tinic = 1; tfin = 2;N= 1000;a=1/2;b=1/3; solexacta = @(t) 1./(1+t);C0=0;C1=0;
%ffxfy={@(t,x,y) 8*x^3, @(t,x,y) 24*x^2, @(t,x,y) 0 };tinic=0;tfin=1;N=10000;a=1/3;b=-2/25;C0=0;C1=1;solex = @(t) 1./(repmat(3,1,N+1)+2*t);
%ffxfy={@(t,x,y) (-t*y+x+t)^3+1/t, @(t,x,y) 3*(-t*y+x+t)^2, @(t,x,y) 3*(-t*y+x+t)^2*(-t) };tinic=1;tfin=exp(1);a=1;b=2;N=1000; solex=@(t) t.*log(t);C0=1;C1=1;
%ffxfy={@(t,x,y) -y^2+x+t, @(t,x,y) 1, @(t,x,y) -2*y };tinic=1;tfin=2;a=0;b=2;N=1000;C0=1;C1=1;
%ffxfy={@(t,x,y) (2*sin(t^2)+8*t^2)*x-4*t^2*x*log(x)+2*t*sin(t^2)*y, @(t,x,y) 2*sin(t^2)+8*t^2-4*t^2*(log(x)+1), @(t,x,y) 2*t*sin(t^2) };tinic = 0; tfin = sqrt(10.5*pi); N = 1000;a=exp(1);b=exp(2); solexacta = @(t) exp(repmat(2,1,N+1)-cos(t.^2));C0=0;C1=0;

% PCL's para gen
%pqr={@(t) 0, @(t) 4, @(t) -4*t};tinic = 0; tfin = 1; N=1000;a=[1,2];b=[2,100];C0=2;C1=1;
%pqr={@(t) 3, @(t) 2, @(t) 3*cos(t)};tinic=0;tfin = 5;N = 3000;a=[1,-2];b=[1,1];C0=0;C1=1;
%pqr={@(t) 0, @(t) cos(t), @(t) t};tinic=0;tfin=10;N=3000;a=[1,-2];b=[1,-1];C0=1;C1=0;
%pqr={@(t) 1-sin(t), @(t) cos(t), @(t) sin(t)};tinic=0;tfin=10;a=[1,-2];b=[1,-1];C1=1;C1=1;

% PCNL's para gen
%ffxfy={@(t,x,y) 2*x^3, @(t,x,y) 6*x^2, @(t,x,y) 0 };tinic = 1; tfin = 2;N= 10000;a=[5,1/2];b=[2,1/3]; solexacta = @(t) 1./(1+t);C0=2;C1=2;
%ffxfy={@(t,x,y) (-t*y+x+t)^3+1/t, @(t,x,y) 3*(-t*y+x+t)^2, @(t,x,y) 3*(-t*y+x+t)^2*(-t) };tinic=1;tfin=exp(1);a=[1,1];b=[3,2];N=1000; solex=@(t) t.*log(t);C0=2;C1=2;
%ffxfy={@(t,x,y) (2*sin(t^2)+8*t^2)*x-4*t^2*x*log(x)+2*t*sin(t^2)*y, @(t,x,y) 2*sin(t^2)+8*t^2-4*t^2*(log(x)+1), @(t,x,y) 2*t*sin(t^2) };tinic = 0; tfin = sqrt(10.5*pi); N = 1000;a=[1,exp(1)];b=[1,exp(2)]; solexacta = @(t) exp(repmat(2,1,N+1)-cos(t.^2));C0=0;C1=0;
%ffxfy={@(t,x,y) 2*x^3, @(t,x,y) 6*x^2, @(t,x,y) 0 };tinic = 1; tfin = 2;N=1000;a=[1,1/2];b=[1/3, 1]; C0=2;C1=2; solexacta = @(t) 1./(1+t); 
