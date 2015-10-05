% Problem 2

function posvel = orbel2posvel(orbel,mu)

% This function takes in a 6x1 vector containing the 6 classical orbital
% elements organized as such, with angles in degrees:

% orbel(1) = eccentricity e
% orbel(2) = semi-major axis a
% orbel(3) = true anomaly theta 
% orbel(4) = inclination i
% orbel(5) = argument of periapsis w
% orbel(6) = longitude of ascending node om

% And then calculates the r and v vectors in the ECI frame. Output is 
% posvel, a 3x2 array whose first column is r and second column is v

e = orbel(1);
a = orbel(2);
theta = orbel(3);
i = orbel(4);
w = orbel(5);
om = orbel(6);

p = a*(1-e^2);
r = p/(1+e*cosd(theta));

% First get rvec and vvec in perifocal coordinates
ie = [1;0;0];
ip = [0;1;0];

rP = r*cosd(theta)*ie + r*sind(theta)*ip; % rvec in perifocal coordinates
vP = sqrt(mu/p)*(-sind(theta)*ie + (e+cosd(theta))*ip);

% Now tranform to ECI - use BMW transformation matrix

R11 = cosd(om)*cosd(w) - sind(om)*sind(w)*cosd(i);
R12 = -cosd(om)*sind(w) - sind(om)*cosd(w)*cosd(i);
R13 = sind(om)*sind(i);
R21 = sind(om)*cosd(w) + cosd(om)*sind(w)*cosd(i);
R22 = -sind(om)*sind(w) + cosd(om)*cosd(w)*cosd(i);
R23 = -cosd(om)*sind(i);
R31 = sind(w)*sind(i);
R32 = cosd(w)*sind(i);
R33 = cosd(i);

Cm = [R11,R12,R13;R21,R22,R23;R31,R32,R33];

rvec = Cm*rP;
vvec = Cm*vP;

posvel = [rvec,vvec];


end