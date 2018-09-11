function varargout = Exp(Operation,Global,input)
% <problem> <MOP in IntelligentBuildings>
% IntelligentBuildings for Evolutionary Multi-Objective Optimization
% operator --- PIO

    switch Operation
        case 'init'
            %三个服务的组合
            Global.M        = 3;
            Global.D        = 3;
            %假定为100 + 100 + 100的数据集
            Global.lower    =[1, 31, 61];
            Global.upper    = [30, 60, 90];
            Global.operator = @EAreal;
           % PopDec    = rand(input, bounds);
           % PopDec    = crtrp(input, bounds);
             PopDec    = rand(input,Global.D).*repmat(Global.upper-Global.lower,input,1) + repmat(Global.lower,input,1);
             PopDec = floor(PopDec);
            varargout = {PopDec};
        case 'value'
            PopDec = input;
            PopObj = Cal(PopDec);
            
            PopCon = [];
            
            varargout = {input,PopObj,PopCon};
        case 'PF'
           % f = zeros(input, Global.M);
           load pf.mat;
           f(:,1) = flj(:,1);
           f(:,2) = flj(:,2);
           f(:,3) =  - flj(:,3);
%             f = f./repmat(sqrt(sum(f.^2,2)),1,Global.M);
           varargout = {f};
    end
end