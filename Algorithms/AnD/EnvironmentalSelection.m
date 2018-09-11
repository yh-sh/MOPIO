function Population = EnvironmentalSelection(Population,N,Zmin)
% The environmental selection of AnD

CV = sum(max(0,Population.cons),2);
if sum(CV==0) > N
    %% Selection among feasible solutions
    Population = Population(CV==0);
    Next(1:size(Population,2)) = true;
    Delete = LastSelection(Population(Next).objs,sum(Next)-N,Zmin);
    Temp = find(Next);
    Next(Temp(Delete)) = false;
    Population = Population(Next);
else
    %% Selection including infeasible solutions
    [~,rank]   = sort(CV);
    Population = Population(rank(1:N));
end

end


function Delete = LastSelection(PopObj,K,Zmin)

[N,M]  = size(PopObj);
PopObj = (PopObj-repmat(Zmin,N,1))./(repmat(max(PopObj),N,1)-repmat(Zmin,N,1));
Cosine   = 1 - pdist2(PopObj,PopObj,'cosine');
Cosine   = Cosine.*(1-eye(size(PopObj,1)));
% Calculate each individual's SDE
SDE = zeros(1,N);
for i=1:N
    SPopuObj = PopObj;
    Temp     = repmat(PopObj(i,:),N,1);
    Shifted  = PopObj < Temp;
    SPopuObj(Shifted) = Temp(Shifted);
    Distance = pdist2(PopObj(i,:),SPopuObj);
    [~,index] = sort(Distance,2);
    SDE(i) = Distance(index(floor(sqrt(N))+1));
end

%% Environmental selection
Delete  = false(1,N);
% Delete K individuals one by one
while sum(Delete) < K
    [Jmin_row,Jmin_column] = find(Cosine==max(max(Cosine)));
    j = randi(length(Jmin_row));
    Temp_1 = Jmin_row(j);
    Temp_2 = Jmin_column(j);
    
    if  (SDE(Temp_1)<SDE(Temp_2)) ||(SDE(Temp_1)==SDE(Temp_2) && rand<0.5)
        Delete(Temp_1) = true;
        Cosine(:,Temp_1)=0;
        Cosine(Temp_1,:)=0;
    else
        Delete(Temp_2) = true;
        Cosine(:,Temp_2)=0;
        Cosine(Temp_2,:)=0;
    end
end
end