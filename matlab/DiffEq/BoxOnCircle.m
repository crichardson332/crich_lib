%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name: BoxOnCircle.m
% Purpose: Simulation of box on circle using
%          Lagrange's equations
% Creation Date: 09-11-2015
% Last Modified:
% Created By: Chris Richardson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

% Parameters
m = 1;
R = 1;
a = 4 / 100;
b = 2;
g = 9.81;
t0 = 0;
tf = 5;

% Initial conditions
phi0 = 0.1;
phi_dot0 = 0.0;
phi10 = 1.0;
phi_dot10 = 0.0;
phi40 = 0.1;
phi_dot40 = 0.0;
X0 = [phi0;phi_dot0];
X20 = [phi10;phi_dot10];
X40 = [phi40;phi_dot40];
a4 = 2.2;

% Derivative function (equation of motion)
X_dot = @(t,X) [X(2);1/(R^2*X(1)^2+a^2/3+b^2/12)*(g*a/2*sin(X(1)) - g*R*X(1)*cos(X(1)) - R^2*X(1)*X(2)^2)];
X2_dot = @(t,X2) [X2(2);1/(R^2*X2(1)^2+a^2/3+b^2/12)*(g*a/2*sin(X2(1)) - g*R*X2(1)*cos(X2(1)) - R^2*X2(1)*X2(2)^2)];
X4_dot = @(t,X4) [X4(2);1/(R^2*X4(1)^2+a4^2/3+b^2/12)*(g*a4/2*sin(X4(1)) - g*R*X4(1)*cos(X4(1)) - R^2*X4(1)*X4(2)^2)];

[T,Y] = ode45(X_dot, [t0 tf], X0);
[T2,Y2] = ode45(X2_dot, [t0 tf], X20);
[T4,Y4] = ode45(X4_dot, [t0 tf], X40);

subplot(2,3,1)
plot(T,Y(:,1))
ylabel('$\phi{}$','interpreter','latex','FontSize',20)
title('$\phi{}_{0}=0.1$ rad','interpreter','latex','FontSize',18)

subplot(2,3,4)
plot(T,Y(:,2))
ylabel('$\dot{\phi{}}$','interpreter','latex','FontSize',20)
xlabel('$t$','interpreter','latex','FontSize',20)

subplot(2,3,2)
plot(T2,Y2(:,1))
title('$\phi{}_{0}=1.0$ rad','interpreter','latex','FontSize',18)

subplot(2,3,5)
plot(T2,Y2(:,2))
xlabel('$t$','interpreter','latex','FontSize',20)

subplot(2,3,3)
plot(T4,Y4(:,1))
title('$a=2.2$ m rad','interpreter','latex','FontSize',18)

subplot(2,3,6)
plot(T4,Y4(:,2))
xlabel('$t$','interpreter','latex','FontSize',20)
