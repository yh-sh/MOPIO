function [Population,z,znad] = EnvironmentalSelection(Population,W,N,K,z,znad)
% The environmental selection of EFR-RR

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %% Normalization
    [PopObj,z,znad] = Normalization(Population.objs,z,znad);

    %% Environmental selection
    RgFrontNo = MaximumRanking(PopObj,W,K);
    count     = tabulate(RgFrontNo);
    MaxFNo    = find(cumsum(count(:,2))>=N,1);
    LastFront = find(RgFrontNo==MaxFNo);
    LastFront = LastFront(randperm(length(LastFront)));
    RgFrontNo(LastFront(1:sum(RgFrontNo<=MaxFNo)-N)) = inf;
    Next      = RgFrontNo <= MaxFNo;
    % Population for next generation
    Population = Population(Next);
end