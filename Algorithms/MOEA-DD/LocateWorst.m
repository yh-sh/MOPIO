function x = LocateWorst(PopObj,W,Region,FrontNo,Z)
% Detect the worst solution in the population

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    temp   = tabulate(Region);
    Crowd  = zeros(1,size(W,1));
    Crowd(temp(:,1)) = temp(:,2);
    Phi    = find(Crowd==max(Crowd));
    PBI    = CalPBI(PopObj,W,Region,Z,ismember(Region,Phi));
    PBISum = zeros(1,size(W,1));
    for j = 1 : length(PBI)
        PBISum(Region(j)) = PBISum(Region(j)) + PBI(j);
    end
    [~,Phi] = max(PBISum);
    Phih    = find(Region==Phi);
    R       = Phih(FrontNo(Phih)==max(FrontNo(Phih)));
    [~,x]   = max(PBI(R));
    x       = R(x);
end