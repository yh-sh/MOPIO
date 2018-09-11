function MOPIO(Global)
% <algorithm> <H-N>
% Multi-objective particle swarm optimization
% div --- 10 --- The number of divisions in each objective
% operator   --- PIO

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %% Parameter setting
    div = Global.ParameterSet(10);
    
    %% Generate random population
    Population = Global.Initialization();
    Archive    = UpdateArchive([],Population,Global.N,div);
    %Pbest      = Population;
    
    %% Optimization
    while Global.NotTermination(Archive)
        REP        = REPSelection(Archive.objs,Global.N,div);
        Population = Global.Variation([Population,Archive(REP)],Global.N,@PIO);
        Archive    = UpdateArchive(Archive,Population,Global.N,div);
        %Pbest      = UpdatePbest(Pbest,Population);
    end
end