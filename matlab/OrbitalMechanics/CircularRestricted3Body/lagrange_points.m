clear all
close all
clc

% This script will generate the contour plot for HW 7 problem 2

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

% Now find the 5 Lagrange points - L1, L2, and L3 occur at y=0
% And L4 and L5 occur at y=x

midP = (N+1)/2;
xAxis = Cmat(midP,:);
L1 = find(abs(xAxis-C1)<=1e-5);
L2 = find(abs(xAxis-C2)<=1e-5);
L3 = find(abs(xAxis-C3)<=1e-5);
L45 = find(Cmat==min(min(Cmat)));

LX = [xmat(midP,L1) xmat(midP,L2) xmat(midP,L3)];
h2 = plot(LX,[0 0 0],'m*');
h3 = plot(xmat(L45),ymat(L45),'m*');
legend(h2,'Lagrange Points')

title('Earth-Moon Zero-Velocity Contours','FontSize',18)
