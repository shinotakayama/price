function p = lowsell(bid, J, b, mL, VL)

A = size(mL);

if J <= A(1,1)
p =  bid + mL(J)*(bid - b(J)) + VL(J);
else
    p = bid + VL(J);
end