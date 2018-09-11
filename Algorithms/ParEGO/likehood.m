function phi = likehood(PDec,PCheby,theta,F) 
% The likehood calculation according to given theta values.

%--------------------------------------------------------------------------
% The copyright of the PlatEMO belongs to the BIMK Group. You are free to
% use the PlatEMO for research purposes. All publications which use this
% platform or any code in the platform should acknowledge the use of
% "PlatEMO" and reference "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu
% Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective
% Optimization, 2016". We need to acknowledge that this file is provided by
% Cheng He (chenghehust@gmail.com).
%--------------------------------------------------------------------------

% Copyright (c) 2016-2017 Cheng He

    N = size(PDec,1);
    R = zeros(N);
    for i = 1 : N
        for j = 1 : N
            R(i,j) = exp(-sum(theta.*(PDec(i,:)-PDec(j,:)).^2));
        end
    end
    bt     = (F'/R*F)\F'/R*PCheby;
    sigma2 = 1/N.*(PCheby-F*bt)'/R*(PCheby-F*bt);
    phi    = N.*log(sigma2)+log(det(R));
end