clear all
close all
clc

% test rocket propagation

% Given values: (do everything in km, rad, kg, s)

extras.Isp = 455;
extras.g = 9.81/1000; % in km/s^2
extras.m0 = 20000;
extras.mS = 2000;
extras.mPay = 1000;
extras.Cd = 0.5;
extras.A = pi/1000^2; % km^2
extras.rho0 = 1.228*1000^3; % kg/km^3
extras.h0 = 8;
extras.mu = 3.986e5;
extras.Re = 6353;
extras.we = 7.2921e-5;
extras.t0 = 0;
extras.tf = 7200;

% Choose mD value
extras.mD = -57;


x0 = [1;0;0.5;extras.we+1.74e-5;extras.m0];

% Propagate the launch using ode45

odefun = @(t,x) rocketD(t,x,extras);

[tout,xout] = ode45(odefun,[extras.t0,extras.tf],x0);

% Plot altitude vs. time

% a = find(xout(:,1)<=0,1); % If h goes to zero, don't plot past that point
% if ~isempty(a)
%     tout = tout(1:a);
%     xout = xout(1:a,:);
% end

plot(tout,xout(:,1),'r')
hold on
m = xout(:,5);
mShift = [m(2:end);m(1)];
burnout = find(abs(m-mShift)<1e-6);
burnout = burnout(1);
plot(tout(burnout),xout(burnout,1),'bo')

xlabel('Time (s)','FontSize',16)
ylabel('h (km)','FontSize',16)

legend('Rocket Trajectory','Burnout')

figure

plot(tout,xout(:,2),'r')
xlabel('Time (sec)','FontSize',16)
ylabel('\theta (rad)','FontSize',16)

figure

plot(tout,xout(:,3),'r')
xlabel('Time (sec)','FontSize',16)
ylabel('h dot (km/s)','FontSize',16)

figure

plot(tout,xout(:,4),'r')
xlabel('Time (sec)','FontSize',16)
ylabel('\theta dot (rad/s)','FontSize',16)

figure

plot(tout,xout(:,5),'r')
xlabel('Time (sec)','FontSize',16)
ylabel('m (kg/s)','FontSize',16)

% Compute energy/momentum at apoapsis
h=xout(:,1);
apo = find(h==max(h));
thDot = xout(:,4);
thDot_apo = thDot(apo);

rdot_apo = thDot_apo*(6378+h(apo));
en_apo = rdot_apo^2/2 - extras.mu/(extras.Re+h(apo));

% Ang momentum

am = (extras.Re + h(apo))^2*thDot_apo;

% dV to circularize

dV = sqrt(extras.mu/(extras.Re+h(apo))) - rdot_apo;

