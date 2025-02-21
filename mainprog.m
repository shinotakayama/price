% This program solves the equilibrium strategies and also return regimes.
% Files to run this program are found in readme.txt.  Regime 1 = nobody
% manipulates, Regime 2 = L manipulates, Regime 3 = H manipulates, and
% Regime 4 = both manipulates.  Regime 5 is the situation where muptiple
% regimes stand together or no equilibrium.  When Regime 5 happens, the
% program stops.

% In the folder "sim2," results are saved in u = 0.5 r = 0.5, u = 0.2 and u = 0.8 while r = 0.5; & r = 0.2 and r = 0.8 while u = 0.5;

clear;

%%When loading from other .mat file, we need the following:
%Loading the last-period value function recursively as the first-period.
VLT = VL(:,200);
VHT = VH(:,200);

N = 100;
EndT = 200;
EndT_new = 201; %The number of periods: T - t0 + 1 for recursive case and T - t0 for initial run
T = 300;  % This has to be updated depending on whether or not doing recursively.
u = 0.5;
r = 0.5;
b = zeros(N+1, 1);
F = zeros(N+1, 1);
mL = zeros(N, 1);
mH = zeros(N, 1);
mdhl = zeros(N, 1);
VL = zeros(N+1, T);
VH = zeros(N+1, T);
DL = zeros(N+1, T);
DH = zeros(N+1, T);
Regime = zeros(N+1, T);
BID = zeros(N+1, T);
ASK = zeros(N+1, T);
LS = zeros(N+1, T);
HB = zeros(N+1, T);
LB0 = zeros(N+1, T);
LS0 = zeros(N+1, T);
HB0 = zeros(N+1, T);
HS0 = zeros(N+1, T);
LBL = zeros(N+1, T);
LSL = zeros(N+1, T);
HBL = zeros(N+1, T);
HSL = zeros(N+1, T);
LBH = zeros(N+1, T);
LSH = zeros(N+1, T);
HBH = zeros(N+1, T);
HSH = zeros(N+1, T);
canHB = zeros(N+1, T);
canLS = zeros(N+1,T);
canSS = zeros(N+1, T);
canBB = zeros(N+1, T);
R0 = zeros(N+1, T);
RL = zeros(N+1, T);
RH = zeros(N+1, T);
RHL = zeros(N+1, T);
DL0 = zeros(N+1, T);
DH0 = zeros(N+1, T);
DLwHL = zeros(N+1, N+1);
DHwHL = zeros(N+1, N+1);
XH = zeros(N+1, T);
keyL = zeros(N+1, T);
keyH = zeros(N+1, T);
keyML = zeros(N+1, T);
keyMH = zeros(N+1, T);

tol = 10^(-7);

%Defining intervals for belief from 0 to 1.  Each interval is 1/N long.
b(1) = 0;
for i=2:N+1
b(i) = (i-1)/N;
end

%Defining the last period value function for initial run.
for i=1:N+1    
    ASK(i, 1) = ask(b(i), u, r, 1, 1);
    BID(i, 1) = bid(b(i), u, r, 1, 1);
    VL(i, 1) = u*BID(i, 1); %The value function in the last period.  Prior in the last period is b(i).
    VH(i, 1) = u*(1 - ASK(i, 1)); %The value function in the last period.
    Regime(i, 1) = 0;
    LS(i, 1) = 1;        
    HB(i, 1) = 1;
end

%When L manipulates & H does not.
H = (1-u)*r + u;

%When H manipulates & L does not.
L = (1-u)*(1-r) + u;

%/Users/shinotakayama/Dropbox
%load('..\sim2\exitvu273.mat');
%VL(:,1) = VLT;
%VH(:,1) = VHT;
%%Replace Ends

%%When we do NOT load, use the following:
vl = VL(:,1);
vh = VH(:,1);
%%End

PH = [];
PL = [];
PHL = [];

%Now we start with the second-period.
t = 2;
MaxR = 1;
while t <= T && MaxR ~= 5
    vl = VL(:, t-1);
    vh = VH(:, t-1);
    dhl = VL(:, t-1) - VH(:, t-1);
    for j = 1:N
    mL(j) = (vl(j+1) - vl(j))/(b(j+1) - b(j));
    mH(j) = (vh(j+1) - vh(j))/(b(j+1) - b(j));
    mdhl(j) = (dhl(j+1) - dhl(j))/(b(j+1) - b(j));
    end
    i = 1; %i is the range for belief.
