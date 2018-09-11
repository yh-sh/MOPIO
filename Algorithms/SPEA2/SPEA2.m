function SPEA2(Global)
% <algorithm> <O-Z>
% SPEA2: Improving the Strength Pareto Evolutionary Algorithm

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %% Generate random population
    Population = Global.Initialization();
    Fitness    = CalFitness(Population.objs);
    
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,Fitness);
        Offspring  = Global.Variation(Population(MatingPool));
        [Population,Fitness] = EnvironmentalSelection([Population,Offspring],Global.N);
    end
end