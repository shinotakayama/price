function p = highsell(bid, J, b, mH, VH)

A = size(mH);

if J <= A(1,1)
p =  - 1 + bid + mH(J)*(bid - b(J)) + VH(J);
else
    p =  - 1 + bid + VH(J);
end
