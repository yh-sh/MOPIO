function varargout = UF9(Operation,Global,input)
% <problem> <UF>
% Multiobjective optimization Test Instances for the CEC 2009 Special
% Session and Competition
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

    switch Operation
        case 'init'
            Global.M        = 3;
            Global.M        = 3;
            Global.D        = 30;
            Global.lower    = [0,0,zeros(1,Global.D-2)-2];
            Global.upper    = [1,1,zeros(1,Global.D-2)+2];
            Global.operator = @EAreal;
            
            PopDec    = rand(input,Global.D).*repmat(Global.upper-Global.lower,input,1) + repmat(Global.lower,input,1);
            varargout = {PopDec};
        case 'value'
            X = input;
            D = size(X,2);

            J1 = 4:3:D;
            J2 = 5:3:D;
            J3 = 3:3:D;
            Y  = X-2*repmat(X(:,2),1,D).*sin(2*pi*repmat(X(:,1),1,D)+repmat(1:D,size(X,1),1)*pi/D);
            PopObj(:,1) = 0.5*(max(0,1.1*(1-4*(2*X(:,1)-1).^2))+2*X(:,1)).*X(:,2)   + 2*mean(Y(:,J1).^2,2);
            PopObj(:,2) = 0.5*(max(0,1.1*(1-4*(2*X(:,1)-1).^2))-2*X(:,1)+2).*X(:,2) + 2*mean(Y(:,J2).^2,2);
            PopObj(:,3) = 1-X(:,2)                                                  + 2*mean(Y(:,J3).^2,2);
            
            PopCon = [];
            
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f = UniformPoint(input,3);
            f(f(:,1)>(1-f(:,3))/4 & f(:,1)<(1-f(:,3))*3/4,:) = [];
            varargout = {f};
    end
end