function Population = EnvironmentalSelection(Population,N)
% The environmental selection of NSLS

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort(Population.objs,N);
    Next = false(1,length(FrontNo));
    Next(FrontNo<MaxFNo) = true;

    %% Select the solutions in the last front
    Last   = find(FrontNo==MaxFNo);
    Choose = LastSelection(Population(Last).objs,N-sum(Next));
    Next(Last(Choose)) = true;
    % Population for next generation
    Population = Population(Next);
end

function Choose = LastSelection(PopObj,K)
% Select part of the solutions in the last front

    N = size(PopObj,1);
    
    %% Select the extreme solutions first
    Choose = false(1,N);
    [~,Extreme] = min(PopObj,[],1);
    Choose(Extreme) = true;
    [~,Extreme] = max(PopObj,[],1);
    Choose(Extreme) = true;
    
    %% Delete or add solutions to make a total of K solutions be chosen by truncation
    if sum(Choose) > K
        Choosed = find(Choose);
        k = randperm(sum(Choose),sum(Choose)-K);
        Choose(Choosed(k)) = false;
    elseif sum(Choose) < K
        Distance = pdist2(PopObj,PopObj);
        Distance(logical(eye(length(Distance)))) = inf;
        while sum(Choose) < K
            Remain = find(~Choose);
            [~,x]  = max(min(Distance(~Choose,Choose),[],2));
            Choose(Remain(x)) = true;
        end
    end
end