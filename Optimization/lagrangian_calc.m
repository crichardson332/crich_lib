% Calculate the pseudo-objective function value
function [Ax,gx] = lagrangian_calc(x,rp,lamp1)
x1 = x(1);
x2 = x(2);

fx = (1 - x1)^2 + 100*(x2 - x1^2)^2;
gx = x2 + 2*x1 - 1;

% Augmented lagrangian
psi = max(gx,-lamp1/(2*rp));
Ax = fx + lamp1*psi + rp*psi^2;


end