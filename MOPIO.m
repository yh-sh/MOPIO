function MOPIO(Global)
% <algorithm> <H-N>
% Multi-objective particle swarm optimization
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
    %[Wmax,Wmin,R] = Global.ParameterSet(1,0.0729,0.9);
    
    %% Generate random population
    Population  = Global.Initialization();
    Zmin       = min(Population(all(Population.cons<=0,2)).objs,[],1);
    %% Optimization
    while Global.NotTermination(Population)
       Offspring = Global.Variation(Population,Global.N,@PIO);
       Zmin       = min([Zmin;Offspring(all(Offspring.cons<=0,2)).objs],[],1);
       Population = EnvironmentalSelection([Population,Offspring],Global.N,Zmin);
    end
end