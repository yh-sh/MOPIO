function V = ReferenceVectorRegeneration(PopObj,V)
% Reference vector regeneration

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    PopObj        = PopObj - repmat(min(PopObj,[],1),size(PopObj,1),1);
    [~,associate] = max(1-pdist2(PopObj,V,'cosine'),[],2);
    inValid       = setdiff(1:size(V,1),associate);
    V(inValid,:)  = rand(length(inValid),size(V,2)).*repmat(max(PopObj,[],1),length(inValid),1);
end