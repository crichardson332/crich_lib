%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
% File Name: InvertedPendulum.m;
% Purpose:;
% Creation Date: 04-10-2015;
% Last Modified:;
% Created By: Chris Richardson;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;

XT = csvread('../cpp/inv_pendulum.csv');

T = XT(:,1); 
X = XT(:,2:3);
% Plot
theta = X(:,1); % extract first column
thetadot = X(:,2); % extract 2nd column
figure(1)
plot(T,theta)
xlabel('time (s)')
ylabel('angle (rad)')

figure(2)
plot(T,thetadot)
xlabel('time (s)')
ylabel('angular velocity (rad/s)') 
