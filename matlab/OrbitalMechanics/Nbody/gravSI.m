function ydot = gravSI(t,y,m,G)

% This function will calculate ydot based on the state vector y, which is
% an 2Nx1 column vector whose first half is positions and second half is
% velocities; 
% y = [r1x;r1y;r2x;r2y;.....rNx;rNy;v1x;v1y;v2x;v2y;...vNx;vNy];
% m is an Nx1 column vector of masses from


state_size = numel(y);
N = state_size/4; % number of bodies for N body problem
ydot = y*0;

% start loop to calculate ydot based on the universal law of gravitation

ydot(1:end/2) = y(end/2+1:end); % rdot = v
for i = 1:2:(2*N-3)
    for j = (i+2):2:(2*N-1)
        % i is the index of body 1 (x-comp); j is the index of body 2
        m1 = m((i + 1)/2);
        m2 = m((j + 1)/2);
        fg1 = G*m2/norm([y(j)-y(i),y(j+1)-y(i+1)])^3;
        fg2 = G*m1/norm([y(j)-y(i),y(j+1)-y(i+1)])^3;% This is the magnitude of the gravitational force acting on body 1 from body 2
        % The norm above is taking the norm of (x2-x1) and (y2-y1)
        
        % The force on the two bodies are equal in magnitude
        % Acc = Acc + fg/m
        
        % ydot will be indexed in the second half now to change vdots
        ydot(i+state_size/2) = ydot(i+state_size/2) + fg1*(y(j)-y(i)); % Body 1 x
        ydot(i+1+state_size/2) = ydot(i+1+state_size/2) + fg1*(y(j+1)-y(i+1)); % Body 1 y
        
        ydot(j+state_size/2) = ydot(j+state_size/2) - fg2*(y(j)-y(i)); % Body 2 x
        ydot(j+1+state_size/2) = ydot(j+1+state_size/2) - fg2*(y(j+1)-y(i+1)); % Body 2 y
    end
end

end