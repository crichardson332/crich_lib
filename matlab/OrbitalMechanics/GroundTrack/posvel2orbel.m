% Problem 2

function orbel = posvel2orbel(rvec,vvec,mu)

% This function takes in position and velocity vectors and
% converts to orbital elements, in the ECI frame; output is a 6x1 vector of
% orbital elements, with angles in degrees:

% orbel(1) = eccentricity e
% orbel(2) = semi-major axis a
% orbel(3) = true anomaly f 
% orbel(4) = inclination i
% orbel(5) = argument of periapsis w
% orbel(6) = longitude of ascending node om

r = norm(rvec);
v = norm(vvec);

hvec = cross(rvec,vvec);
h = norm(hvec);

nvec = cross([0;0;1],hvec);
n = norm(nvec);

evec = 1/mu*(rvec*(v^2 - mu/r) - dot(rvec,vvec)*vvec);
e = norm(evec);

p = h^2/mu;
a = p/(1-e^2);
i = acosd(hvec(3)/h);

if nvec(2) >= 0
    om = acosd(nvec(1)/n);
else
    om = 360 - acosd(nvec(1)/n);
end

if evec(3) >= 0
    w = acosd(dot(nvec,evec)/n/e);
else
    w = 360 - acosd(dot(nvec,evec)/n/e);
end

if dot(rvec,vvec) >=0 
    f = acosd(dot(evec,rvec)/e/r);
else
    f = 360 - acosd(dot(evec,rvec)/e/r);
end

orbel = [e;a;f;i;w;om];

end