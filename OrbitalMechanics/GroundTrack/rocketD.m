function [xD] = rocketD(t,x,extras)

% Derivative function for rocket 

h = x(1);
th = x(2);
hD = x(3);
thD = x(4);
m = x(5);

% Extract extra parameters
Re = extras.Re;
we = extras.we;
mu = extras.mu;
Cd = extras.Cd;
A = extras.A;
mD = extras.mD;
mPay = extras.mPay;
mS = extras.mS;
rho0 = extras.rho0;
h0 = extras.h0;

% Calculated values
rho = rho0*exp(-h/h0);
ve = extras.Isp*extras.g;
% Check for burnout

if m <= mPay + mS
    mD = 0;
end


% Get vrel vector with rdot from problem 6
rdotvec = [hD;thD*(Re+h)];
vrelvec = rdotvec - (Re+h)*we*[0;1];
vrel = norm(vrelvec);

hDD = (Re+h)*thD^2 - mu/(Re+h)^2 - 1/2*Cd*A*rho*vrel*hD/m - ve*hD*mD/m/vrel;

thDD = -2*hD*thD/(Re+h) - 1/2*Cd*A*rho*vrel*(thD-we)/m - ve*(thD-we)*mD/m/vrel;

% hDD = (Re+h)*thD^2 - mu/(Re+h)^2  - ve*hD*mD/m/vrel;
% 
% thDD = -2*hD*thD/(Re+h) - ve*(thD-we)*mD/m/vrel;


% State vector derivative

xD = [hD;thD;hDD;thDD;mD];



end