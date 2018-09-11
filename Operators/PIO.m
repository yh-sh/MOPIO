function NewParticles = PIO(Global,Parent)
% <operator> <real>
% Particle swarm optimization
% R --- 0.9 --- The inertia weight in PIO

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %[Wmax,Wmin,R] = Global.ParameterSet(1,0.0729,0.9); %随机选的数字，待优化
    R = Global.ParameterSet(0.9);
    Parent      = Parent(min(1:ceil(end/2)*2,end));
    ParentsDec   = Parent.decs;
    [N,D]          = size(ParentsDec);
    ParentsSpeed = Parent.adds(zeros(N,D));

    %% PIO
    %W=Wmin+(Wmax-Wmin)*exp(-Global.evaluated);
    ParentDec   = ParentsDec(1:N/2,:);
    ParentSpeed = ParentsSpeed(1:N/2,:);
    GBestDec      = ParentsDec(N/2+1:end,:);
    NewSpeed = ParentSpeed*exp(-R*Global.evaluated) + rand*(GBestDec-ParentDec);
    NewDec   = ParentDec + NewSpeed;
    
    NewParticles = INDIVIDUAL(NewDec,NewSpeed);
end