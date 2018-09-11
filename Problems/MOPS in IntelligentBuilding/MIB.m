function varargout = MIB(Operation,Global,input)
% <problem> <MOP in IntelligentBuildings>
% IntelligentBuildings for Evolutionary Multi-Objective Optimization
% operator --- EAreal

    switch Operation
        case 'init'
            Global.M        = 3;
            Global.D        = Global.M + 9;
            Global.lower    =[0 0 0 0 9];
            Global.upper    = [15 10 20 10 10];
            bounds=[0 0 0 0 9;15 10 20 10 10];
            Global.operator = @EAreal;

%             PopDec    = rand(input,Global.D);
            PopDec    = rand(input,Global.D).*repmat(Global.upper-Global.lower,input,1) + repmat(Global.lower,input,1);
            PopDec = floor(PopDec);
            varargout = {PopDec};
        case 'value'
            PopDec = input;

            PopObj = pvwg_2(PopDec);
            
            PopCon = [];
            
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f = zeros(input, Global.M);
%             f = UniformPoint(input,Global.M);
%             f = f./repmat(sqrt(sum(f.^2,2)),1,Global.M);
            varargout = {f};
    end
end