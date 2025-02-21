function x = valueL(bd, u, r, va, vb)
x = u*(bd + vb) + (1 - u)*(r*va + (1 - r)*vb);
