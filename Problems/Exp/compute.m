function time = compute(group)
    for i=1:size(group,2)
       Dev = dev(group(i)); % 取得设备矩阵
       Time = tim(group(i)); % 取得时间矩阵
       list = init(Dev);
       timev = timev + Scheduling(Dev,Time,4,list);
    end
    time = timev;
end