while i <= N;
    % When keyL > keyML, L manipulates and keyH > keyMH, H manipulates.
    
    K = fd(i,N+1,b,ASK(i, 1));
    J = fd(1,i,b,BID(i, 1));
    vlask = nextvalue(ASK(i,1), K, b, mL, vl);
    vlbid = nextvalue(BID(i,1), J, b, mL, vl);
    vhask = nextvalue(ASK(i,1), K, b, mH, vh);
    vhbid = nextvalue(BID(i,1), J, b, mH, vh);
    
   keyL(i,t)=(vlask - vlbid)/(ASK(i,1) - BID(i,1)); %[VL(A)-VL(B)]/[A-B]
   keyH(i,t)=(vhbid - vhask)/(ASK(i,1) - BID(i,1)); %[VH(B)-VH(A)]/[A-B]
   keyML(i,t)=(ASK(i,1) + BID(i,1))/(ASK(i,1) - BID(i,1)); %[A+B]/[A-B]
   keyMH(i,t)=(2 - ASK(i,1) - BID(i,1))/(ASK(i,1) - BID(i,1)); %[2 - A - B]/[A-B]
    
   [R0(i,t), bi, as] = incentive(u, r, i, N, b, mL, vl, mH, vh);
   [LB0(i, t), LS0(i, t), HB0(i, t), HS0(i, t)] = profits(bi, as, b, i, N, vl, vh, mL, mH);

   [RH(i,t), biH, asH, canHB(i,t)] = checkH(u, r, L, i, b, N, mL, vl, mH, vh);
   [LBH(i, t), LSH(i, t), HBH(i, t), HSH(i, t)] = profits(biH, asH, b, i, N, vl, vh, mL, mH);
   
   dffH(i, t) = HBH(i, t) - HSH(i, t);
   dffL0(i, t) = LSH(i, t) - LBH(i, t);

   [RL(i,t), biL, asL, canLS(i,t)] = checkL(u, r, H, i, b, N, mL, vl, mH, vh);
   [LBL(i, t), LSL(i, t), HBL(i, t), HSL(i, t)] = profits(biL, asL, b, i, N, vl, vh, mL, mH);
   dffH0(i, t) = HBL(i, t) - HSL(i, t);
   dffL(i, t) = LSL(i, t) - LBL(i, t);
   
   [DL0(i,t), DH0(i,t), honeLS(i, t), honeLB(i, t), honeHS(i, t), honeHB(i, t)] = diffun(u, r, i, b, 1, 1, mL, mH, vl, vh);

   if DL0(i,t) < 0 && DH0(i, t) < 0;
   [newh, newl] = fixedHL(u, r, i, b, N, mL, vl, mH, vh, 10^(-7));
   if newh > 1 - newl && newh >= 0 && newl >= 0 && newh <= 1 && newl <= 1;
       canBB(i,t) = newh;
       canSS(i,t) = newl;
       biHL = bid(b(i), u, r, canBB(i,t), canSS(i,t));
       asHL = ask(b(i), u, r, canBB(i,t), canSS(i,t));
       RHL(i,t) = 1;
   else
       biHL = 0;
       asHL = 0;
       RHL(i,t) = 0;
   end
   end       
   
   if RHL(i, t) == 1
       [LBHL(i, t), LSHL(i, t), HBHL(i, t), HSHL(i, t)] = profits(biHL, asHL, b, i, N, vl, vh,  mL, mH);
   else
       [LBHL(i, t), LSHL(i, t), HBHL(i, t), HSHL(i, t)] = profits(0, 0, b, i, N, vl, vh,  mL, mH);
   end
   
   dffHLH(i, t) = HBHL(i, t) - HSHL(i, t);
   dffHLL(i, t) = LSHL(i, t) - LBHL(i, t);
   
   if RH(i, t) == 1 && RHL(i, t) == 1 && RL(i, t) ~= 1
       PH = [PH; i t];
      inih = canHB(i,t);
       inil = 1;
       [oldhH, oldlH] = newtonHL(u, r, inih, inil, i, b, N, mL, vl, mH, vh, 10^(-7));
      if oldlH < 1 || abs(oldhH) > 1
           RH(i, t) = 0;
       end
   end
   
   if RL(i, t) == 1 && RHL(i, t) == 1 && RH(i, t) ~= 1
       PL = [PL;i t];
       inil = canLS(i,t);
       inih = 1;
       [oldhL, oldlL] = newtonHL(u, r, inih, inil, i, b, N, mL, vl, mH, vh, 10^(-7));
       if oldhL < 1 || abs(oldlL) > 1
           RL(i, t) = 0;
       end
   end
   
   if RL(i, t) == 1 && RHL(i, t) == 1 && RH(i, t) == 1
       PHL = [PHL;i t];
       inil = canLS(i,t);
       inih = canHB(i, t);
       [oldhHL, oldlHL] = newtonHL(u, r, inih, inil, i, b, N, mL, vl, mH, vh, 10^(-7));
       if abs(oldhHL) > 1 && abs(oldlHL) > 1
           RH(i, t) = 0;
           RL(i, t) = 0;
       end
   end
   
   if R0(i, t) == 1 && RL(i, t) == 0 && RH(i, t) == 0  && RHL(i,t) == 0
           Regime(i, t) = 1; %Honest trade is an equilibrium.
           LS(i, t) = 1;        
           HB(i, t) = 1;
           ASK(i, t) = ask(b(i), u, r, 1, 1);
           BID(i, t) = bid(b(i), u, r, 1, 1);           
       elseif R0(i, t) == 0 && RL(i, t) == 1 && RH(i, t) == 0 && RHL(i,t) == 0
            Regime(i, t) = 2; %Low manipulates and high does not.
            BID(i, t) = biL;
            ASK(i, t) = asL;
            LS(i, t) = canLS(i, t);
            HB(i, t) = 1;
       elseif R0(i, t) == 0 && RH(i, t) == 1 && RL(i, t) == 0 && RHL(i,t) == 0
            Regime(i, t) = 3; %High manipulates and low does not.
            BID(i, t) = biH;
            ASK(i, t) = asH;
            LS(i, t) = 1;        
            HB(i, t) = canHB(i, t);
       elseif R0(i, t) == 0 && RH(i, t) == 0 && RL(i, t) == 0  && RHL(i, t) == 1
            Regime(i, t) = 4; %Both manipulate.
            BID(i, t) = biHL;
            ASK(i, t) = asHL;
            LS(i, t) = canSS(i, t);        
            HB(i, t) = canBB(i, t);
       else
           Regime(i, t) = 5; %Any other situation.
   end
        [VL(i, t), VH(i, t)] = value1(i, ASK(i, t), BID(i, t), b, u, r, N, mL, vl, mH, vh);           
  i = i+1;
