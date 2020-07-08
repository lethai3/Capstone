%% Housekeeping
close all
clear table  

avg_Pow=mean(-1.*output.ptos.powerInternalMechanics(5000:end,3));
Max_Pow=max(-1.*output.ptos.powerInternalMechanics(5000:end,3));

Max_pos=max(output.ptos.position(5000:end,3));
Min_pos=min(output.ptos.position(5000:end,3));

avg_F=mean(abs(output.ptos.forceTotal(5000:end,3)));
Max_F=max(abs(output.ptos.forceTotal(5000:end,3)));

figure(2)
plot(output.ptos.time(5000:end,1),output.ptos.position(5000:end,3))
xlabel('Time [s]');
ylabel('Vertical Position [m]');
set(findall(gcf,'type','axes'),'fontsize',14);
title(['Period: T=',num2str(waves.T),'s   Wave height: H=',num2str(waves.H),'m']);

figure(3)
plot(output.ptos.time(5000:end,1),output.bodies.position(5000:end,3))
xlabel('Time [s]');
ylabel('Vertical Position [m]');
set(findall(gcf,'type','axes'),'fontsize',14);
title(['Period: T=',num2str(waves.T),'s   Wave height: H=',num2str(waves.H),'m']);


figure(4)
plot(output.ptos.time(5000:end,1),-1.*output.ptos.forceTotal(5000:end,3))
hold on;
%yline(avg_F,'-.k','LineWidth',2); hold on;
yline(Max_F,'--k','LineWidth',2);
xlabel('Time [s]');
ylabel('Force [N]');
legend('Force',['Avg + Force : ',num2str(avg_F,4),' N'],['Max Force : ',num2str(Max_F,4),' N'],'Location','Best');
legend('Force',['Max Force : ',num2str(Max_F,4),' N'],'Location','Best');
set(findall(gcf,'type','axes'),'fontsize',14);
title(['Period: T=',num2str(waves.T),'s   Wave height: H=',num2str(waves.H),'m']);

figure(5)
plot(output.ptos.time(5000:end,1),-1.*output.ptos.powerInternalMechanics(5000:end,3))
hold on
yline(avg_Pow,'-.k','LineWidth',2); hold on;
yline(Max_Pow,'--k','LineWidth',2);
xlabel('Time [s]');
ylabel('Power [W]');
legend('Absorbed Power',['Avg Absorbed Power : ',num2str(avg_Pow,3),' W'],['Max Absorbed Power : ',num2str(Max_Pow,3),' W'],'Location','Best');
set(findall(gcf,'type','axes'),'fontsize',14);
title(['Period: T=',num2str(waves.T),'s   Wave height: H=',num2str(waves.H),'m']);

Results_Tab=[Max_F, avg_Pow, Max_Pow, pto(1).c, pto(1).k, Max_pos, Min_pos  ];


%% Plots 

%set(0,'DefaultFigureWindowStyle','docked')

% figure();
% plot(output.ptosim.time,output.ptosim.pistonNCF.topPressure/1e6,output.ptosim.time,output.ptosim.pistonNCF.bottomPressure/1e6)
% set(findall(gcf,'type','axes'),'fontsize',16)
% xlabel('Time (s)')
% ylabel('Pressure (MPa)')
% title('Piston Pressure')
% legend('topPressure','bottomPressure')
% grid on
% 
% figure();
% plot(output.ptosim.time,output.ptosim.pistonNCF.force/1e6)
% set(findall(gcf,'type','axes'),'fontsize',16)
% xlabel('Time (s)')
% ylabel('Force (MN)')
% title('PTO Force')
% grid on
% 
% 
% figure();
% plot(output.ptosim.time,output.ptosim.pistonNCF.absPower/1e3,output.ptosim.time,output.ptosim.rotaryGenerator.genPower/1e3,output.ptosim.time,output.ptosim.rotaryGenerator.elecPower/1e3)
% set(findall(gcf,'type','axes'),'fontsize',16)
% xlabel('Time (s)')
% ylabel('Power (kW)')
% title('Absorbed Power, Mechanical Power, and Electrical Power')
% legend('absPower','mechPower','elecPower')
% grid on
% 
% figure();
% plot(output.ptosim.time,output.ptosim.hydraulicMotor.angVel)
% set(findall(gcf,'type','axes'),'fontsize',16)
% xlabel('Time (s)')
% ylabel('Speed (rad/s)')
% title('Motor Speed')
% grid on
% 
% % figure()
% % subplot(3,1,1)
% % plot(output.ptosim.time,(output.ptosim.accumulator(1).pressure-output.ptosim.accumulator(2).pressure)/1e6)
% % set(findall(gcf,'type','axes'),'fontsize',16)
% % xlabel('Time (s)')
% % ylabel('Pressure (MPa)')
% % title('Pressure Differential Between the Two Accumulators')
% % grid on
% % subplot(3,1,2)
% % plot(output.ptosim.time,output.ptosim.hydraulicMotor.volFlowM./output.ptosim.hydraulicMotor.angVel)
% % set(findall(gcf,'type','axes'),'fontsize',16)
% % xlabel('Time (s)')
% % ylabel('Volume (m^3)')
% % title('Hydraulic Motor Volume')
% % grid on
% % subplot(3,1,3)
% % plot(output.ptosim.time,((output.ptosim.accumulator(1).pressure-output.ptosim.accumulator(2).pressure).*(output.ptosim.hydraulicMotor.volFlowM./output.ptosim.hydraulicMotor.angVel))/(ptosim.rotaryGenerator.desiredSpeed*1.05))
% % set(findall(gcf,'type','axes'),'fontsize',16)
% % xlabel('Time (s)')
% % ylabel('Damping (kg-m^2/s)')
% % title('Generator Damping')
% % grid on
