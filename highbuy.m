function p = highbuy(a, K, b, mH, VH)

A = size(mH);

if K <= A(1,1)
p = 1 - a + mH(K)*(a - b(K)) + VH(K);
else
    p = 1 - a + VH(K);
end