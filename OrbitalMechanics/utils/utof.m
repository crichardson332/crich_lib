% Problem 6

function [rvecf,vvecf,table,xf,res,counter] = utof(rvec0,vvec0,tf,mu,abstol,maxit)

% This script will solve the universal time of flight problem using
% newton's method; this assumes t0 is 0
% xN starts as the trial value for x

r0 = norm(rvec0);
v0 = norm(vvec0);

% Calculate orbital elements

energy = v0^2/2 - mu/r0;
h = norm(cross(rvec0,vvec0));
ecc = sqrt(1 + 2*energy*h^2/mu^2);

% Initialize x, z, S, C, t, dt/dx, res, and counter (watch for parabolas)
% Initial x is based on method outlined in BMW sect 4.5

if norm(ecc-1) < 1e-3
    z = 0;
    C = 1/2;
    S = 1/6;
    x = 1;
else
    a = -mu/2/energy;
    if energy < 0
        x = sqrt(mu)*tf/a;
    else
        x = sign(tf)*sqrt(-a)*log(-2*mu*tf/(dot(rvec0,vvec0)+sign(tf)*sqrt(-mu*a)*(1-r0/a))/a);
    end
    z = x^2/a;
    C = (1 - cos(sqrt(z)))/z;
    S = (sqrt(z)-sin(sqrt(z)))/sqrt(z^3);
end

t = 1/sqrt(mu)*(x^3*S + dot(rvec0,vvec0)/sqrt(mu)*x^2*C + r0*x*(1-z*S));
dtdx = 1/sqrt(mu)*(x^2*C + dot(rvec0,vvec0)/sqrt(mu)*x*(1-z*S)+r0*(1-z*C));
res = abs(tf - t);
counter = 0;

% Initialize table for tabulating iteration information
table = [counter,x,tf-t,dtdx];

while res>abstol && counter<maxit
    x = x + (tf-t)/dtdx; % new guess for x
    
    % Now update z, S, C, t, dtdx, res, and counter
    if norm(ecc-1) > 1e-3
        z = x^2/a;
        C = (1 - cos(sqrt(z)))/z;
        S = (sqrt(z)-sin(sqrt(z)))/sqrt(z^3);
    end
    t = 1/sqrt(mu)*(x^3*S + dot(rvec0,vvec0)/sqrt(mu)*x^2*C + r0*x*(1-z*S));
    dtdx = 1/sqrt(mu)*(x^2*C + dot(rvec0,vvec0)/sqrt(mu)*x*(1-z*S)+r0*(1-z*C));
    res = abs(tf - t);
    counter = counter + 1;
    % Update table
    table = [table;counter,x,tf-t,dtdx];
end

xf = x;

% Now find rvecf and vvecf using f and g expressions

f = 1 - x^2/r0*C;
g = t - x^3/sqrt(mu)*S;

rvecf = f*rvec0 + g*vvec0;
rf = norm(rvecf);

fdot = sqrt(mu)/(r0*rf)*x*(z*S-1);
gdot = 1 - x^2/rf*C;

vvecf = fdot*rvec0 + gdot*vvec0;