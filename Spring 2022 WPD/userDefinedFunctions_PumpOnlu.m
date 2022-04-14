% Housekeeping
close all
clear table  
%clear Store_ParamAndPerform
%clear results_Param_tab

%% Local variables
t=out.output_RO.time;
%Aw=3.812*10^(-12); %[m^3/(Ns)]
%Bs=6.986*10^(-8); %[ms-1]
%Am=7.2; %m^2
eps=6*10^4*1*10^(-8);
%Nt=size(output.ptos.time,1);
Nt=size(t,1);
%Nt=size(out.output_RO.time,1);

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
Xavg_perm=trapz(X_perm.*Q_perm);
Xavg_perm3=trapz(X_perm.*Q_perm);
Vtot_perm=trapz(Q_perm);
Vtot_perm3=trapz(t,Q_perm);
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
Xavg_brin=trapz(X_brin.*Q_brin);
Vtot_brin=trapz(Q_brin);
Xavg_brin=Xavg_brin/Vtot_brin;

%% Foundation Load [N]

F_PTO=out.output_Power.signals.values(:,1); %N
P_PTO=abs(out.output_Power.signals.values(:,2)); %W
Velo=out.output_Power.signals.values(:,3); %m/s

%% Saving the relevant parameters into a structure


result.Pavg_PTO=mean(P_PTO); % [W]
result.Pmax_PTO=max(P_PTO); % [W]
result.Fmax_PTO=max(abs(F_PTO) ); % [N]
result.Favg_PTO=mean(abs(F_PTO) ); % [N]

result.Qavg_brin=60*mean(Q_brin); %  [Lmin-1]
result.Qavg_feed=60*mean(Q_feed); % [Lmin-1]
result.Qavg_perm=60*mean(Q_perm); % [Lmin-1]

%result.Xavg_brin=nanmean(X_brin); %[ppm]
%result.Xavg_brin=mean(X_brin); %[ppm]
result.Xavg_brin=Xavg_brin; %[ppm]
result.Xavg_feed=mean(X_feed); %[ppm]
result.Xavg_perm=Xavg_perm; % [ppm]
result.Xmax_perm=max(X_perm); %[ppm]

results_Water_tab(1,1)=result.Qavg_feed;  %  [Lmin-1]
results_Water_tab(1,2)=result.Qavg_perm;  %  [Lmin-1]
results_Water_tab(1,3)=result.Xavg_perm;  %[ppm]
results_Water_tab(1,4)=result.Qavg_brin;  %  [Lmin-1]
results_Water_tab(1,5)=result.Xavg_brin;  %[ppm]

results_Pow_tab(1,1)=result.Pavg_PTO; 
results_Pow_tab(1,2)=result.Pmax_PTO; 
results_Pow_tab(1,3)=result.Fmax_PTO;
results_Pow_tab(1,4)=result.Favg_PTO;

% filename_s='save_WPD_Results';
% save(filename_s,'results_Water_tab','results_Pow_tab','P_PTO','F_PTO',...
%'Q_perm','Q_brin','Q_feed','X_perm','X_brin','','','','','','','','','','');


%% Plots
t_Power=out.output_Power.time;

figure();
% plot(t,P_PTO/10^3,'k',t,mean(P_PTO)/10^3*ones(1,Nt),'--r',t,max(P_PTO)/10^3*ones(1,Nt),'--m')
plot(t_Power,P_PTO/10^3,'k'); hold on;
yline(mean(P_PTO)/10^3,'--r'); hold on;
yline(max(P_PTO)/10^3,'--m'); hold on;
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Absorbed Power',['Avg Absorbed Power : ',num2str(mean(P_PTO)/10^3,4),' kW'],['Max Absorbed Power : ',num2str(max(P_PTO)/10^3,4),' kW'],'Location','northwest')
xlabel('Time [s]')
ylabel('Absorbed Power [kW]')
title('Absorbed Power')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

figure();
 %plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
