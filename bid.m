function bd = bid(b, u, r, hb, ls)
bd = (b*u*(1 - hb) + (1 - u)*(1 - r)*b)/((1 - u)*(1 - r) + u*(1 - hb)*b + u*(1 - b)*ls);
