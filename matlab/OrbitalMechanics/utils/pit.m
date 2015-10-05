function [p,itr,V1,V2] = pit(R1,R2,TOF,shortway)

tolerance = 1e-7;

% Compute known values for R1 and R2 given TOF:
r1 = norm(R1);
r2 = norm(R2);
% v here is delta theta
v = acos(dot(R1,R2)/(r1*r2));
v = v + pi*(v<0);
if v==0||v==pi
    keeprunning = 0;
    f = 0;
    g = 0;
    fdot = 0;
    gdot = 0;
else
    keeprunning = 1;
end
longway = ~shortway;
if longway
    v = 2*pi - v;
end
k = r1*r2*(1-cos(v));
l = r1 + r2;
m = r1*r2*(1+cos(v));
p_i = k/(l+sqrt(2*m));
p_ii = k/(l-sqrt(2*m));



% Initial guess for p: average of p_i and p_ii
p = (p_i + p_ii)/2;
itr = 0;

while(keeprunning)
    itr = itr + 1;
    if shortway
        if p<=p_i
            p = p_i*(1+1/itr);
        end
    else
        if p>=p_ii
            p = p_ii*(1-1/itr);
        end
    end
    
    a = m*k*p/((2*m-l^2)*p^2 + 2*k*l*p-k^2);
    if v == pi
        a = ((TOF/pi)^2)^(1/3);
    end
    f = 1-r2/p*(1-cos(v));
    g = r1*r2*sin(v)/sqrt(p);
    fdot = sqrt(1/p)*tan(v/2)*((1-cos(v))/p-1/r1-1/r2);
    gdot = (1+fdot*g)/f;
    if a==inf
	% p. 188 of BMW has the cubic equation for parabolas
        disp('Parabola')
        break        
    elseif a>=0
        cosE = 1-r1/a*(1-f);
        sinE = -r1*r2*fdot/sqrt(a) ;
        E = atan2(sinE,cosE);
        E = E + 2*pi*(E<0);
        t = g + sqrt(a^3)*(E-sin(E));
        dtdp = -g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))+sqrt(a^3)*(2*k*sinE)/(p*(k-l*p));
    elseif a<0
        coshF = 1-r1/a*(1-f);
        F = acosh(coshF);
        t = g + sqrt(-a^3)*(sinh(F)-F);
        dtdp = -g/(2*p)-3/2*a*(t-g)*((k^2+(2*m-l^2)*p^2)/(m*k*p^2))-sqrt(-a^3)*(2*k*sinh(F))/(p*(k-l*p));
    end
    % Adjust p value using Newtonian Iteration:        
    p = p + (TOF-t)/dtdp;
    keeprunning = abs(TOF-t)>tolerance;
end

V1 = (R2-f*R1)/g;
V2 = fdot*R1 + gdot*V1;
end

