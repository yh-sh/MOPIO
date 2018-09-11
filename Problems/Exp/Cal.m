function F = Cal(P)
%载入数据集
load re.txt
load datasets.txt
xSize = size(P,1);
D = size(P,2);
rel = re;
data = datasets;
f=1./(1+exp(-1.*rel))-0.5;
cost=zeros(1,xSize);   %粒子成本目标
time=zeros(1,xSize);   %粒子时间目标
relat=zeros(1,xSize);   %
for i=1:xSize
    for j=1:D %控制类别
        P(i,j) = round(P(i,j));
        cost(i) = cost(i)+data(P(i,j),1);  %粒子成本
        time(i) = time(i)+data(P(i,j),2);  %粒子时间 待加入调度算法
    end
    % time(i) = compute(P(i,:));
    relat(i)=-relation(P,f,3,i);  %粒子关系和
end
y = zeros(xSize, D);
y(:,1) = cost(:);
y(:,2) = time(:);
y(:,3) = relat(:);
F = y;
end