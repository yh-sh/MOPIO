function a = Intercepts(PopObj)
% Calculate the intercepts which is used in normalization

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    [N,M] = size(PopObj);

    %% Find the extreme points
    [~,Choosed(1:M)] = min(PopObj,[],1);
    L2NormABO        = zeros(N,M);
    for i = 1 : M
    	L2NormABO(:,i) = sum(PopObj(:,[1:i-1,i+1:M]).^2,2);
    end
    [~,Choosed(M+1:2*M)] = min(L2NormABO,[],1);
    [~,Extreme] = max(PopObj(Choosed,:),[],1);
    Extreme = unique(Choosed(Extreme));
    
    %% Calculate the intercepts
    if length(Extreme) < M
        a = max(PopObj,[],1);
    else
        Hyperplane = PopObj(Extreme,:)\ones(M,1);
        a = 1./Hyperplane';
    end
end

