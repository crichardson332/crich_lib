% Problem 4

function xf = newton(f,dfdx,x0,abstol,maxit)

% This function takes in function handles f and dfdx, which should
% represent the function of interest f(x) and its derivative with respect to
% x, dfdx(x), each taking in an Nx1 vector x. x0 is the Nx1 initial vector,
% abstol is the absolute tolerance for convergence, and maxit is the
% maximum number of iterations for convergence. This function carries out
% Newton's method to find the zero of f(x) -> f(xf) = 0

% The function dfdx must return the Jacobian of f wrt x, where the
% (i,j)th value in dfdx is df(i)/dx(j) - this function currently assumes
% dfdx is not singular

counter = 0;
tolerance = 10;

%table for hw 3.4 - only works with scalars
%table = [0,x0,f(x0),dfdx(x0),NaN];


while (counter < maxit) && (tolerance > abstol)
    
    xf = x0 - (dfdx(x0))\f(x0); % A\b is a better version of inv(A)*b
            
    tolerance = norm(f(xf));
    counter = counter + 1;
    
    x0 = xf;
    
       
end
end