plot(t_Power,F_PTO,'k'); hold on;
yline(mean(F_PTO),'--r'); hold on;
yline(max(F_PTO),'--m'); hold on;
set(findall(gcf,'type','axes'),'fontsize',12);
legend('Total PTO Force',['Avg Tot PTO Force : ',num2str(mean(F_PTO),4),' N'],...
    ['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' N'],'Location','best');
xlabel('Time [s]')
ylabel('PTO Force [N]')
title('Total PTO Force')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

figure();
%plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
%plot(out.output_Power.time(3180218:end,1),F_PTO(3180218:end,1),'k'); hold on;
plot(out.output_Power.time,F_PTO,'k'); hold on;
%plot(F_PTO,'k'); hold on;
yline(mean(F_PTO),'--r'); hold on;
yline(max(F_PTO),'--m'); hold on;
set(findall(gcf,'type','axes'),'fontsize',12);

legend('Total PTO Force',['Avg Tot PTO Force : ',num2str(mean(F_PTO),4),' N'],...
    ['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' N'],'Location','best')
xlabel('Time [s]')
ylabel('PTO Force [N]')
title('Total PTO Force');
%xlim([1600 1625]);
%xlim([170 195]);
%xlim([120 150]);
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

% figure();
%  plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
% % plot(F_PTO,'k'); hold on;
% % plot(mean(F_PTO)*ones(1,Nt),'--r'); hold on;
% % plot(max(F_PTO)*ones(1,Nt),'--m'); hold on;
% set(findall(gcf,'type','axes'),'fontsize',12);
% legend('Total PTO Force',['Avg Tot PTO Force : ',num2str(mean(F_PTO),4),' N'],...
%     ['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' N'],'Location','best')
% xlabel('Time [s]')
% ylabel('PTO Force [N]')
% title('Total PTO Force');
% xlim([0 25]);
% set(gcf,'color','w');
% grid on

%
figure();
plot(t,(Q_perm*60),'b',t,(mean(Q_perm*60))*ones(1,Nt),'--b',t,eps*60*ones(1,Nt),'--')
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Permeate Rate',['Avg Permeate Rate : ',num2str(mean(Q_perm)*60,4),' L.min^{-1}'],'\epsilon','Location','northwest')
xlabel('Time [s]')
ylabel('Flow rate [L.min^{-1}]')
title('Permeate Flow Rate, Q_{p} ')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

figure()
plot(t,X_perm,'b',t,Xavg_perm*ones(1,Nt),'--b',t,500*ones(1,Nt),'--g',t,1000*ones(1,Nt),'--r')
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Salinity',['Avg Permeate Water Salinity : ',num2str(Xavg_perm,4),' ppm'],'Max Drinking Water Salinity : 500 ppm','Max TDS admissible : 1000 ppm','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Permeate Water Salinity, C_{p} ')
ylim([0 1500]);
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

 figure()
 subplot(4,1,1)
plot(t,out.inputsignals.signals.values(:,1),t,out.inputsignals.signals.values(:,2))
% %plot(t,waves.waveAmpTime(:,2),'Color',[0.3010, 0.7450, 0.9330])
% plot(waves.waveAmpTime(:,2),'Color',[0.3010, 0.7450, 0.9330])
 xlabel('Time [s]')
 legend('Position line','Velocity line');
% xlim([0 size(waves.waveAmpTime(:,2),1)]);
 ylabel('Line Position [m] or [m/s]')
 set(gcf,'color','w');

subplot(4,1,2)
plot(t,60*Q_brin,'k',t,60*Q_feed,'--r',t,60*Q_perm,'b')
legend('Q_{brine}','Q_{feed}','Q_{perm}','Location','northwest')
xlabel('Time [s]')
ylabel('Flow rate [L.min^{-1}]')
set(gcf,'color','w');

subplot(4,1,3)
plot(t,out.output_RO.signals.values(:,5)/10^5,'r')
xlabel('Time [s]')
ylabel('Feed Pressure [bar]')

subplot(4,1,4)
plot(t,X_perm,'--b')
xlabel('Time [s]')
ylabel('C_{p} [ppm]')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting the flow rate
figure()
plot(t,60*Q_brin,'k',t,60*Q_feed,'--r',t,60*Q_perm,'b')
legend('Q_{brine}','Q_{feed}','Q_{perm}','Location','northwest')
xlabel('Time [s]')
ylabel('Flow rate [L.min^{-1}]')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting volume flow rate vs pressure
figure()
plot(P_feed(period,1), Q_feed(period,1)./1000,'o')
xlabel('Feed Pressure [Pa]');
ylabel('Flowrate [m^3/s]');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting the volume flow rate vs. sqrt pressure
figure()
plot(sqrt(P_feed(period,1)), Q_feed(period,1)./1000,'+')
xlabel('Sqrt Feed Pressure [Pa]');
ylabel('Flowrate [m^3/s]');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting the time steps changing
figure; 
plot(t)
ylabel('time')
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting water salinity
figure()
plot(t,X_perm,'b',t,X_brin,'r'); hold on;
yline(X_feed,'k');
yline(Xavg_brin,'--k');
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Permeate','Brine','Feed','Brine avg','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Water Salinity')
ylim([0 50000]);
%xlim([1600 1625]);
%xlim([170 195]);
%xlim([120 150]);
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting Water salinity
figure()
plot(t,X_perm,'b',t,Xavg_perm*ones(1,Nt),'--b',t,500*ones(1,Nt),'--g',t,1000*ones(1,Nt),'--r')
set(findall(gcf,'type','axes'),'fontsize',16);
legend(['Tot Volume Perm [L]: ',num2str(Vtot_perm3)],['Avg Permeate Water Salinity : ',num2str(Xavg_perm,4),' ppm'],'Max Drinking Water Salinity : 500 ppm','Max TDS admissible : 1000 ppm','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Permeate Water Salinity, C_{p} ')
ylim([0 1500]);
%xlim([1600 1625]);
%xlim([170 195]);
%xlim([120 150]);
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%Plotting feed pressure
figure()
plot(t, P_feed/6896);
yline(435);
legend('Feed Pressure','Osmotic Pressure')
ylabel('Feed Pressure [psi]');
xlabel('Times [s]');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
grid on

%figure()

%mean(P_feed/6896)
%}





%% saving the crankshaft pump parameters table

Cyl1_MotionAmp=max(out.output_Crankshaft.signals.values(:,2)) - min(out.output_Crankshaft.signals.values(:,2)); 
Cyl3_MotionAmp=max(out.output_Crankshaft.signals.values(:,3)) - min(out.output_Crankshaft.signals.values(:,3)); 
Ang_Vel_Max=max(out.output_Crankshaft.signals.values(:,1));
Ang_Vel_Mean=mean(out.output_Crankshaft.signals.values(:,1));



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
results_Param_tab(1,21)=mean(Q_feed)*60; %Avg Feed rate
results_Param_tab(1,22)=mean(Q_perm)*60; %Avg Perm rate
results_Param_tab(1,23)=Ang_Vel_Max.*(180/pi).*(1/60); %[rpm] MaxCrank angular velocity
results_Param_tab(1,24)=Ang_Vel_Mean.*(180/pi).*(1/60); %[rpm] MeanCrank angular velocity
results_Param_tab(1,25)=Cyl1_MotionAmp*39.3701; %[in] Cylinder 1 position (req stroke)
results_Param_tab(1,26)=Cyl3_MotionAmp*39.3701; %[in] Cylinder 3 position (req stroke)

%results_Param_tab=results_Param_tab';

%% Save the variables 


% Store_Sent_Array{1}=(['Avg Perm Flow Rate: ',num2str(mean(Q_perm)*60,4),' L.min^{-1}']);
% Store_Sent_Array{2}=(['Avg Perm Salinity: ',num2str(Xavg_perm,4),' ppm']);
% Store_Sent_Array{3}=(['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' [N]']);
% Store_Sent_Array{4}=(['Tot Volume Perm : ',num2str(Vtot_perm3),'  [L]']);

Store_ParamAndPerform=[results_Param_tab, results_Water_tab, results_Pow_tab];


figure; 
plot(out.output_Crankshaft.signals.values(:,1).*(180/pi).*(1/60),'-k','LineWidth',2); hold on
yline(mean(out.output_Crankshaft.signals.values(:,1).*(180/pi).*(1/60)),'--b','LineWidth',2); hold on;
yline(max(out.output_Crankshaft.signals.values(:,1).*(180/pi).*(1/60)),'--r','LineWidth',2); hold on;
%plot(out.output_Crankshaft.signals.values(:,1).*(180/pi),'-b','LineWidth',2); hold on
%plot(out.output_Crankshaft.signals.values(:,1),'-r','LineWidth',2);
%legend('series','mean','max')
%legend('[rpm]','[deg/)
ylabel('Angular Velocity Crank[rpm]');

figure; 
plot(out.output_Crankshaft.signals.values(:,2),'-k','LineWidth',2); hold on
plot(out.output_Crankshaft.signals.values(:,3),'-b','LineWidth',2); hold on
%plot(out.output_Crankshaft.signals.values(:,1).*(180/pi),'-b','LineWidth',2); hold on
%plot(out.output_Crankshaft.signals.values(:,1),'-r','LineWidth',2);
legend('Cyl 1','Cyl 3')
%legend('[rpm]','[deg/)
ylabel('Cylinder Position [m]');

figure; 
plot(out.output_Crankshaft.signals.values(:,2)*39.3701,'-k','LineWidth',2); hold on
plot(out.output_Crankshaft.signals.values(:,3)*39.3701,'-b','LineWidth',2); hold on
%plot(out.output_Crankshaft.signals.values(:,1).*(180/pi),'-b','LineWidth',2); hold on
%plot(out.output_Crankshaft.signals.values(:,1),'-r','LineWidth',2);
legend('Cyl 1','Cyl 3')
%legend('[rpm]','[deg/)
ylabel('Cylinder Position [in]');
