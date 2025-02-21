function [xL, xH, LS, LB, HS, HB] = diffun(u, r, i, b, hb, ls, ml, mh, vl, vh)

A = size(ml);
N = A(1,1);
tol = b(2)/N^N;

cASK = ask(b(i), u, r, hb, ls);
cBID = bid(b(i), u, r, hb, ls);

AK = fd(1, N+1, b, cASK);
BJ = fd(1, N+1, b, cBID);

if hb + ls >= 1 - tol
if BJ < N+1
LS =  cBID + ml(BJ)*(cBID - b(BJ)) + vl(BJ);
HS =  - 1 + cBID + mh(BJ)*(cBID - b(BJ)) + vh(BJ);
else
LS = cBID + vl(BJ);
HS = - 1 + cBID + vh(BJ);
end
else
    LS = 0;
    HS = 0;
end

if hb + ls >= 1 - tol
if AK < N+1
LB = - cASK + ml(AK)*(cASK - b(AK)) + vl(AK);
HB = 1 - cASK + mh(AK)*(cASK - b(AK)) + vh(AK);
else
LB = - cASK + vl(AK);
HB = 1 - cASK + vh(AK);
end
else
    LB = 0;
    HB = 0;
end

xH = HB - HS;
xL = LS - LB;
