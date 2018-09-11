function MOEADD(Global)
% <algorithm> <H-N>
% An Evolutionary Many-Objective Optimization Algorithm Based on Dominance
% and Decomposition
% delta --- 0.9 --- The probability of choosing parents locally

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
    delta = Global.ParameterSet(0.9);

    %% Generate the weight vectors
    [W,Global.N] = UniformPoint(Global.N,Global.M);
    T = ceil(Global.N/10);

    %% Detect the neighbours of each solution
    B = pdist2(W,W);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %% Generate random population
    Population = Global.Initialization();
    [~,Region] = max(1-pdist2(Population.objs,W,'cosine'),[],2);
    FrontNo    = NDSort(Population.objs,inf);
    Z          = min(Population.objs,[],1);

    %% Optimization
    while Global.NotTermination(Population)
        % For each solution
        for i = 1 : Global.N            
            % Choose the parents
            Ei = find(ismember(Region,B(i,:)));
            if rand < delta && length(Ei) >= 2
                P = Ei(randperm(length(Ei)));
            else
                P = randperm(Global.N);
            end

            % Generate an offspring
            Offspring = Global.Variation(Population(P(1:2)),1);
            [~,offRegion] = max(1-pdist2(Offspring.obj,W,'cosine'));

            % Add the offspring to the population
            Population = [Population,Offspring];
            PopObj     = Population.objs;
            Region     = [Region;offRegion];
            FrontNo    = UpdateFront(PopObj,FrontNo);
            
            % Update the ideal point
            Z = min(Z,Offspring.obj);

            % Delete a solution from the population
            if max(FrontNo) == 1
                x = LocateWorst(PopObj,W,Region,FrontNo,Z);
            else
                Fl = find(FrontNo==max(FrontNo));
                if length(Fl) == 1
                    if sum(Region==Region(Fl)) > 1
                        x = Fl;
                    else
                        x = LocateWorst(PopObj,W,Region,FrontNo,Z);
                    end
                else
                    SubRegion = unique(Region(Fl));
                    temp   = tabulate(Region(ismember(Region,SubRegion)));
                    Crowd  = zeros(1,size(W,1));
                    Crowd(temp(:,1)) = temp(:,2);
                    Phi    = find(Crowd==max(Crowd));
                    PBI    = CalPBI(PopObj,W,Region,Z,ismember(Region,Phi));
                    PBISum = zeros(1,size(W,1));
                    for j = 1 : length(PBI)
                        PBISum(Region(j)) = PBISum(Region(j)) + PBI(j);
                    end
                    [~,Phi] = max(PBISum);
                    Phih    = find(Region==Phi);
                    if length(Phih) > 1
                        [~,x] = max(PBI(Phih));
                        x = Phih(x);
                    else
                        x = LocateWorst(PopObj,W,Region,FrontNo,Z);
                    end
                end
            end
            Population(x) = [];
            Region(x)     = [];
            FrontNo       = UpdateFront(Population.objs,FrontNo,x);
        end
    end
end