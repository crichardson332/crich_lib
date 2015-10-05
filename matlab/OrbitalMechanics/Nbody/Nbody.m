clear all
close all
clc

% This file will propagate the equations of motion for the N-body problem
% using ode45
% The units used are arbitrary canonical 


% Set constants
G = 1; % Gravitational constant in m^3/(kg*s^2)
t0 = 0;
secinday = 3600*24; % # seconds ina  day
numDays = 0.01; % Number of days to run simulation for
abstol = 1e-3;
reltol = 1e-3;

% tfinal = secinday*numDays;
tfinal = 10;

% Set masses in kg (Nx1 column vector)
m1 = 20;
m2 = 6;
m3 = 0.3;
m4 = m3;
m5 = m3;

m = [m1;m2;m3;m4;m5];

% Set initial state vector y -> N=5
pos0 = [0;0;
         15;0
         7;-1.5
         9;-1.5;
         14;8]; % initial pos vector [x1,y1,x2,y2,...xN,yN]
     
vel0 = [0;0;
        0;300
        10;-20;
        20;-20;
        0;0] / 100; % initial vel vector [vx1,vy1,vx2,...vxN,vyN]

y0 = [pos0;vel0]; % concatenate pos and vel for init state vector

% Calculate initial center of mass
xcom = (1/sum(m))*sum((m.*pos0(1:2:end)));
ycom = (1/sum(m))*sum((m.*pos0(2:2:end)));

% Now set ode properties and run ode45 to propagate N-body problem

options = odeset('RelTol',reltol,'AbsTol',abstol);
[T,Y] = ode45(@(t,y) gravSI(t,y,m,G),[t0;tfinal],y0,options);

% Extract position and velocity from Y, subtract position of center of mass,
% and convert to km and km/s
Y(:,1:2:end/2) = Y(:,1:2:end/2) - xcom; % Sub xcom from x-values of pos
Y(:,2:2:end/2) = Y(:,2:2:end/2) - ycom; % Sub ycom from y-values of pos

% Calculate constraints
constraints = gravConstraints(Y,m,G);

Y = Y/1000;

plot(Y(:,1),Y(:,2))
hold on
plot(Y(:,3),Y(:,4),'r')
plot(Y(:,5),Y(:,6),'g')
plot(Y(:,7),Y(:,8),'c')
plot(Y(:,9),Y(:,10),'m')

legend('m = 2e25 kg','m = 6e24 kg','m = 3e23 kg','m = 3e23 kg','m = 3e23 kg')

figure

plot(T,(constraints(:,7)-constraints(1,7))/constraints(1,7))


% Body 1 - Red
% Body 2 - Blue
% Body 3 - Green
% Body 4 - Cyan
% Body 5 - Magenta