function [value,isterminal,direction] = event_function(t,S)
mu = 1/(81.3+1);
x1 = -mu;
x2 = 1-mu;

xi = 384400*sqrt((S(1)-x1)^2+S(2)^2+S(3)^2);

value = (xi <= (6353+100))*1;
isterminal = 1;
direction = 0;

end