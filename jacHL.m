function J = jacHL(u, r, h, l, I, b, N, ml, vl, mh, vh)

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
   
   termL1 = - ALK + BLJ - CLL;
   termL2 = - b(I)*BLJ + ALK + CLL;
   termL3 = BLJ - ALK - 2*CLL;
   termL4 = xH*(BLJ - ALK - 2*CLL) + (- BLJ*b(I) + CLL);

   AHK = mh(inAK) - 1;
   BHJ = mh(inBJ) + 1;
   CHL = (b(inBJ)*mh(inBJ) - vh(inBJ)) - (b(inAK)*mh(inAK) - vh(inAK)) + 2;
   
   termH1 = - AHK + BHJ - CHL;
   termH2 = - b(I)*BHJ + AHK + CHL;
   termH3 = BHJ - AHK - 2*CHL;
   termH4 = xH*(BHJ - AHK - 2*CHL) + (- BHJ*b(I) + CHL);

   fHxH = termH1*2*xH + termH2 + xL*termH3;
   fLxH = termL1*2*xH + termL2 + xL*termL3;
   fHxL = termH4 - 2*CHL*xL;
   fLxL = termL4 - 2*CLL*xL;

J = [fHxH fHxL; fLxH fLxL];
else
    J = zeros(2,2);
end