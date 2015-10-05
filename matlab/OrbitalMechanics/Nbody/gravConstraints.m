function constraints = gravConstraints(Y,m,G)

% This function will take in the matrix of state vectors Y and calculate
% the 10 constraints for the N-body problem and put them in an Mx10 matrix
% with each row being a vector of the 10 constraints at each timestep

% Y is in m and m/s


[r,c] = size(Y);
N = c/4;
constraints = zeros(r,6);
% make m a row vector
m = m';

for i = 1:r
    curPos = Y(i,1:c/2);
    curVel = Y(i,c/2+1:c);
    
    % Center of mass position
    xcom = 1/sum(m)*sum(m.*curPos(1:2:end));
    ycom = 1/sum(m)*sum(m.*curPos(2:2:end));
    
    % Linear momentum
    Lx = sum(m.*curVel(1:2:end));
    Ly = sum(m.*curVel(2:2:end));
    
    % Angular momentum H and kinetic energy KE
    H = 0;
    KE = 0;
    for j = 1:2:2*N
        H = H + m((j+1)/2)*(curPos(j)*curVel(j+1) - curPos(j+1)*curVel(j));
        KE = KE + 1/2*m((j+1)/2)*(curVel(j)^2 + curVel(j+1)^2);
    end
    
    % Potential energy PE
    PE = 0;
    for k1 = 1:(N-1)
        for k2 = (k1+1):N
            m1 = m(k1);
            m2 = m(k2);
            r1 = [curPos(k1*2-1),curPos(k1*2)];
            r2 = [curPos(k2*2-1),curPos(k2*2)];
            dist = sqrt((r1(1)-r2(1))^2 + (r1(2)-r2(2))^2);
            
            PE = PE - G*m1*m2/dist;
        end
    end
    E = PE + KE;
    
    % Put the contriants into the matrix
    
    constraints(i,:) = [xcom,ycom,Lx,Ly,H,E];

end