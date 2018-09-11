function Load_EV_hour=V2G_double(n_EV,T_peak,mileage1,mileage2,T_arrive1,T_arrive2)


[Load_EV_dis_hour,~]=V2G_discharge(n_EV,T_peak,mileage1,T_arrive1);
[Load_EV_ch_hour]=V2G_charge(n_EV,T_peak,mileage2,T_arrive2);



% Load_EV_hour=(Load_EV_dis_hour+Load_EV_ch_hour).*10;
Load_EV_hour=(Load_EV_dis_hour+Load_EV_ch_hour);
x=1:1:24;
y=Load_EV_hour;
plot(x,y);

x=1:1:24;
y=Load_EV_hour;
plot(x,y)
set(gca,'xtick',(1:1:24))
grid on