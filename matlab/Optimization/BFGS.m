function [xk,f_opt,gx,numDir] = BFGS(x0,eps)

I = eye(2,2);
Bk = I;
Hk = I;
xk = x0;
counter = 0;
rp = 1;
lamp1 = 0;
gamma = 1.25;

% Minimize the Lagrangian using sequential iterations of the BFGS alrogithm
ezcontour('(1-x1)^2+100*(x2-x1^2)^2',[-3,3,-3,3])
hold on
fill([2,3,3,-1],[-3,-3,3,3],'green')
plot(xk(1),xk(2),'bo')
numDir = 0;

for i = 1:12
    tolerance = 1;
    % Implement BFGS algorithm
%     xkm1 = xk;
    while tolerance > eps
        numDir = numDir + 1;
        xkm1 = xk;
        pk = -Hk*grad1(xk,rp,lamp1);
        [alphak,gx] = GSM(xk,pk,rp,lamp1);
        xkp1 = xk + alphak*pk;
        sk = alphak*pk;
        yk = grad1(xkp1,rp,lamp1) - grad1(xk,rp,lamp1);
        rhok = 1/(yk'*sk);
        Bk = Bk + yk*yk'/(yk'*sk) - Bk*(sk*sk')*Bk/(sk'*Bk*sk);
        Hk = (I - rhok*sk*yk')*Hk*(I - rhok*yk*sk') + rhok*sk*sk';
        xk = xkp1;
        tolerance = norm(grad1(xk,rp,lamp1));
        counter = counter + 1;
        plot(xk(1),xk(2),'ro')
        xvals = [xkm1(1),xk(1)];
        yvals = [xkm1(2),xk(2)];
        plot(xvals,yvals)
    end
    plot(xk(1),xk(2),'k*')
    % End of BFGS algorithm
    
    lamp1 = lamp1 + 2*rp*max(gx,-lamp1/(2*rp));
    rp = rp*gamma;
%     plot(xk(1),xk(2),'ro')
%     xvals = [xkm1(1),xk(1)];
%     yvals = [xkm1(2),xk(2)];
%     plot(xvals,yvals)
end
f_opt = lagrangian_calc(xk,rp,lamp1);





