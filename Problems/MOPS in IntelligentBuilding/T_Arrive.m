function T_arrive=T_Arrive(n_EV)

MU_t=17.6*60;SIGMA_t=3.4*60;

T_dis_start_max=24*60;


%最后一次返航时刻T_dis_start
T_dis_start=normrnd(MU_t,SIGMA_t,1,n_EV) ;
T_dis_start_max=repmat(T_dis_start_max,1,n_EV);
T_arrive=(T_dis_start>T_dis_start_max).*T_dis_start_max+(T_dis_start<=T_dis_start_max).*T_dis_start;

end