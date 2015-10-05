clear all
close all
clc

% This file will perform a simple orbit propagation in two dimensions by
% propagating the equations of motion in cylindrical coordinates; this is a
% simple two body propagation

% Physical constants
G = 6.674e-11; % Gravitational constant
Me = 5.97219e24; % Mass of the Earth
Re = 6378e3; % Earth radius
mu = G*Me;
Le = 33.7758*pi/180; % Latitude of Van Leer
le = -84.39738*pi/180; % Longitude of Van Leer

% Orbital parameters
i = (52.1)*pi/180; % inclination (rad)
hp = 2284; % Perigee and apogee altitude (km)
ha = 152812;
rp = hp*1e3 + Re; % orbital radius at perigee (m)
ra = ha*1e3 + Re; % orbital radius at apogee (m)
e = (ra - rp)/(ra + rp); % Eccentricity
w = 270*pi/180; % Argument of perigee
Om = 0; % RAAN (set to 0 for convenience)
p = rp*(1 + e);
a = (rp + ra)/2;
T = 2*pi*sqrt(a^3/mu);

% Initial conditions: start at perigee
dt = 10;
r = rp;
theta = 0;
vr = 0;
vtheta = sqrt(mu/p)*(e + 1);
maxit = T/dt + 1; % max iterations
rvec = r;
thetavec = theta;

% Propagate orbit until one orbit is complete or until max iterations
tolerance = 1e-7;
r_n = r;
theta_n = theta;
counter = 0;
dr_n = vr*dt;
dtheta_n = vtheta/r*dt;

tol = 1e4;
while tol > 1e-3 && counter < maxit
    r_np1 = r_n + dr_n;
    theta_np1 = theta_n + dtheta_n;
    dr_np1 = dr_n + (r_n + dr_n/2)*dtheta_n^2 - mu/r_n^2*dt^2;
    dtheta_np1 = dtheta_n - (2*dr_n*dtheta_n)/(r_n + dr_n/2);
    
    rvec = [rvec;r_np1];
    thetavec = [thetavec;theta_np1];
    r_n = r_np1;
    theta_n = theta_np1;
    dr_n = dr_np1;
    dtheta_n = dtheta_np1;
    counter = counter + 1;
    tol = abs(theta_n - 2*pi);   
end

% Convert r and theta into cartesian, perifocal coordinates
xp = rvec.*cos(thetavec);
yp = rvec.*sin(thetavec);
zp = rvec*0;


% Now transform the perifocal coordinates into ECI (geocentric) coordinates

n = numel(xp);

yg = yp;
xg = xp .* cos(i);
zg = zp .* sin(i);


% Now calculate lat and long coordinates of satellite sub point, assuming
% that at t=0, Atlanta, GA was at a longitude of 0 in the ECI frame

wEarth = (2*pi + 1/365.25)/(3600*24); % rotation rate of Earth (rad/s)
dstop = (n-1)*dt; % stopping time
dEarth = 0:wEarth*dt:dstop*wEarth; % Earth's longitudinal change at each time step
dEarth = dEarth';
% Calculate the satellite's latitude and longitude
Ls = asin(zg./sqrt(xg.^2+yg.^2+zg.^2));
ls = atan2(yg,xg) - dEarth;
% Ls and ls are now the latitude and longitude of the SSP, in the
% topocentric frame, as a function of time

polar(thetavec,rvec/1000)





