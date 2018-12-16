function objF = eggCrate(x)

% This function takes in a 2x1 column vector x and calculates the value
% of the egg crate function f(x) and the inequality constraint g(x)

rp = 1e200;

fx = x(1)^2 + x(2)^2 + 25*(sin(x(1))^2 + sin(x(2))^2);
gx = -x(2) - 2*x(1) + 1;
objF = fx + rp*max(gx,0)^2;

% Rosenbrock for testing
% objF = (1-x(1))^2 + 100*(x(2)-x(1)^2)^2;

end