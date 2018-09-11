function varargout = ParetoBox(Operation,Global,input)
% <problem> <ParetoBox>
% Substitute Distance Assignments in NSGA-II for Handling Many-Objective
% Optimization Problems
% operator --- EAreal

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

persistent Points;

    switch Operation
        case 'init'
            Global.M        = 10;
            Global.D        = 2;
            Global.D        = 2;
            Global.lower    = [0,0];
            Global.upper    = [100,100];
            Global.operator = @EAreal;
            
            Points = [];
            [thera,rho] = cart2pol(0,40);
            [Points(:,1),Points(:,2)] = pol2cart(thera-(1:Global.M)*2*pi/Global.M,rho);
            Points = Points + 50;
            
            PopDec    = rand(input,2)*100;
            varargout = {PopDec};
        case 'value'
            PopDec = input;
            
            PopObj = pdist2(PopDec,Points);
            
            PopCon = [];
            
            varargout = {input,PopObj,PopCon};
        case 'PF'
            [X,Y]     = ndgrid(0:100/(ceil(sqrt(input))-1):100);
            ND        = inpolygon(X(:),Y(:),Points(:,1),Points(:,2));
            PopObj    = pdist2([X(ND),Y(ND)],Points);
            varargout = {PopObj};
        case 'draw'
            cla; Draw(input);
            plot(Points([1:end,1],1),Points([1:end,1],2),'-k','LineWidth',1.5);
            plot(Points(:,1),Points(:,2),'ok','MarkerSize',6,'Marker','o','Markerfacecolor',[1 1 1],'Markeredgecolor',[.4 .4 .4]);
            axis([0 100 0 100]);
            set(gca,'XTick',20:20:100,'YTick',0:20:100);
            xlabel('\itx\rm_1'); ylabel('\itx\rm_2');
    end
end