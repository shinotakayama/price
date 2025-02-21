function [oldh, oldl] = newtonHL(u, r, inih, inil, I, b, N, ml, vl, mh, vh, tol)

maxK = 15;

% Newton-Raphson starts
[fH, fL] = myfunHL(u, r, inih, inil, I, b, N, ml, vl, mh, vh);
err = max(abs(fH), abs(fL));
oldh = inih;
oldl = inil;
k = 1;
while err > tol && k <= maxK;
J = jacHL(u, r, oldh, oldl, I, b, N, ml, vl, mh, vh);
delx = - inv(J)*[fH; fL];
newxH = delx(1,1);
newxL = delx(2,1);
H = (1 - u)*r + u*oldh;
L = (1 - u)*(1 - r) + u*oldl;
newH = H*b(I) + newxH;
newL = (1 - L)*(1 - b(I)) + newxL;
newh = (newH/b(I) - (1 - u)*r)/u;
newl = ((1 - newL/(1 - b(I))) - (1 - u)*(1 - r))/u;
[fH, fL] = myfunHL(u, r, newh, newl, I, b, N, ml, vl, mh, vh);
oldh = newh;
oldl = newl;
err = max(abs(fH), abs(fL));
k = k + 1;
end