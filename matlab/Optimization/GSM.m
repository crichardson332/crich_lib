function [ak,hx] = GSM(x0,pk,rp,lamp1)

epsilon = 1e-8;

tau = (3-sqrt(5))/2;
aL0 = 0;
aU0 = 2;
aL = aL0;
aU = aU0;
a1 = (1-tau)*aL + tau*aU;
a2 = tau*aL + (1-tau)*aU;


tolerance = 1;

while(tolerance > epsilon)
    
[f1,hx1] = lagrangian_calc(x0+a1*pk,rp,lamp1);
[f2,hx2] = lagrangian_calc(x0+a2*pk,rp,lamp1);

% set new bounds
if (f1 < f2)
    aU = a2;
    a2 = a1;
    a1 = (1-tau)*aL + tau*aU;
else 
    aL = a1;
    a1 = a2;
    a2 = tau*aL + (1-tau)*aU;
end
tolerance = (aU - aL)/(aU0 - aL0);
end

ak = (a1 + a2)/2;
hx = (hx1 + hx2)/2;
end
% 
% % calculate function value
% function fx = func(x)
% x1 = x(1);
% x2 = x(2);
% fx = (1 - x1)^2 + 100*(x2 - x1^2)^2;
% end