% Housekeeping
close all
clear table


%% Local variables
t=output_RO.time;
size(t)
%Aw=3.812*10^(-12); %[m^3/(Ns)]
%Bs=6.986*10^(-8); %[ms-1]
%Am=7.2; %m^2
eps=6*10^4*1*10^(-8);
%Nt=size(output.ptos.time,1);
Nt=size(t,1);
%Nt=size(output_RO.time,1);


%Period for 50s t0 250s for averaging over regular waves

RW_start_t=150;
break_loop=0;
ii=1;
while ii<Nt
    if t(ii,1)>=RW_start_t
        ind_RWstart=ii;
        ii=Nt;
    end
    ii=ii+1;
end



t2=t(ind_RWstart:end,1);
t=t2;
Nt=size(t,1);

total_t=t(end,1)-t(1,1);
%period=100*50:100*250; %for regular waves
%period=100*50:100*2050; %for irregular waves
%period=100*500:100*700; %for irregular waves





%% Water Production

Q_feed=output_RO.signals.values(ind_RWstart:end,3); %[m^3/s]
Q_perm=output_RO.signals.values(ind_RWstart:end,4); %[m^3/s]
Q_brin=output_RO.signals.values(ind_RWstart:end,9); %[m^3/s]

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

P_feed=output_RO.signals.values(ind_RWstart:end,5); %Feed pressure [Pa]



%P_feed_avg=mean(P_feed(period,1))/6894.76; %[psi]
%Q_feed_avg=mean(Q_feed(period,1)*60 ); %[L/min]
%Q_perm_avg=mean(Q_perm(period,1)*60); %[L/min]



%% Salinity

% Salinity of the permeate (derived from the diffusion model)
dP=output_RO.signals.values(ind_RWstart:end,2); %[Pa]
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
Xavg_perm=trapz(t,X_perm.*Q_perm);
Vtot_perm=trapz(t,Q_perm);
%Vtot_perm=trapz(Q_perm);
Vtot_perm3=Vtot_perm;
Xavg_perm=Xavg_perm/Vtot_perm;

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
Xavg_brin=trapz(t,X_brin.*Q_brin);
Vtot_brin=trapz(t,Q_brin);
Xavg_brin=Xavg_brin/Vtot_brin;

%% Foundation Load [N]

F_PTO=output_Power.signals.values(ind_RWstart:end,1); %N
P_PTO=abs(output_Power.signals.values(ind_RWstart:end,2)); %W
Velo=output_Power.signals.values(ind_RWstart:end,3); %m/s

%% Saving the relevant parameters into a structure


%P_PTO_avg_check=(1/total_t)*trapz(t,P_PTO)
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


figure();
% plot(t,P_PTO/10^3,'k',t,mean(P_PTO)/10^3*ones(1,Nt),'--r',t,max(P_PTO)/10^3*ones(1,Nt),'--m')
plot(P_PTO/10^3,'k'); hold on;
plot(mean(P_PTO)/10^3*ones(1,Nt),'--r'); hold on;
plot(max(P_PTO)/10^3*ones(1,Nt),'--m'); hold on;
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Absorbed Power',['Avg Absorbed Power : ',num2str(mean(P_PTO)/10^3,4),' kW'],['Max Absorbed Power : ',num2str(max(P_PTO)/10^3,4),' kW'],'Location','northwest')
xlabel('Time [s]')
ylabel('Absorbed Power [kW]')
title('Absorbed Power')
grid on

figure();
% plot(t,F_PTO,'k',t,mean(F_PTO)*ones(1,Nt),'--r',t,max(F_PTO)*ones(1,Nt),'--m')
plot(F_PTO,'k'); hold on;
plot(mean(F_PTO)*ones(1,Nt),'--r'); hold on;
plot(max(F_PTO)*ones(1,Nt),'--m'); hold on;
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Total PTO Force',['Avg Tot PTO Force : ',num2str(mean(F_PTO),4),' N'],...
    ['Max Tot abs PTO Force : ',num2str(max(abs(F_PTO)),4),' N'],'Location','best')
xlabel('Time [s]')
ylabel('PTO Force [N]')
title('Total PTO Force')
grid on


