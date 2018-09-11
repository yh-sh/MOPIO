function MSOPSII(Global)
% <algorithm> <H-N>
% MSOPS-II: A general-purpose Many-Objective optimiser

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
    Feasible   = all(Population.cons<=0,2);
    Archive    = UpdateArchive([],Population(Feasible),Global.N);
    Weight     = UpdateWeight([],Population(Feasible).objs,Global.N);

    %% Optimization
    % As the number of solutions in the archive is too large and
    % uncontrollable, use the population as the final output
    while Global.NotTermination(Population)
        Parents    = MatingSelection(Population,Archive);
        Offspring  = Global.Variation(Parents,Global.N);
        Feasible   = all(Offspring.cons<=0,2);
        Archive    = UpdateArchive(Archive,Offspring(Feasible),Global.N);
        Weight     = UpdateWeight(Weight,Offspring(Feasible).objs,Global.N);
        Population = EnvironmentalSelection([Population,Offspring],Weight,Global.N);
    end
end