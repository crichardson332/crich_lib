clear all
close all
clc

dt = 24*3600;
secinorb = 1*365*dt;
G = 6.67384e-11; % G in N*m^2/kg^2

% Set masses in kg (Nx1 column vector)
m = [2e30;5.97e24];

y0 = [0;0;1.5e8;0;0;0;0;3.0e4];
y = y0;

for t = 1:365
    ydot = grav(0,y(:,t),m);
    y = [y, y(:,end) + dt*ydot];
end
    