end;
VL(N+1,t)= valueL(bid(b(N+1), u, r, 1, 1), u, r, VL(N+1, t-1), VL(N+1, t-1));
VH(N+1,t)= valueH(ask(b(N+1), u, r, 1, 1), u, r, VH(N+1, t-1), VH(N+1, t-1));
ASK(N+1, t) = ask(b(N+1), u, r, 1, 1);
BID(N+1, t) = bid(b(N+1), u, r, 1, 1);
Regime(N+1, t) = 1;
LS(N+1, t) = 1;        
HB(N+1, t) = 1;
MaxR = max(Regime(:,t));
%if MaxR == 5
%    ExT = t;
%    LSTVL = VL(:,ExT - 1);
%    LSTVH = VH(:,ExT - 1);
%    save('../sim2/lstexitvu1.mat', 'LSTVL', 'LSTVH')
%    save('../sim2/exitvu1.mat', 'VL', 'VH', 'ASK', 'BID', 'Regime', 'LS', 'HB')
%end
t = t+1
end

%Computing the slope of value functions in each point.
NewT = t - 1; %Loop ends at t+1 so bring it back to t
t=1;
while t <= NewT;
    i = 1;
    while i <= N;
        DL(i, t) = (VL(i+1, t) - VL(i, t))/(b(i+1)-b(i));
        DH(i, t) = (VH(i+1, t) - VH(i, t))/(b(i+1)-b(i));
        i = i + 1;
    end
    DL(N+1, t) = 0;
    DH(N+1, t) = 0;
    t = t + 1;
end

%/Users/shinotakayama/
%    VL200 = VL(:,200);
%    VH200 = VH(:,200);
%    save('../sim2/exitvu3200.mat', 'VL200', 'VH200')

%save('../sim2/man_new400.mat');

figure
plot(b, VH, b, VL)

figure
plot(b, ASK, b, BID)