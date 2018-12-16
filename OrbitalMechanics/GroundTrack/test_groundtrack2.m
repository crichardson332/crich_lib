clear all
close all
clc

% Test ground track

% First try inclinations of 15,30,45,60,90
a = 42164.2; % a of Geo
e = 0; % Give some eccentricity so the grountracks are not just straight lines
om = 0;
w = 0;
theta0 = 0;

% Read in coastline for plot
coastline = dlmread('coastline.txt','\t');
% Given values
mu = 3.986e5; % km^3/s^2

i = 15;

[lon,lat] = groundtrack(a,e,i,om,w,theta0);
% Plot the coastline first
h1 = plot(coastline(:,1),coastline(:,2),'k');
axis([-180 180 -90 90])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
hold on
h2 = plot(-180:180,0,'k');

h3 = plot(lon,lat,'c');

i = 30;
[lon,lat] = groundtrack(a,e,i,om,w,theta0);
h4 = plot(lon,lat,'b');

i = 45;
[lon,lat] = groundtrack(a,e,i,om,w,theta0);
h5 = plot(lon,lat,'m');

i = 60;
[lon,lat] = groundtrack(a,e,i,om,w,theta0);
h6 = plot(lon,lat,'g');

i = 90;
[lon,lat] = groundtrack(a,e,i,om,w,theta0);
h7 = plot(lon,lat,'r');

legend([h3,h4,h5,h6,h7],'i = 15','i = 30','i = 45','i = 60','i = 90')


% Now vary orbital Period from 0.9*day, 1*day, 1.1*day - choose i = 30
figure
h1 = plot(coastline(:,1),coastline(:,2),'k');
axis([-180 180 -90 90])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
hold on
h2 = plot(-180:180,0,'k');


i = 30;
day = 86164; % sidereal day in sec
P = [0.9;1;1.1]*day;
color = {'r';'b';'g'};
h = zeros(3,1);
for k = 1:3
    a = (mu*(P(k)/2/pi)^2)^(1/3); % Solve for a for each P
    [lon,lat] = groundtrack(a,e,i,om,w,theta0);
    h(k) = plot(lon,lat,color{k});
end
    
legend(h,'P = 0.9 sidereal days','P = 1 sidereal day','P = 1.1 sidereal days')


% Now vary the eccentricity, from 0 by 0.2 to 0.8, i = 30
figure
h1 = plot(coastline(:,1),coastline(:,2),'k');
axis([-180 180 -90 90])
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
hold on
h2 = plot(-180:180,0,'k');

a = 42164.2;
e = [0;0.2;0.4;0.6;0.8];
h = zeros(5,1);

color = {'r';'b';'g';'m',;'c'};

for k = 1:5 % Solve for a for each P
    [lon,lat] = groundtrack(a,e(k),i,om,w,theta0);
    h(k) = plot(lon,lat,color{k});
end

legend(h,'e = 0','e = 0.2','e = 0.4','e = 0.6','e = 0.8')