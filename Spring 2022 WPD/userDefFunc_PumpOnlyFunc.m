function [Store_ParamAndPerform]=userDefFunc_PumpOnlyFunc(out,FR_coeff_Setting,rad_Crank_Setting)

% Housekeeping
%close all
%clear table  

%clear Store_ParamAndPerform
%clear results_Param_tab


FR_coeff=FR_coeff_Setting;
rad_Crank=rad_Crank_Setting;
Two_cyl_design_Param_NO_FR_Coeff ;

%% Local variables
t=out.output_RO.time;
%Aw=3.812*10^(-12); %[m^3/(Ns)]
%Bs=6.986*10^(-8); %[ms-1]
%Am=7.2; %m^2
eps=6*10^4*1*10^(-8);
%Nt=size(output.ptos.time,1);
Nt=size(t,1);
%Nt=size(out.output_RO.time,1);

time_ind_Last60=find(t>=20);

%% Water Production

Q_feed=out.output_RO.signals.values(:,3); %[m^3/s]
Q_perm=out.output_RO.signals.values(:,4); %[m^3/s]
Q_brin=out.output_RO.signals.values(:,9); %[m^3/s]

Recov_Ratio=Q_perm./Q_feed;
Recov_Avg=mean(Recov_Ratio);

%Everything is converted to L/s here*********************
Q_feed=Q_feed*1000; %[L/s]
Q_perm=Q_perm*1000; %[L/s]
Q_brin=Q_brin*1000; % [L/s]


%*******************'
%Adding this in to see if it helps numerical issues in X_brin for inf and nan
Q_feed=abs(Q_feed);
Q_brin=abs(Q_brin);
Q_perm=abs(Q_perm);
%
%Loop below prevents any infinit concentrations
for i=1:Nt
    if Q_feed(i,1)< 1*10^(-12)
        Q_feed(i,1)=0;
    end
    if Q_feed(i,1)==0
        Q_brin(i,1)=0;
        Q_perm(i,1)=0;

    end
end
%}
%********************

P_feed=out.output_RO.signals.values(:,5); %Feed pressure [Pa]

%Period for 50s t0 250s for averaging over regular waves 

%period=100*50:100*250; %for regular waves
period=1:size(out.output_RO.time,1); %for regular waves


%period=100*50:100*2050; %for irregular waves
%period=100*500:100*700; %for irregular waves

%P_feed_avg=mean(P_feed(period,1))/6894.76; %[psi]
%Q_feed_avg=mean(Q_feed(period,1)*60 ); %[L/min]
%Q_perm_avg=mean(Q_perm(period,1)*60); %[L/min]



%% Salinity

% Salinity of the permeate (derived from the diffusion model)
dP=out.output_RO.signals.values(:,2); %[Pa]
%dP=output.value(:,2);
X_feed=35000; %[mg/L]
X_perm_ini=X_feed./(dP*Aw/Bs+1); % [mg/L] % We need to modify the modify the expression X_perm (from the diffusion model)
% because it is only valid when there is actually a flow
X_perm=zeros(Nt,1);
for i=1:Nt
    if Q_perm(i,1)<=eps
        X_perm(i,1)=0;
    else
        X_perm(i,1)=X_perm_ini(i,1);
    end %if
end %Nt

% Derive the mean of the Permeate salinity taking into account the Volume
% change
Xavg_perm=trapz(X_perm(time_ind_Last60,1).*Q_perm(time_ind_Last60,1));
Xavg_perm3=trapz(X_perm(time_ind_Last60,1).*Q_perm(time_ind_Last60,1));
Vtot_perm=trapz(Q_perm(time_ind_Last60,1));
Vtot_perm3=trapz(t(time_ind_Last60,1),Q_perm(time_ind_Last60,1));
Xavg_perm=Xavg_perm/Vtot_perm;
Xavg_perm3=Xavg_perm/Vtot_perm3;

Conserv_Water=Q_feed-Q_perm-Q_brin;


X_brin=(X_feed.*Q_feed-X_perm.*Q_perm)./Q_brin; % [mg/L]
%X_brin_avg1=mean(X_brin)
%X_brin_Calc_Num=(X_feed.*Q_feed-X_perm.*Q_perm);

Conserv_Salt=X_feed.*Q_feed-X_perm.*Q_perm-X_brin.*Q_brin;
%figure; plot(X_brin_Calc_Num);
%figure; plot(Conserv_Salt);
%figure; plot(Conserv_Water);

%
%Loop below prevents any infinit concentrations
for i=1:Nt
    if Q_feed(i,1)==0
        X_brin(i,1)=0;

    end
end
%}

% Derive the mean of the Concentrate salinity taking into account the Volume
% change
Xavg_brin=trapz(X_brin(time_ind_Last60,1).*Q_brin(time_ind_Last60,1));
Vtot_brin=trapz(Q_brin(time_ind_Last60,1));
Xavg_brin=Xavg_brin/Vtot_brin;

