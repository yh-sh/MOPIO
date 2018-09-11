function varargout = GBMOP(Operation,Global,input)
% <problem> <Green Building MOP>
% Green Building Multi-objective optimization problem
% operator --- EAbinary （xb批注：待定）

%--------------------------------------------------------------------------
% 绿色建筑多目标优化问题.
%--------------------------------------------------------------------------

% Copyright (c) XB

persistent P W;

    switch Operation   %xb批注:操作种类有3种
        case 'init' %xb批注:1）初始化
            Global.M        = 2; %xb批注（18年08月09日2133）:必须要，目标个数
            Global.D        = 10; %xb批注（18年08月09日2134）:必须要，向量或变量维度
            Global.operator = @EAbinary; %xb批注:必须要，指定演化过程采用的演化算法，包括PSO，DE，EAbinary，EAreal等，具体见Operators目录。待定，后期修改为鸽群，狼群等
            
            [P,W] = Global.ParameterFile(sprintf('MOKP-M%d-D%d',Global.M,Global.D),randi([10,100],Global.M,Global.D),randi([10,100],Global.M,Global.D));
            
            PopDec    = randi([0,1],input,Global.D); %xb批注（18年08月09日2254）:必须要，初始化解矩阵，解矩阵具体参见下面的解释。注意，种群中解的数目N可以通过界面设置。此处可以调用Global.N（在GLOBAL类中默认设置为100）中获得改值，解的维度从Global.M（可以从界面和本代码设置改值）获得。
            PopDec    = GBMOP('value',Global,PopDec);
            varargout = {PopDec}; %xb批注（18年08月09日2303）:必须要
        case 'value' %xb批注（18年08月09日2233）:2）实质计算过程。计算解矩阵input，对应的各个目标函数值，并返回。注意，input每一行代表一个向量，也就是问题的解。
            %xb批注（18年08月09日2239）:比如 
%             input=[1,2;3,4;5,6] 这个3*2矩阵，包括3个解，[1,2]和[3,4]和[5,6]，每个解的维度为2
%             对应的，若有2个目标函数，则PopObj为2*3矩阵
%             PopObj=[11,22,33;44,55,66]，表示
%             对于解[1,2]，对应的子目标1函数值为：11，对应的子目标2函数值为：44
%             对于解[3,4]，对应的子目标1函数值为：22，对应的子目标2函数值为：55
%             对于解[5,6]，对应的子目标1函数值为：33，对应的子目标2函数值为：66
            X = input; %xb批注（18年08月09日2304）:必须要，只是一个赋值操作，后续通过varargout = {X,PopObj,PopCon};返回
            C = sum(W,2)/2;
            [~,rank] = sort(max(P./W));
            for i = 1 : size(X,1)
                while any(W*X(i,:)'>C)
                    k = find(X(i,rank),1);
                    X(i,rank(k)) = 0;
                end
            end
            
            PopObj = repmat(sum(P,2)',size(X,1),1) - X*P'; %xb批注（18年08月09日2303）:必须要，依据实际计算方式修改
            
            PopCon = [];
            
            varargout = {X,PopObj,PopCon}; %xb批注（18年08月09日2249）:必须要
        case 'PF' %xb批注（18年08月09日2234）:3）真实Pareto Front。若该多目标问题真实PF未知，则需自行设置，用以作为参考点，计算IDG。
            RefPoint  = sum(P,2)';
            varargout = {RefPoint}; %xb批注（18年08月09日2305）:必须要，此处的参考点，我们可以自行先设置好，比如，通过多次运行后，获得的近似PF解集中，针对所有解的每个维度，获得每个维度的最大值，形成一个向量，放到这里，作为参考点
        case 'draw' %xb批注（18年08月09日2306）:不需要
            cla; Draw(input*P');
    end
end