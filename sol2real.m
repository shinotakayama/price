function [xP, xM] = sol2real(a, b, c)

D = b^2 - 4*a*c;
if D >=0
xp = (-b+sqrt(D))/(2*a);
xm = (-b-sqrt(D))/(2*a);
else
    xp = 0;
    xm = 0;
end

%The answers are xP >= xM
xP = max(xp,xm);
xM = min(xp,xm);