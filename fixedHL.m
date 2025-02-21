function [newh, newl] = fixedHL(u, r, I, b, N, ml, vl, mh, vh, tol)

maxK = 10;

% This program finds solutions for hb and ls when both types manipulate.

for h = 1:N+1;
       for l = 1:N+1;
   [DLwHL(h, l), DHwHL(h, l), LS(h, l), LB(h, l), HS(h, l), HB(h, l)] = diffun(u, r, I, b, b(h), b(l), ml, mh, vl, vh);
       end
end
  
  Hrate0 = fdminus(DHwHL); %Given k, obtaining the interval of j that indifference for H happens
  Lrate0 = fdminus(DLwHL); %Given k, obtaining the interval of j that indifference for L happens
  
  newh = 0;
  newl = 0;
  m = 0;
h = 1;
while h <= N+1;
    l = 1;
    while l <= N + 1;
        if Hrate0(h, l) ~= 0 && Lrate0(h, l) ~= 0
            inh = h;
            inl = l;
            newh = b(inh) + newh;
            newl = b(inl) + newl;
            m = m + 1;
        end
    l = l + 1;    
    end
    h = h + 1;
end

if newh == 0 || newl == 0
  Hrate0 = fdminus2(DHwHL); %Given k, obtaining the interval of j that indifference for H happens
  Lrate0 = fdminus2(DLwHL); %Given k, obtaining the interval of j that indifference for L happens
  
  newh = 0;
  newl = 0;
  m = 0;
h = 1;
while h <= N+1;
    l = 1;
    while l <= N + 1;
        if Hrate0(h, l) ~= 0 && Lrate0(h, l) ~= 0
            inh = h;
            inl = l;
            newh = b(inh) + newh;
            newl = b(inl) + newl;
            m = m + 1;
        end
    l = l + 1;    
    end
    h = h + 1;
end
end

% Obtaining initial starting points for hb and ls
  inih = newh/m;
  inil = newl/m;

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

if k > maxK
    oldh = 0;
    oldl = 0;
end