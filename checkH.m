function [Regime, bid, ask, stHB] = checkH(u, r, L, I, b, N, mL, VL, mH, VH)

% This program finds bid and ask prices which satisfy the condition for
% high type manipulates and low type does not.  First, it finds ask prices candidates at
% calaskH function.  Then, it finds bid price at calbidH function.

% For this program, we need: calaskH; calbidH; lowbuy; lowsell; fd.

W = calaskH(I, L, N, b, mH, VH); %Finding ask price candidates.
Q = calbidH(W, I, L, b); %Finding ask and bid prices from ask candidates.
A = size(Q);

if A(1) ~= 0
ask = Q(1, 1);
bid = Q(2, 1);
else
    ask = 0;
    bid = 0;
end

J = fd(1, I, b, bid);
K = fd(I, N+1, b, ask);
if ask ~= 0 && lowbuy(ask, K, b, mL, VL) <= lowsell(bid, J, b, mL, VL)
        as = Q(1, 1);
        bi = Q(2, 1);
        QH = as*(1-L)*(1 - b(I))/(b(I)*(1-as));
        HB = (QH - (1- u)*r)/u;
        if HB > 0 && HB < 1;
            bid = bi;
            ask = as;
            stHB = HB;    
            Regime = 1;
        else
            bid = 0;
            ask = 0;
            stHB = 0;    
            Regime = 0;
        end
else
            bid = 0;
            ask = 0;
            stHB = 0;    
            Regime = 0;
end

end