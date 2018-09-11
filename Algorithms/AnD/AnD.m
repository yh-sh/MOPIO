function AnD(Global)
% <algorithm> <A-G>
%*********************************************************************************
%  Author: Zhi-Zhong Liu, Yong Wang, and Pei-Qiu Huang
%  Last Edited: 18/06/2018
%  Email: zhizhongliu@csu.edu.cn; ywang@csu.edu.cn; and pqhuang@csu.edu.cn
%  Reference: AnD: A Many-Objective Evolutionary Algorithm with Ange-Based
%  Selection and Shift-Based Density Estimation, Information Sciences. In 
%  Press              
%*********************************************************************************

    %% Generate random population
    Population = Global.Initialization();
    Zmin       = min(Population(all(Population.cons<=0,2)).objs,[],1);
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,sum(max(0,Population.cons),2));
        Offspring  = Global.Variation(Population(MatingPool));
        Zmin       = min([Zmin;Offspring(all(Offspring.cons<=0,2)).objs],[],1);
        Population = EnvironmentalSelection([Population,Offspring],Global.N,Zmin);
    end
end