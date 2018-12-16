clear all
close all
clc

%% This script will generate the contour plot for HW 7 problem 2

mu = 1/(81.3+1);
x1 = -mu;
x2 = 1-mu;

C1 = 3.012147;
C2 = 3.188342;
C3 = 3.172161;
C45 = 2.987997;
C6 = 3.5;
C7 = 4.0;

N = 1001; % Make N odd so there are points on the x and y axes
LB = -1.7;
UB = 1.7;

xmat = ones(N,1)*linspace(LB,UB,N);
ymat = linspace(LB,UB,N)'*ones(1,N);
mumat = mu*ones(N);

rho1 = sqrt((xmat-x1*ones(N)).^2+ymat.^2);
rho2 = sqrt((xmat-x2*ones(N)).^2+ymat.^2);

Cmat = xmat.^2 + ymat.^2 + 2*(1-mumat)./rho1 + 2*mumat./rho2;

XYscale = linspace(LB,UB,N);
contour_scale = [2.987997;3.012147;3.172161;3.188342;3.5;4.0];
h1 = contourf(XYscale,XYscale,Cmat,contour_scale);
colorbar
xlabel('X','FontSize',16)
ylabel('Y','FontSize',16)
hold on

title('Earth-Moon Zero-Velocity Contours','FontSize',18)

%% Script for HW 7 problem 3

% Part (a)
TSPAN = [0,100];
x1 = -mu;
x2 = 1-mu;

S0 = [0.4925060;0.85;0;0;0;0];

odefun = @(TSPAN,S0) CR3BP(TSPAN,S0,mu);
[T,S] = ode45(odefun,TSPAN,S0);

h3 = plot(S(1,1),S(1,2),'m*');
h4 = plot(S(end,1),S(end,2),'g*');
h5 = plot(S(:,1),S(:,2),'r');

% Part (b)
TSPAN = [0,20];

S0 = [1.15;0.00994;0;0;0;0];

odefun = @(TSPAN,S0) CR3BP(TSPAN,S0,mu);
[T,S] = ode45(odefun,TSPAN,S0);

h6 = plot(S(1,1),S(1,2),'m*');
h7 = plot(S(end,1),S(end,2),'g*');
h8 = plot(S(:,1),S(:,2),'w');

legend([h3 h4 h5 h8],'Starting Points','Ending Points','3(a) Trajectory','3(b) Trajectory')

