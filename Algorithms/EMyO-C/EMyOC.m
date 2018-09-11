function EMyOC(Global)
% <algorithm> <A-G>
% Clustering-Based Selection for Evolutionary Many-Objective Optimization
% operator --- DEMR

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2017 Roman Denysiuk

    %% Generate random population
    % Initialize population
    Population = Global.Initialization();
    % Initialize ideal point
    Z = min(Population.objs,[],1);

    %% Optimization
    while Global.NotTermination(Population)
        % Perform variation
        Offspring = Global.Variation(Population([1:Global.N,randi(Global.N,1,2*Global.N)]),Global.N,@DEMR);
        % Update the ideal point
        Z = min(Z,min(Offspring.objs,[],1));
        % Form new population
        Population = EnvironmentalSelection([Population,Offspring],Global.N,Z);
    end
end