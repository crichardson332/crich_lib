%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;
% File Name: InvertedPendulum.m;
% Purpose:;
% Creation Date: 04-10-2015;
% Last Modified:;
% Created By: Chris Richardson;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;

close all

XT = csvread('../../cpp/DiffEq/model_rocket.csv');

T = XT(:,1); 
X = XT(:,2:3);
% Plot
height = X(:,1); % extract first column
velocity = X(:,2); % extract 2nd column
subplot(2,1,1)
%figure(1)
plot(T,height)
xlabel('Time (s)')
ylabel('Height (m)')

subplot(2,1,2)
plot(T,velocity)
xlabel('time (s)')
ylabel('Velocity (m/s)') 

% Plot height vs. burn time T
max_height = csvread('../../cpp/DiffEq/height.csv');
figure
T = 0.01:0.01:12.0;
plot(T,max_height)
T_max_height = T(find(max_height == max(max_height)));
x=[T_max_height(1),T_max_height(1)];
y=[0,100];
hold on
plot(x,y)
xlabel('Burnout time T (sec)')
ylabel('Max height (m)')
title('Max height vs. burnout time')
