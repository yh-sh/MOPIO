function Time = tim( group )
%TIM 此处显示有关此函数的摘要
%   此处显示详细说明
load time.txt
Time = time((group-1)*6+1:group*6,:);
end

