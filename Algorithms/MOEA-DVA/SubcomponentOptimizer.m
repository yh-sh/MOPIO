function Population = SubcomponentOptimizer(Global,Population,Neighbour,indices)
% Subcomponent optimizer

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    for i = 1 : length(Population)
        if rand < 0.9
            P = Neighbour(i,randperm(size(Neighbour,2),2));
        else
            P = randperm(length(Population),2);
        end
        OffDec          = Population(i).dec;
        NewDec          = Global.VariationDec(Population([i,P]).decs,1,@DE,{[],[],Global.D/length(indices)/2,[]});
        OffDec(indices) = NewDec(indices);
        Offspring       = INDIVIDUAL(OffDec);
        if sum(Offspring.obj) < sum(Population(i).obj)
            Population(i) = Offspring;
        end
    end
end