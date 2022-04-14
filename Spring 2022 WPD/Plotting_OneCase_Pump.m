%Plotting function

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

%%

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