%% Foundation Load [N]

F_PTO=out.output_Power.signals.values(:,1); %N
P_PTO=abs(out.output_Power.signals.values(:,2)); %W
Velo=out.output_Power.signals.values(:,3); %m/s

%% Saving the relevant parameters into a structure

%Currently adjusting the results to be calculated over the final 40s to
%avoid large values from the beginning seconds

result.Pavg_PTO=mean(P_PTO(time_ind_Last60,1)); % [W]
result.Pmax_PTO=max(P_PTO(time_ind_Last60,1)); % [W]
result.Fmax_PTO=max(abs(F_PTO(time_ind_Last60,1)) ); % [N]
result.Favg_PTO=mean(abs(F_PTO(time_ind_Last60,1)) ); % [N]
result.Fmin_PTO=min((F_PTO(time_ind_Last60,1)) ); % [N]
result.F_RMS_PTO=rms(abs(F_PTO(time_ind_Last60,1)) ); % [N]

[result.Fmax_PTO_2,ind_Fmax]=max(abs(F_PTO(time_ind_Last60,1)) ); % [N]


result.Qavg_brin=60*mean(Q_brin(time_ind_Last60,1)); %  [Lmin-1]
result.Qavg_feed=60*mean(Q_feed(time_ind_Last60,1)); % [Lmin-1]
result.Qavg_perm=60*mean(Q_perm(time_ind_Last60,1)); % [Lmin-1]

%result.Xavg_brin=nanmean(X_brin); %[ppm]
%result.Xavg_brin=mean(X_brin); %[ppm]
result.Xavg_brin=Xavg_brin; %[ppm]
result.Xavg_feed=X_feed; %[ppm]
result.Xavg_perm=Xavg_perm; % [ppm]
result.Xmax_perm=max(X_perm(time_ind_Last60,1)); %[ppm]

results_Water_tab(1,1)=result.Qavg_feed;  %  [Lmin-1]
results_Water_tab(1,2)=result.Qavg_perm;  %  [Lmin-1]
results_Water_tab(1,3)=result.Xavg_perm;  %[ppm]
results_Water_tab(1,4)=result.Qavg_brin;  %  [Lmin-1]
results_Water_tab(1,5)=result.Xavg_brin;  %[ppm]

results_Pow_tab(1,1)=result.Pavg_PTO; 
results_Pow_tab(1,2)=result.Pmax_PTO; 
results_Pow_tab(1,3)=result.Fmax_PTO;
results_Pow_tab(1,4)=result.Favg_PTO;
results_Pow_tab(1,5)=result.Fmin_PTO;

results_Pow_tab(1,6)=result.F_RMS_PTO;
results_Pow_tab(1,7)=Velo(time_ind_Last60(ind_Fmax),1); % [m/s] linear velocity at highest force

%results_Pow_tab(1,8)=Velo(time_ind_Last60(ind_Fmax),1); % [m/s] linear velocity at highest force
%ind_Fmax
%Velo(time_ind_Last60(ind_Fmax),1)
%Velo(ind_Fmax,1)

% filename_s='save_WPD_Results';
% save(filename_s,'results_Water_tab','results_Pow_tab','P_PTO','F_PTO',...
%'Q_perm','Q_brin','Q_feed','X_perm','X_brin','','','','','','','','','','');







%% saving the crankshaft pump parameters table

Cyl1_MotionAmp=max(out.output_Crankshaft.signals.values(time_ind_Last60,2)) - min(out.output_Crankshaft.signals.values(time_ind_Last60,2)); 
Cyl3_MotionAmp=max(out.output_Crankshaft.signals.values(time_ind_Last60,3)) - min(out.output_Crankshaft.signals.values(time_ind_Last60,3)); 
Ang_Vel_Max=max(out.output_Crankshaft.signals.values(time_ind_Last60,1));
Ang_Vel_Mean=mean(out.output_Crankshaft.signals.values(time_ind_Last60,1));
%(time_ind_Last40,1)


