function PBI = CalPBI(PopObj,W,Region,Z,Sub)
% Calculate the PBI value between each solution and its associated weight
% vector

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    Z   = repmat(Z,sum(Sub),1);
    NormW = sqrt(sum(W(Region(Sub),:).^2,2));
    d1  = abs(sum((PopObj(Sub,:)-Z).*W(Region(Sub),:),2))./NormW;
    d2  = sqrt(sum((PopObj(Sub,:)-(Z+W(Region(Sub),:).*repmat(d1./NormW,1,size(W,2)))).^2,2));
    PBI = zeros(1,size(PopObj,1));
    PBI(Sub) = d1 + 5*d2;
end