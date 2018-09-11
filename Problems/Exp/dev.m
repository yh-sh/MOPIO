function Dev  = dev( group )
load device.txt
Dev = device((group-1)*6+1:group*6,:);
end

