function [Ax,cost_LC,gx] = analysisFunction(x,rp,lamp,cj,Areq,dtReq)


% Extract design variables
h = x(1);
CL = x(2);
S = x(3);
theta = x(4);
Ppl = x(5);
Peng0 = x(6);

% Areq = 1000;
% dtReq = 10000;

% check hard constraints

% Atmosphere
rho = 0.002377*(1-(6.85e-6)*h)^(4.285);
rho0 = 0.0023769;


% Payload
r = 4.4*Ppl^(1/4)/sec(theta);

% Aav_vec = [7.174e-8*h^2*tan(theta)^2;
%        2*(r^2 - 3.587e-8*h^2);
%        0];
% Aav_find = [5280*r >= h*sec(theta);
%             (h < 5280*r)&(5280*r < h*sec(theta));
%             5280*r < h];
% Aav = Aav_vec(Aav_find)
if 5280*r >= h*sec(theta)
    Aav = 7.174e-8*h^2*tan(theta)^2;
elseif 5280*r < h
    Aav = 0;
else
    Aav = 2*(r^2 - (3.587e-8)*h^2);
end


Wpl = 10 + 20*Ppl;

cost_PL = 100000*sqrt(Ppl)*(1 - sin(theta)^2);


% Engine
Peng_vec = [rho/rho0*Peng0;(rho/rho0)^(0.7)*Peng0];
Peng_find = [Peng0 < 400; Peng0 >= 400];
Peng = Peng_vec(Peng_find);

SFC_vec = [0.65 - 0.0005*Peng0;1 - 0.065*log(Peng0)];
SFC = SFC_vec(Peng_find);

Weng_vec = [1.3*Peng0;0.27*Peng0 + 136];
Weng = Weng_vec(Peng_find);

cost_ENG_vec = [250*Peng0;393000*log(Peng0)-2000000];
cost_ENG = cost_ENG_vec(Peng_find);
       

% Airframe and Performance
dtMaint = 5;
CD = 0.03*(300/S)^(0.1) + 0.02*CL^2;
We = 0.7*S^(3/2) + Weng;
Wf = 0.52*S^(3/2);
V = sqrt((We+Wpl+0.9*Wf)/(0.5*rho*S*CL));
D = CD*0.5*rho*V^2*S;
Pprop = 0.002*D*V;

cost_AF = 540*S^(3/2) + 600000;

dtFlight = 700*sqrt(rho*S)*CL^(3/2)/(SFC*CD)*(1/sqrt(We+Wpl+0.1*Wf) - 1/sqrt(We+Wpl+0.9*Wf));


% Life Cycle Costs
Nav = ceil(Areq/Aav*(1 + dtMaint/dtFlight));
cost_ACQ = cost_AF + cost_ENG + cost_PL;
cost_OP = 0.2*We + 2500;

cost_LC = Nav*(cost_ACQ + dtReq*cost_OP);


% Calculate constraints
gx = ones(12,1);

gx(1) = 80 - S;
gx(2) = S - 800;
gx(3) = -CL;
gx(4) = CL - 1;
gx(5) = -Peng0;
gx(6) = Peng0 - 3000;
gx(7) = 1.1*(Pprop + Ppl) - Peng;
gx(8) = -theta;
gx(9) = theta - pi/3;
gx(10)= -V;
gx(11)= -h;
gx(12)= h - 1/(6.85e-6);
gx(13)= -Ppl;

% Normalize constraints
% gx = gx*cj;
% Calculate the augmented Lagrangian
psi = max(gx,-lamp./(2.*rp));
Ax = cost_LC + sum(lamp.*psi + rp.*psi.^2);

if cj == 1.2
    h
    rho
    rho0
    CD
    D
    V
    CL
    S
    theta
    r
    Ppl
    Pprop
    Peng
    Peng0
    SFC
    We
    Weng
    Wf
    Wpl
    dtFlight
    dtMaint
    dtReq
    Nav
    cost_ENG
    cost_PL
    cost_AF
    cost_ACQ
    cost_OP
    Areq
    Aav


end