%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
% File Name: InvertedPendulum.m;
% Purpose:;
% Creation Date: 04-10-2015;
% Last Modified:;
% Created By: Chris Richardson;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;

XT = csvread('../../cpp/DiffEq/model_rocket.csv',' ');

T = XT(:,1); 
X = XT(:,2:3);
% Plot
theta = X(:,1); % extract first column
thetadot = X(:,2); % extract 2nd column
subplot(2,1,1)
%figure(1)
plot(T,theta)
xlabel('Time (s)')
ylabel('Height (m)')

%figure(2)
subplot(2,1,2)
plot(T,thetadot)
xlabel('time (s)')
ylabel('Velocity (m/s)') 
