% Calculate the numerical gradient of F at x
function grad = grad1(x,rp,lamp1)
x1 = x(1);
x2 = x(2);
delta = 1e-7;

df_dx1 = (lagrangian_calc([x1*(1+delta),x2],rp,lamp1) - lagrangian_calc([x1*(1-delta),x2],rp,lamp1))/(2*x1*delta);
df_dx2 = (lagrangian_calc([x1,x2*(1+delta)],rp,lamp1) - lagrangian_calc([x1,x2*(1-delta)],rp,lamp1))/(2*x2*delta);
grad = [df_dx1;df_dx2];

end