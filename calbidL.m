function Y = calbidL(X, I, H, b)
%This program finds bid price which satisfies the indifference condition for
%Low type, given ask price.

% X is a candidate ask which consists of 3 X N matrix.  The first one is the number for k (range for ask), the second is for j (range for bid) and the third is the
% ask price.

% int is a number of candidates.

A = size(X);
int = A(1, 2);

% Calculate bid candidates for each row i.
i = 1;
while i <= int
if b(I)*H - X(3, i) ~= 0
            B(i) = X(3, i)*b(I)*(H-1)/(b(I)*H-X(3, i));
            K(i) = X(3, i);
else
            B(i) = 0;
            K(i) = 0;
end
i = i+1;
end

Y = [];
i = 1;
while i <= int
    J = X(2, i); %J is a range for bid.
if B(i) ~= 0 && b(J) <= B(i) && B(i) <= b(J+1)
    Q = [K(i); B(i)];
else
    Q = [];
end
    Y = [Y Q];
    i = i+1;
end