function IDBEA(Global)
% <algorithm> <H-N>
% A Decomposition Based Evolutionary Algorithm for Many Objective
% Optimization

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group
    
    %% Generate the reference points (vectors)
    [W,Global.N] = UniformPoint(Global.N,Global.M);
    W = W./repmat(sqrt(sum(W.^2,2)),1,size(W,2));
    
    %% Generate random population
    Population = Global.Initialization();
    z = min(Population.objs);
    a = Intercepts(Population.objs);
    
    %% Optimization
    while Global.NotTermination(Population)
        % For each solution
        for i = 1 : Global.N
            % Generate an offspring
            Offspring = Global.Variation(Population([i,randi(Global.N)]),1);
            % Update the population
            if ~any(sum(Population.objs<=repmat(Offspring.obj,Global.N,1),2)==Global.M)
                % Calculate d1 and d2 values
                List    = randperm(Global.N);
                nPopObj = (Population(List).objs-repmat(z,Global.N,1))./repmat(a-z,Global.N,1);
                nOffObj = (Offspring.obj-z)./(a-z);
                normP   = sqrt(sum(nPopObj.^2,2));
                normO   = sqrt(sum(nOffObj.^2,2));
                CosineP = sum(nPopObj.*W(List,:),2)./normP;
                CosineO = sum(repmat(nOffObj,Global.N,1).*W(List,:),2)./normO;
                d1_old  = normP.*CosineP;
                d1_new  = normO.*CosineO;
                d2_old  = normP.*sqrt(1-CosineP.^2);
                d2_new  = normO.*sqrt(1-CosineO.^2);
                % Replace one parent with the offspring
                Population(List(find(d2_new<d2_old|d2_new==d2_old&d1_new<d1_old,1))) = Offspring;
                % Update the intercepts
                a = Intercepts(Population.objs);
                % Update the ideal point
                z = min(z,Offspring.obj);
            end
        end
    end
end