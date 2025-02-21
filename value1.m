function [VLn, VHn] = value1(I, as, bi, b, u, r, N, mL, VL, mH, VH)

J = fd(1, I, b, bi);
K = fd(I, N, b, as);

if K == 0 || J == 0
VLn = 0;
VHn = 0;
else
VLn =  u*lowsell(bi, J, b, mL, VL) + (1-u)*(r*nextvalue(as, K, b, mL, VL) + (1-r)*nextvalue(bi, J, b, mL, VL));
VHn =  u*highbuy(as, K, b, mH, VH) + (1-u)*(r*nextvalue(as, K, b, mH, VH) + (1-r)*nextvalue(bi, J, b, mH, VH));
end