figure();
plot(t,(Q_perm*60),'b',t,(mean(Q_perm*60))*ones(1,Nt),'--b',t,eps*60*ones(1,Nt),'--')
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Permeate Rate',['Avg Permeate Rate : ',num2str(mean(Q_perm)*60,4),' L.min^{-1}'],'\epsilon','Location','northwest')
xlabel('Time [s]')
ylabel('Flow rate [L.min^{-1}]')
title('Permeate Flow Rate, Q_{p} ')
grid on

figure()
plot(t,X_perm,'b',t,Xavg_perm*ones(1,Nt),'--b',t,500*ones(1,Nt),'--g',t,1000*ones(1,Nt),'--r')
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Salinity',['Avg Permeate Water Salinity : ',num2str(Xavg_perm,4),' ppm'],'Max Drinking Water Salinity : 500 ppm','Max TDS admissible : 1000 ppm','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Permeate Water Salinity, C_{p} ')
ylim([0 1500]);
grid on

figure()
subplot(4,1,1)
%plot(t,waves.waveAmpTime(:,2),'Color',[0.3010, 0.7450, 0.9330])
plot(waves.waveAmpTime(:,2),'Color',[0.3010, 0.7450, 0.9330])
xlabel('Time [s]')
xlim([0 size(waves.waveAmpTime(:,2),1)]);
ylabel('Wave elevation [m]')

subplot(4,1,2)
plot(t,60*Q_brin,'k',t,60*Q_feed,'--r',t,60*Q_perm,'b')
legend('Q_{brine}','Q_{feed}','Q_{perm}','Location','northwest')
xlabel('Time [s]')
ylabel('Flow rate [L.min^{-1}]')

subplot(4,1,3)
plot(t,output_RO.signals.values(ind_RWstart:end,5)/10^5,'r')
xlabel('Time [s]')
ylabel('Feed Pressure [bar]')

subplot(4,1,4)
plot(t,X_perm,'--b')
xlabel('Time [s]')
ylabel('C_{p} [ppm]')

% figure()
% plot(P_feed(period,1), Q_feed(period,1)./1000)
% xlabel('Feed Pressure [Pa]');
% ylabel('Flowrate [m^3/s]');
% 
% figure()
% plot(sqrt(P_feed(period,1)), Q_feed(period,1)./1000)
% xlabel('Sqrt Feed Pressure [Pa]');
% ylabel('Flowrate [m^3/s]');

figure; plot(t)

figure()
plot(t,X_perm,'b',t,X_brin,'r',t,Xavg_perm*ones(1,Nt),'--b'); hold on;
yline(X_feed,'k');
yline(Xavg_brin,'--k');
set(findall(gcf,'type','axes'),'fontsize',16);
legend('Permeate','Brine','Feed','Brine avg','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Water Salinity')
ylim([0 50000]);
%xlim([1600 1625]);
xlim([170 195]);
grid on
set(gca,'FontSize',12);
set(gcf,'color','w');

figure()
plot(t,X_perm,'b',t,Xavg_perm*ones(1,Nt),'--b',t,500*ones(1,Nt),'--g',t,1000*ones(1,Nt),'--r')
set(findall(gcf,'type','axes'),'fontsize',16);
legend(['Tot Volume Perm: ',num2str(Vtot_perm3)],['Avg Permeate Water Salinity : ',num2str(Xavg_perm,4),' ppm'],'Max Drinking Water Salinity : 500 ppm','Max TDS admissible : 1000 ppm','Location','northwest')
xlabel('Time [s]')
ylabel('Water Salinity [ppm]')
title('Permeate Water Salinity, C_{p} ')
ylim([0 1500]);
%xlim([1600 1625]);
xlim([170 195]);
grid on
set(gca,'FontSize',12);
set(gcf,'color','w');

figure()
plot(t, P_feed/6896)
ylabel('Feed Pressure [psi]');
xlabel('Times [s]');
set(gca,'FontSize',12);
set(gcf,'color','w');

figure()

mean(P_feed/6896)

%% storing the important values for each run of multicondition run over the time period
