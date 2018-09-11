function [Population,FrontNo,WHVLoss] = EnvironmentalSelection(Population,N,wz,AA,RA)
% The environmental selection of I-SIBEA

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
    
    %% Calculate the WHV loss of each solution front by front
    WHVLoss = CalWHVLoss(Population.objs,FrontNo,wz,AA,RA);
    
    %% Select the solutions in the last front based on their WHV loss
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(WHVLoss(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next);
    FrontNo    = FrontNo(Next);
    WHVLoss    = WHVLoss(Next);
end