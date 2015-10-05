function [] = plotDV(Rearth1,Vearth1,Rast1,Vast1,Rsc1,Vsc1,tL,tA,mu)

% This function will plot the trajectories of the earth, asteroid, and
% capture spacecraft for HW 6 problem 4(b) and (d)


TSPAN = [tL,tA];

[Rearth,Vearth,TOUT] = twobody(Rearth1,Vearth1,TSPAN,mu);
[Rast,Vast,TOUT] = twobody(Rast1,Vast1,TSPAN,mu);
[Rsc,Vsc,TOUT] = twobody(Rsc1,Vsc1,TSPAN,mu);

% 3D plot

plot3(Rearth(:,1),Rearth(:,2),Rearth(:,3));
hold on
plot3(Rast(:,1),Rast(:,2),Rast(:,3),'r');
plot3(Rsc(:,1),Rsc(:,2),Rsc(:,3),'g');
xlabel('Inertial x-position (DU)')
ylabel('Inertial y-position (DU)')
zlabel('Inertial z-position (DU)')
title('3D View')
legend('Earth Orbit','Rumpelstiltskin Orbit','Spacecraft Trajectory')
figure


% X-Y view
subplot(3,1,1)
hold on

plot(Rearth(:,1),Rearth(:,2));
plot(Rast(:,1),Rast(:,2),'r');
plot(Rsc(:,1),Rsc(:,2),'g');
xlabel('Inertial x-position (DU)')
ylabel('Inertial y-position (DU)')

legend('Earth Orbit','Rumpelstiltskin Orbit','Spacecraft Trajectory')

% X-Z view
subplot(3,1,2)
hold on

plot(Rearth(:,1),Rearth(:,3));
plot(Rast(:,1),Rast(:,3),'r');
plot(Rsc(:,1),Rsc(:,3),'g');
xlabel('Inertial x-position (DU)')
ylabel('Inertial z-position (DU)')

% Y-Z view
subplot(3,1,3)
hold on

plot(Rearth(:,2),Rearth(:,3));
plot(Rast(:,2),Rast(:,3),'r');
plot(Rsc(:,2),Rsc(:,3),'g');
xlabel('Inertial y-position (DU)')
ylabel('Inertial z-position (DU)')


end