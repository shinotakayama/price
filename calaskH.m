function K = calaskH(I, L, N, b, mH, VH)

%This program finds ask prices which satisfies the indifference condition for
%High type. This program returns the matrix K (3 X N).  Each column consists
%of three numbers.  The first one is the number for k, the second is for j and the third is the
%ask price.

%For this program, we need: sol2real.

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
A = mH(k)-1;
E1 = 1+b(I)+2*L*(1-b(I));
E2 = mH(k)*(b(k) + b(I) + L*(1-b(I)));
E3 = (b(j)-1+L*(1-b(I)))*mH(j);
B = E1 -E2+ E3+ VH(k) - VH(j);
E4 = b(I)+L*(1-b(I));
E5 = b(k)*mH(k)-1;
E6 = -(1 - b(I))*L + (b(I)*(1 - b(j)) - b(j)*L*(1-b(I)))*mH(j);
C = E4*(E5+VH(j)-VH(k))+E6;
D = B^2 - 4*A*C;
if D >= 0 %Asking if a determinant is positive or not.  xP and xM return a solution to the quadratic for
%this case.  P stands for plus and M stands for minus for square pasts.
        [xP, xM] = sol2real(A, B, C);
else % If there is no solution to the quadratic form, then returns 0.
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