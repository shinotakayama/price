function p = lowbuy(a, K, b, mL, VL)
A = size(mL);

if K <= A(1,1)
p = - a + mL(K)*(a - b(K)) + VL(K);
else
    p = - a + VL(K);
end