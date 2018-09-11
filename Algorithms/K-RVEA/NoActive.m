function [num,active] = NoActive(PopObj,V)
% Detect inactive reference vectors

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016". We need to acknowledge that this file is provided by
% Cheng He (chenghehust@gmail.com).
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 Cheng He

    [N,~] = size(PopObj);
    NV    = size(V,1);
    
    %% Translate the population
    PopObj = PopObj - repmat(min(PopObj,[],1),N,1);

    %% Associate each solution to a reference vector
    Angle   = acos(1-pdist2(PopObj,V,'cosine'));
    [~,associate] = min(Angle,[],2);
    active  = unique(associate);
	num     = NV-length(active);
end