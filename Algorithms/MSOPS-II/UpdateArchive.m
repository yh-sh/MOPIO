function Archive = UpdateArchive(Archive,Population,popsize)
% Update the archive in MSOPS-II

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016".
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 BIMK Group

    %% Combine the archive with the population
    Archive = [Archive,Population];
    ArchObj = Archive.objs;
    N       = length(Archive);

    %% Update the archive by weighted min-max metric
    % Calculate the weighted min-max metric between each two solutions
    WMM = CalMetric(ArchObj,ArchObj);
    % Delete the solutions which do not have the lowest metric value than
    % others according to its own weight vector
    Remain = true(1,N);
    WMM_diagonal = WMM(logical(eye(N)))';
    for i = 1 : N
        if Remain(i)
            if WMM(i,i) >= min(WMM(Remain,i))
                Remain(WMM(i,:)<WMM_diagonal) = false;
            else
                Remain(i) = false;
            end
        end
    end
    Archive = Archive(Remain);
    % If the archive contains too many solutions, randomly delete some. The
    % original algorithm does not limit the size of archive, so that the
    % size of archive will increase immortally
    if length(Archive) > 10*popsize
        Archive = Archive(randperm(length(Archive),5*popsize));
    end
end