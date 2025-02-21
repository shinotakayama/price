%This program saves the simulation results:

    VL2001 = VL(:,1501);
    VH2001 = VH(:,1501);
    save('../sim2/exitvu012001n.mat', 'VL2001', 'VH2001')
    save('../sim2/manu012001n.mat')