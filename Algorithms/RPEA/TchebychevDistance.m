function Distance = TchebychevDistance(PopObj,R)
% Calculate the Tchebychev distance between each individual and reference
% point

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    fmax     = max(PopObj,[],1);
    fmin     = min(PopObj,[],1);
    Distance = zeros(size(PopObj,1),size(R,1));
    for i = 1 : size(PopObj,1)
        Distance(i,:) = max((repmat(PopObj(i,:),size(R,1),1)-R)./(fmax-fmin)./size(PopObj,2),[],2)';
    end
end