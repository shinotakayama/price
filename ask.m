function ak = ask(b, u, r, hb, ls)
ak = (b*u*hb + (1 - u)*r*b)/((1 - u)*r + u*hb*b + u*(1 - b)*(1 - ls));
