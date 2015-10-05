clear all
close all
clc

% Test ground track

% Given values
mu = 3.986e5; % km^3/s^2
a = 20000; % semi-major axis in km
e = 0.25; 
i = 40; % i in degrees
om = 300; % longitude of ascending node in degrees
w = 0; % Argument of periapsis in degrees
theta0 = 80; % True anomaly in degrees

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
lon(lon < 0) = lon(lon < 0) + 360;
jump = find(lon > 180);
nojump = find(lon <= 180);
lon(jump) = lon(jump) - 360;

% Read in coastline map from coastline.txt and plot
coastline = dlmread('coastline.txt','\t');

h1 = plot(coastline(:,1),coastline(:,2),'k');
axis([-180 180 -90 90])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
hold on
h2 = plot(-180:180,0,'k');
% Need to plot separate curves to avoid a line across the whole mep
h3 = plot(lon(nojump),lat(nojump),'r');
h4 = plot(lon(jump),lat(jump),'r');

% Now find the locations in part (b) and plot them

% Ascending Node is the point where latitude goes from negative to positive
% We take whichever point is closest to 0 latitude
latUp1 = [lat(2:end);lat(1)];
neg = find(lat < 0);
pos = find(latUp1 > 0);
an1 = neg(ismember(neg,pos));
an2 = an1 + 1;
% Linear interpolation to find (geographical) longitude of ascending node
lonAN = lon(an1) - (lon(an2)-lon(an1))/(lat(an2)-lat(an1))*lat(an1);

% Descending Node is the point where latitude goes from positive to
% negative
% We take whichever point is closest to 0 latitude
latDown1 = [lat(end);lat(1:end-1)];
neg = find(lat < 0);
pos = find(latDown1 > 0);
dn1 = neg(ismember(neg,pos)) - 1;
dn2 = dn1 + 1;
% Linear interpolation to find (geographical) longitude of descending node
lonDN = lon(dn1) - (lon(dn2)-lon(dn1))/(lat(dn2)-lat(dn1))*lat(dn1);

h5 = plot(lonAN,0,'go');
h6 = plot(lonDN,0,'g+');

% Plot max/min lat
maxLat = find(lat == max(lat));
minLat = find(lat == min(lat));
h7 = plot(lon(maxLat),lat(maxLat),'mo');
h8 = plot(lon(minLat),lat(minLat),'m+');

% Periapsis/apoapsis
R = sqrt(sum(r.*r,2));
peri = find(R == min(R));
apo = find(R == max(R));
h9 = plot(lon(peri),lat(peri),'bo');
h10 = plot(lon(apo),lat(apo),'b+');

% Plot current position
h11 = plot(lon(1),lat(1),'r.');

legend([h5 h6 h7 h8 h9 h10 h11],'Ascending Node','Descending Node','Maximum Latitude','Minimum Latitude','Periapsis','Apoapsis','Current Satellite Position')







