function K = calaskL(I, H, N, b, mL, VL)

%This program finds ask prices which satisfies the indifference condition for
%Low type. This program returns the matrix K (3 X N).  Each column consists
%of three numbers.  The first one is the number for k, the second is for j and the third is the
%ask price.

%In order to linearly interporate the value function, first define the
%slopes in each interval and then define the ask price by using the slope.
%Suppose that ask price is between b_{k} and b_{k+1}, the belief is between
%b_{i} and b_{i+1}, and bid price is between b_{j} and b_{j+1}.

K = [];
k = I; %k is the range for ask.
while k <= N
j = 1; %j is the range for BID.
    while j <= I;
%D is a determinant.
A = mL(k)-1;
B = b(I)*H*(1-mL(k)) + b(I)*(H-1)*(mL(j)+1) - (VL(j) - VL(k)+b(k)*mL(k) - b(j)*mL(j));
C = (VL(j) - VL(k)+b(k)*mL(k) - b(j)*mL(j))*b(I)*H;
D = B^2-4*A*C;
if D >= 0
        [xP, xM]= sol2real(A, B, C); %xP is the +square answer and xM is the -square one
else
        xP = 0;
        xM = 0;
end
if b(k) <= xP && xP <= b(k+1) && b(k) > xM
    X = [k; j; xP];
%elseif  b(k) <= xP && xP <= b(k+1) && xM > b(k+1)
%    X = [k; j; xP];
%elseif b(k) <= xM && xM <= b(k+1) && b(k) > xP
%    X = [k; j; xM];
elseif b(k) <= xM && xM <= b(k+1) && xP > b(k+1)
    X = [k; j; xM];
elseif b(k) <= xP && xP <= b(k+1) && b(k) <= xM && xM <= b(k+1)
    X = [k k; j j; xP xM];
else
    X = [];
end
    K = [K X];
    j = j+1;      
   end
    k = k +1;
 end