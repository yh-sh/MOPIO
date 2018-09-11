function timebest = Scheduling(A,B,num,list)
%SCHEDULING 此处显示有关此函数的摘要
%   此处显示详细说明
T = 1000; %循环次数
pnum = 100; %个体数量
D = size(list,2);
% 备用参数
R=0.9;
wmax=1.0;  %惯性因子
wmin=0.0729;  %惯性因子
dnum = num; %设备数量
x = zeros(pnum,D); %位置矢量
v = zeros(pnum,D); %速度矢量
time = zeros(1,pnum); %两个目标值
ratio = zeros(1,pnum);
% 最优值初始化
tibest=zeros(1,pnum); %粒子时间目标
ratiobest=zeros(1,pnum);  %关系
round = [10, 30]; %粒子范围
for i=1:pnum
    for j=1:D
        x(i,j) = round(1) + (round(2)-round(1))*rand;
    end
end
xbest=x;           %个体最佳值
%% 进入算子前
xsort = zeros(1,D);
lsort = zeros(1,D);
for i=1:pnum
    xsort = x(i,:); 
    [~,pos] = sort(xsort);
    lsort = list(1,pos);
    [time(i),ratio(i)] = Schedule(A,B,dnum,lsort);
end
% 粒子最优位置
tibest=time;
ratiobest=ratio;

%% 初始筛选非劣解
flj=[];
fljx=[];
fljNum=0;
%两个实数相等精度
for i=1:pnum
    flag=0;  %支配标志
    for j=1:pnum
        if j~=i
            if (time(i)>time(j) && ratio(i)<ratio(j))
                flag=1;%不支配标志
                break;
            end
        end
    end
    
    %判断有无被支配
    if flag==0
        fljNum=fljNum+1;
        % 记录非劣解
        flj(fljNum,1)=time(i);
        flj(fljNum,2)=ratio(i);      

        % 非劣解位置
        fljx(fljNum,:)=x(i,:); 
    end
end


%% 循环迭代
for iter=1:T
    
    % 权值更新
    %w=wmin+(wmax-wmin)*exp(-iter);
     
    %从非劣解中选择粒子作为全局最优解
    s=size(fljx,1);       
    index=randi(s,1,1);  
    gbest=fljx(index,:);

    %% 群体更新
    for i=1:pnum
        %速度更新
        %v(i,:) = w*v(i,:) + rand*(gbest-v(i,:));
        v(i,:) = v(i,:) + rand*(gbest-v(i,:));
        %位置更新
        x(i,:)   = x(i,:)*(1-exp(-R*iter))+ v(i,:);
        %越界判断，只判断速度
        for j=1:D
            if(x(i,j)>round(2))||(x(i,j)<round(1))
                x(i,j) = round(1) + (round(2)-round(1))*rand;
            end
        end
    end

    %% 计算个体适应度
    tiPrior(:)=0;
    ratioPrior(:)=0;
    for i=1:pnum
        xsort = x(i,:); 
        [~,pos] = sort(xsort);
        lsort = list(1,pos);
        [tiPrior(i),ratioPrior(i)] = Schedule(A,B,dnum,lsort);
    end
    
    %% 更新粒子历史最佳
    %for %i=1:xSize
        %for j=1:xSize
        %现在的支配原有的，替代原有的
        % if ((cost(i)<cost(j)) &&  (time(i)<time(j)) && reliable(i)>reliable(j) && ec(i)<ec(j))
         %       xbest(i,:)=x(i,:);%      没有记录目标值
          %      cobest(i)=coPrior(i);
           %     tibest(i)=tiPrior(i);
            %    rebest(i)=rePrior(i);
             %   ecbest(i)=ecPrior(i);
       % elseif rand(1,1)<0.5
        %        xbest(i,:)=x(i,:);
         %       cobest(i)=coPrior(i);
          %      tibest(i)=tiPrior(i);
           %     rebest(i)=rePrior(i);
            %    ecbest(i)=ecPrior(i);
         %end
        %end
    %end
 %% 更新粒子历史最佳
    for i=1:pnum
         if ((tibest(i)>tiPrior(i)) && ratiobest(i)<ratioPrior(i))
                xbest(i,:)=x(i,:);%      没有记录目标
                tibest(i)=tiPrior(i);
                ratiobest(i)=ratioPrior(i);
        elseif rand(1,1)<0.1
                xbest(i,:)=x(i,:);
                tibest(i)=tiPrior(i);
                ratiobest(i)=ratioPrior(i);
        end
    end
    %% 更新非劣解集合
    time=tiPrior;
    ratio=ratioPrior;
    %更新升级非劣解集合
    s=size(flj,1);%目前非劣解集合中元素个数
   
    %先将非劣解集合和xbest合并
    tttx=zeros(1,s+pnum);
    rrrx=zeros(1,s+pnum);
    
    tttx(1:pnum)=tibest;tttx(pnum+1:end)=flj(:,1)';
    rrrx(1:pnum)=ratiobest;rrrx(pnum+1:end)=flj(:,2)';
    
    xxbest=zeros(s+pnum,D);
    xxbest(1:pnum,:)=xbest;
    xxbest(pnum+1:end,:)=fljx;
   
    %筛选非劣解
    flj=[];
    fljx=[];
    k=0;
    tol=1e-7;
    for i=1:pnum+s
        flag=0;%没有被支配
        %判断该点是否非劣
        for j=1:pnum+s 
            if j~=i
                if ((tttx(i)>tttx(j)))&&(rrrx(i)<rrrx(j))  %有一次被支配
                    flag=1;
                    break;
                end
            end
        end

        %判断有无被支配
        if flag==0
            k=k+1;
            flj(k,1)=tttx(i);flj(k,2)=rrrx(i);%记录非劣解
            fljx(k,:)=xxbest(i,:);%非劣解位置
        end
    end
    
    %去掉重复粒子
    repflag=0;   %重复标志
    k=1;         %不同非劣解粒子数
    flj2=[];     %存储不同非劣解
    fljx2=[];    %存储不同非劣解粒子位置
    flj2(k,:)=flj(1,:);
    fljx2(k,:)=fljx(1,:);
    for j=2:size(flj,1)
        repflag=0;  %重复标志
        for i=1:size(flj2,1)
            result=(fljx(j,:)==fljx2(i,:));
            if length(find(result==1))==D
                repflag=1;%有重复
            end
        end
        %粒子不同，存储
        if repflag==0 
            k=k+1;
            flj2(k,:)=flj(j,:);
            fljx2(k,:)=fljx(j,:);
        end
        
    end
    
    %非劣解更新
    flj=flj2;
    fljx=fljx2;
end
[~,i] = max(flj(:,1)./(1-flj(:,2)));
timebest = flj(i,1);
%可从fljx中保留调度序列
end
