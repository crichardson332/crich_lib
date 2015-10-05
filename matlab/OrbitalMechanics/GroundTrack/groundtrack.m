function [lon,lat] = groundtrack(a,e,i,om,w,theta0)

% This script will generate the ground tracks for an orbit defined by the
% input orbital parameters - semi-major axis, eccentricity, inclination,
% longitude of the ascending node, argument of periapsis, and initial true
% anomaly (all in degrees or km)

% Given values
mu = 3.986e5; % km^3/s^2

% Convert from OrbEl to position and velocity
orbel = [e;a;theta0;i;w;om];
posvel = orbel2posvel(orbel,mu);

% Set TSPAN to be one orbit
P = 2*pi*sqrt(a^3/mu);
TSPAN = [0,P];

r0 = posvel(1:3,1);
v0 = posvel(1:3,2);

[r,v,TOUT] = twobody(r0,v0,TSPAN,mu);

% Convert from cartesian position to right ascension (RA) and 
% declination (DE) and altitude (H)

[RA,DE,H] = cart2sph(r(:,1),r(:,2),r(:,3));
% Convert to degrees, add 360 to negative values
RA = RA*180/pi;
DE = DE*180/pi;

RA(RA<0) = RA(RA<0) + 360;
% Account for the earth's rotation to calculate geographic longitude

wEarth = 0.0041780741; % Ang vel of earth in deg/sec
lon = RA - wEarth*TOUT;
lat = DE;

% For ground track, we need longitude values to be between -180 and 180

check = lon < -180 | lon > 180;
while ~isempty(find(check~=0,1))
    lon(check) = lon(check) - 360*sign(lon(check));
    check = lon < -180 | lon > 180;
end

end
