function dSdt = CR3BP(TSPAN,S0,mu)

% This function calculates the derivative of the state vector for the
% circular restricted 3-body problem
% State vector S is 6x1 = [x;y;z;xdot;ydot;zdot]

x = S0(1);
y = S0(2);
z = S0(3);
xD = S0(4);
yD = S0(5);
zD = S0(6);

dSdt = zeros(length(S0),1);

% CR3BP constants
X1 = -mu;
X2 = 1-mu;
rho1 = sqrt((x-X1)^2 + y^2 + z^2);
rho2 = sqrt((x-X2)^2 + y^2 + z^2);

dSdt(1:3) = S0(4:6);

% xDD, yDD, and zDD
dSdt(4) = 2*yD+x-(1-mu)*(x+mu)/rho1^3-mu*(x-(1-mu))/rho2^3;
dSdt(5) = -2*xD+(1-(1-mu)/rho1^3-mu/rho2^3)*y;
dSdt(6) = -((1-mu)/rho1^3+mu/rho2^3)*z;

end