function [MaxTime, ratio] = Schedule(Dev, Timec, num, List)
% Dev为设备矩阵，Timec为耗时矩阵，List为调度顺序数组如[1,1,2,3,2,3,3,2], num设备数量
M=size(Dev,1);
step=zeros(1,M);%控制产品的移动
suit=zeros(1,M);%控制产品生产次序
Time=zeros(1,num);%各设备工作用时
TimeR = zeros(1,num);%各设备加工用时
for i=1:length(List)
    if step(List(i))==0
        step(List(i))=1;
        TimeR(Dev(List(i),step(List(i)))) = TimeR(Dev(List(i),step(List(i)))) + Timec(List(i),step(List(i)));
        Time(Dev(List(i),step(List(i)))) = Time(Dev(List(i),step(List(i)))) + Timec(List(i),step(List(i)));
        suit(List(i))=Time(Dev(List(i),step(List(i))));
    else
        step(List(i)) = step(List(i))+1;
        TimeR(Dev(List(i),step(List(i)))) = TimeR(Dev(List(i),step(List(i)))) + Timec(List(i),step(List(i)));
        Time(Dev(List(i),step(List(i)))) = Timec(List(i),step(List(i))) + max(suit(List(i)),Time(Dev(List(i),step(List(i)))));
        suit(List(i))=Time(Dev(List(i),step(List(i))));
    end
end
ratioA = TimeR ./ Time; %各设备的利用率
% MaxTime = Time;
% ratio = ratioA;
MaxTime = max(Time); %返回最大时间
ratio = sum(ratioA(:))/M; %平均利用率
end

