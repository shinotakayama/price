function [Regime, bi, as] = incentive(u, r, I, N, b, mL, VL, mH, VH)

% Finding a bid and ask price for a honest strategy:
A = ask(b(I), u, r, 1, 1);
B = bid(b(I), u, r, 1, 1);

% Finding an interval for the prices:
J = fd(1, I, b, B);
K = fd(I, N+1, b, A);

% If being honest is incentive compatible then bi is a bid and as is an ask
% prices for an honest strategy and gives the belief for it otherwise
% everything is zero.
if highbuy(A, K, b, mH, VH) >= highsell(B, J, b, mH, VH) && lowbuy(A, K, b, mL, VL) <= lowsell(B, J, b, mL, VL)
    bi = B;
    as = A;
    Regime = 1;
else
    bi = 0;
    as = 0;
    Regime = 0;
end