results_Param_tab(1,1)=Motion_Amp; %Input motion amplitude
results_Param_tab(1,2)=Motion_Period; %Input motion period
results_Param_tab(1,3)=accumulator_volume; %[L] 
results_Param_tab(1,4)=cyl_CompA_1; %water transport coefficient
results_Param_tab(1,5)=cyl_ExtB_1; %water transport coefficient
results_Param_tab(1,6)=Stroke_1; %water transport coefficient
results_Param_tab(1,7)=Init_dist_Cap_1; %water transport coefficient
results_Param_tab(1,8)=cyl_CompA_3; %water transport coefficient
results_Param_tab(1,9)=cyl_ExtB_3; %water transport coefficient
results_Param_tab(1,10)=Stroke_3; %water transport coefficient
results_Param_tab(1,11)=Init_dist_Cap_3; %water transport coefficient
results_Param_tab(1,12)=Aw; %[m^3/(N*s)] water transport coefficient
results_Param_tab(1,13)=Bs; %[m/s] salt transport coefficient
results_Param_tab(1,14)=Am; %RO membrane area
results_Param_tab(1,15)=FR_coeff; %Fraction of RO membrane resistance
results_Param_tab(1,16)=Flow_Restrictor_Resistance; %[Pa/(m^3/s)] MaxCrank angular velocity
results_Param_tab(1,17)=Spring_const; %Mooring line spring constant N/m
results_Param_tab(1,18)=Zero_Spr_F; %Depth of zero spring force
results_Param_tab(1,19)=rad_Spool; %Spool radius
results_Param_tab(1,20)=rad_Crank; %Crank radius
results_Param_tab(1,21)=mean(Q_feed(time_ind_Last60,1))*60; %Avg Feed rate
results_Param_tab(1,22)=mean(Q_perm(time_ind_Last60,1))*60; %Avg Perm rate
results_Param_tab(1,23)=Ang_Vel_Max.*(180/pi).*(1/60); %[rpm] MaxCrank angular velocity
results_Param_tab(1,24)=Ang_Vel_Mean.*(180/pi).*(1/60); %[rpm] MeanCrank angular velocity
results_Param_tab(1,25)=Cyl1_MotionAmp*39.3701; %[in] Cylinder 1 position (req stroke)
results_Param_tab(1,26)=Cyl3_MotionAmp*39.3701; %[in] Cylinder 3 position (req stroke)
results_Param_tab(1,27)=Vtot_perm3; %[L] Total volume of water produce
results_Param_tab(1,28)=max(Q_feed(time_ind_Last60,1))*60; %[L/min] Max Feed water 


%max(Q_feed)*60
%results_Param_tab=results_Param_tab';

%% Save the variables 


% Store_Sent_Array{1}=(['Avg Perm Flow Rate: ',num2str(mean(Q_perm)*60,4),' L.min^{-1}']);
% Store_Sent_Array{2}=(['Avg Perm Salinity: ',num2str(Xavg_perm,4),' ppm']);
% Store_Sent_Array{3}=(['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' [N]']);
% Store_Sent_Array{4}=(['Tot Volume Perm : ',num2str(Vtot_perm3),'  [L]']);

Store_ParamAndPerform=[results_Param_tab, results_Water_tab, results_Pow_tab];


%% Plotting
% figure;
%  %plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
% plot(t,F_PTO,'k','LineWidth',1.5); hold on;
% yline(mean(F_PTO),'--r','LineWidth',1.5); hold on;
% yline(max(F_PTO),'--m','LineWidth',1.5); hold on;
% yline(rms(F_PTO),'--b','LineWidth',1.5); hold on;
% 
% xline(t(time_ind_Last60(ind_Fmax),1),'-k','LineWidth',1.5); hold on;
% %xline(t(ind_Fmax,1),'-r','LineWidth',1.5); hold on;
% 
% set(findall(gcf,'type','axes'),'fontsize',12);
% legend('Total PTO Force',['Avg Tot PTO Force : ',num2str(mean(F_PTO),4),' N'],...
%     ['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' N'],['RMS Tot abs PTO Force : ',num2str(rms(abs(F_PTO)),4),' N'],'Location','best');
% xlabel('Time [s]')
% ylabel('PTO Force [N]')
% title('Total PTO Force')
% set(gca,'fontname','arial')  % Set it to arial
% set(gcf,'color','w');
% set(gca,'FontSize',14);
% grid on
% 
% figure;
%  %plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
% plot(t,Velo,'k','LineWidth',1.5); hold on;
% yline(mean(Velo),'--r','LineWidth',1.5); hold on;
% yline(max(Velo),'--m','LineWidth',1.5); hold on;
% 
% xline(t(time_ind_Last60(ind_Fmax),1),'-k','LineWidth',1.5); hold on;
% %xline(t(ind_Fmax,1),'-r','LineWidth',1.5); hold on;
% 
% set(findall(gcf,'type','axes'),'fontsize',12);
% legend('Vel ts',['Avg Vel : ',num2str(mean(Velo),4),' m/s'],...
%     ['Max Tot Vel : ',num2str(max(Velo),4),' m/s'],'Location','best');
% xlabel('Time [s]')
% ylabel('Velocity [m/s]')
% title(['Velocity |radCrank=',num2str(rad_Crank,2),' |FR coeff= ',num2str(FR_coeff,4)]);
% set(gca,'fontname','arial')  % Set it to arial
% set(gcf,'color','w');
% set(gca,'FontSize',14);
% grid on
% 
% Velo(time_ind_Last60(ind_Fmax),1)
% Velo(ind_Fmax,1)



%FR_coeff=FR_coeff_Setting;
%rad_Crank=rad_Crank_Setting;

