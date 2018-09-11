function [out] = relation(a,b,num,t)

%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
out=0;
for i=1:num
    for j=i:num
        if j~=i
        out=b(a(t,i),a(t,j))+out;
        end
    end
end
end

