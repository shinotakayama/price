function Y = calbidH(X, I, L, b)
%This program finds bid price which satisfies the indifference condition for
%High type, given ask price.

A = size(X);
int = A(1, 2);

for k = 1:int
    ak(k) = X(3,k);
end

k = 1;
while k <= int
if (1 - b(I))*L + (b(I) - ak(k)) ~= 0
            U = (1 - b(I))*L*ak(k) + (b(I) - ak(k));
            D = (1 - b(I))*L + (b(I) - ak(k));
            B(k) = U/D;
            K(k) = ak(k);
else
            B(k) = 0;
            K(k) = 0;
end
k = k+1;
end

Y = [];
j = 1;
while j <= int
    J = X(2, j);
if b(J) <= B(j) && B(j) <= b(J+1)
    Q = [K(j); B(j)];
else
    Q = [];
end
    Y = [Y Q];
    j = j+1;
end