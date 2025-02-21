function F = fd(x0, x1, b, f)

% This program finds the interval j such that f belongs to the interval
% between [b(j), b(j+1)).  The first j starts at x0 and continues up to x1.
% It returns F which implies f is between [b(F), b(F+1))

A = size(b);
N = A(1,1) - 1;

F = 0;
k = 0;
while x0 + k <= x1 && F == 0 
    if x0 + k < N+1 && b(x0+k) <= f && b(x0+k+1) > f
        F = x0+k;
    elseif x0 + k == N+1
        F = N+1;
    else
        F = 0;
    end
        k = k + 1;
end