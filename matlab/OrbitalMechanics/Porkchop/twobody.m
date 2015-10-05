function [r,v,TOUT] = twobody(r0,v0,TSPAN,mu)

% This function propagates a two body orbit in 3 dimensions given 
% initial state 3:1 column vectors r1 and v1, a delta t (dt), and a mu value


% Use ode45 to propagate the orbit; state vector is a column vector of
% position followed by velocity

Y0 = [r0;v0];

% Anonymous function for Universal Law of Gravitation ULG
ULG = @(T,Y) [Y(4:6);-mu/norm(Y(1:3))^3*Y(1:3)];

[TOUT,YOUT] = ode45(ULG,TSPAN,Y0);

r = YOUT(:,1:3);
v = YOUT(:,4:6);

end
