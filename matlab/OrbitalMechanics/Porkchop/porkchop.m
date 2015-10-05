clear all
close all
clc

% This script will generate a porkchop plot for the Rumplestiltskian
% transfer orbit in HW 6 problem 4
% Capital R and V are vectors; lowercase are magnitudes

mu = 1;
dt = 2*pi/50;
tL = 0:dt:(4*pi);
tA = (pi/2):dt:(9*pi/2);
N = length(tL);
abstol = 1e-7;
maxit = 100;

%[rvecf,vvecf,table,xf,res,counter] = utof(rvec0,vvec0,tf,mu,abstol,maxit)

RE0 = [1;0;0];
VE0 = [0;1;0];

% Rumplestiltskin's initial state
RA0 = [1.4;0;0.2];
VA0 = [0.3;0.6;0.15];

% Get a TOF for each value of tL and tA; each (i,j) value in the NxN
% matrix TOF is tA(j) - tL(i)

TOF = zeros(N);
deltaV = TOF;
for i = 1:N
    jstart = max(ceil(i-pi/2/dt)+1,1);
    for j = jstart:N
        % Use utof to propagate Earth's orbit to tL and Rumplestiltskin's 
        % orbit to tA
        TOF(i,j) = tA(j) - tL(i);
        
        [R1,VE1] = utof(RE0,VE0,tL(i),mu,abstol,maxit);
        [R2,VA2] = utof(RA0,VA0,tA(j),mu,abstol,maxit);
        % Now we have the initial and final velocities, and the TOF
        % Use p-iteration to solve for V1 and V2 (get min between shortway
        % and longway)
        [V1S,V2S] = pit(R1,R2,TOF(i,j),1,mu);
        [V1L,V2L] = pit(R1,R2,TOF(i,j),0,mu);
        
        dvShort = norm(VA2-V2S) + norm(V1S-VE1);
        dvLong = norm(VA2-V2L) + norm(V1L-VE1);
        dv = min(dvShort,dvLong);
        deltaV(i,j) = dv;
    end
end

deltaV(deltaV==0) = NaN;

cont = [0.25;0.5;0.75;1.0;1.5;2.0;2.5;3.0];
contourf(tL,tA,deltaV',cont)
colorbar

% Plot the orbits
figure
% Min dV is at i=22,j=60
% Min dV for 2nd window is at i=37,j=47
i = 37;
j = 47;

TOF(i,j) = tA(j) - tL(i);
        
[R1,VE1] = utof(RE0,VE0,tL(i),mu,abstol,maxit);
[R2,VA2] = utof(RA0,VA0,tA(j),mu,abstol,maxit);
% Now we have the initial and final velocities, and the TOF
% Use p-iteration to solve for V1 and V2 (get min between shortway
% and longway)
[V1S,V2S] = pit(R1,R2,TOF(i,j),1,mu);
[V1L,V2L] = pit(R1,R2,TOF(i,j),0,mu);

dvShort = norm(VA2-V2S) + norm(V1S-VE1);
dvLong = norm(VA2-V2L) + norm(V1L-VE1);
dv = min(dvShort,dvLong);
deltaV(i,j) = dv;

[RA2,VA2] = utof(RA0,VA0,tA(j),mu,abstol,maxit);
[RA1,VA1] = utof(RA0,VA0,tL(i),mu,abstol,maxit);
[RE1,VE1] = utof(RE0,VE0,tL(i),mu,abstol,maxit);
[RE2,VE2] = utof(RE0,VE0,tA(j),mu,abstol,maxit);


plotDV(RE1,VE1,RA1,VA1,RE1,V1L,tL(i),tA(j),mu)


