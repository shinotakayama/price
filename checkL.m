function [Regime, bid, ask, stLS] = checkL(u, r, H, I, b, N, mL, VL, mH, VH)

% This program finds bid and ask prices which satisfy the condition for
% high type does not manipulate.  First, it finds ask prices candidates at
% calaskL function.  Then, it finds bid price at calbidL function.

% For this program, we need: calaskL; calbidL; fd; highbuy; highsell.

W = calaskL(I, H, N, b, mL, VL); %Finding ask price candidates.
Q = calbidL(W, I, H, b); %Finding ask and bid prices from ask candidates.
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
if ask ~= 0 && highbuy(ask, K, b, mH, VH) >= highsell(bid, J, b, mH, VH)
        as = Q(1, 1);
        bi = Q(2, 1);
        QL = 1 - H*b(I)*(1/as-1)/(1-b(I));
        LS = (QL - (1- u)*(1 - r))/u;
        if LS > 0 && LS < 1;
            bid = bi;
            ask = as;
            stLS = LS;    
            Regime = 1;
        else
            bid = 0;
            ask = 0;
            stLS = 0;    
            Regime = 0;
        end
else
            bid = 0;
            ask = 0;
            stLS = 0;    
            Regime = 0;
end


end