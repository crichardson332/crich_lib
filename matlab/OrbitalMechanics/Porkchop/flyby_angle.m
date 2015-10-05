clear all
close all
clc

% This script will generate flyby bending angle

% Planetary mu values in km^3/s^2 - Mercury(1), Venus(2), Earth(3),
% Mars(4), Jupiter(5), and Saturn(6)
mu = zeros(6,1);
mu(1) = 22032;
mu(2) = 324859;
mu(3) = 398600.4418;
mu(4) = 42828;
mu(5) = 126686534;
mu(6) = 37931187;

N = 100;

Rp = [2440;6052;6378;3397;71492;60268];

% vinf in km/s
vinf = linspace(1,100,N);

% rp in km
rp = 1000+Rp; 
delta = zeros(6,N);
for i = 1:6
    delta(i,:) = 2*asin(1./sqrt(ones(1,N)+vinf.^4.*rp(i)^2/mu(i)^2+2*vinf.^2*rp(i)/mu(i)));
end

% Convert to degrees
delta = delta*180/pi;

figure;hold on;
colors = {'b','r','g','k','m','c'};

for i = 1:6
    plot(vinf,delta(i,:),colors{i})
end

xlabel('V_{\infty} (km/s)','FontSize',18)
ylabel('\delta (deg)','FontSize',18)
h_legend = legend('Mercury','Venus','Earth','Mars','Jupiter','Saturn');
set(h_legend,'FontSize',30);
