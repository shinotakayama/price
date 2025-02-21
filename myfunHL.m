function [fH, fL] = myfunHL(u, r, h, l, I, b, N, ml, vl, mh, vh)

       aK = ask(b(I), u, r, h, l); % Finding a finer ask price for each pair of finer strategy
       bJ = bid(b(I), u, r, h, l); % Finding a finer bid price for each pair of finer strategy
       inAK = fd(I,N+1,b,aK);
       inBJ = fd(1,I,b,bJ);
       
       L = (1-u)*(1-r) + u*l;
       H = (1-u)*r + u*h;
       xH = H*b(I);
       xL = (1 - L)*(1 - b(I));
if inAK ~= 0 && inBJ ~= 0 && inAK < N+1 && inBJ < N+1 && l > 1 - h    
   ALK = ml(inAK) - 1;
   BLJ = ml(inBJ) + 1;
   CLL = (b(inBJ)*ml(inBJ) - vl(inBJ)) - (b(inAK)*ml(inAK) - vl(inAK));
   
   termKL = - ALK + BLJ - CLL;
   termSL = - b(I)*BLJ + ALK + CLL;
   termTL = BLJ - ALK - 2*CLL;
   termML = -b(I)*BLJ + CLL;
   
   AHK = mh(inAK) - 1;
   BHJ = mh(inBJ) + 1;
   CHL = (b(inBJ)*mh(inBJ) - vh(inBJ)) - (b(inAK)*mh(inAK) - vh(inAK)) + 2;
   
   termKH = - AHK + BHJ - CHL;
   termSH = - b(I)*BHJ + AHK + CHL;
   termTH = BHJ - AHK - 2*CHL;
   termMH = -b(I)*BHJ + CHL;
   
fH = termKH*xH^2 + xH*termSH + xL*(xH*termTH + termMH) - CHL*xL^2;
fL = termKL*xH^2 + xH*termSL + xL*(xH*termTL + termML) - CLL*xL^2;

else
    fH = 0;
    fL = 0;
end