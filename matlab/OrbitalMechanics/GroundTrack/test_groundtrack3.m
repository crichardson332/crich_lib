clear all
close all
clc

% Ground track for sun-synchronous

mu = 3.986e5; % km^3/sec^2
J2 = 1.083e-3; % J2 value for Earth
Na = 100;
Ne = 100;
Re = 6378;
Omdot = 0.986/(24*3600); % cap Omega dot in deg/sec

a = linspace(Re,Re+3000,Na);
e = linspace(0,1,Ne);

% Now solve for e using J2 for sun-synchronous orbit
k1 = length(a);
k2 = length(e);
i = zeros(k2,k1);

for ind1 = 1:k1
    for ind2 = 1:k2
        n = sqrt(mu/a(ind1)^3)*180/pi;
        p = a(ind1)*(1-e(ind2)^2);
        i(ind2,ind1) = acosd(Omdot/(-3/2*n*J2*(Re/p)^2));
    end
    
end

i(imag(i)~=0) = NaN;
surf(a,e,i)


axis([Re Re+3000 0 0.3 90 110]) % Zoom in on area of interest
xlabel('Semi-major axis a (km)','FontSize',18)
ylabel('Eccentricity e','FontSize',18)
zlabel('Inclination i (deg)','FontSize',18)

% Now get space objects

load('catalog_TLEs.mat')

cat = cell2struct(catalog_TLEs, 'all', 1);
cat = [cat.all];

semimajoraxis = [cat.semimajoraxis];
eccentricity = [cat.eccentricity];
inclination = [cat.inclination];

hold on
% De-sample by 10 to ease computation time
scatter3(semimajoraxis(1:10:end),eccentricity(1:10:end),inclination(1:10:end))
        

