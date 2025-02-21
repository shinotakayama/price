function x = valueH(ak, u, r, va, vb)
x = u*(1 - ak + va) + (1 - u)*(r*va + (1 - r)*vb);
