function []=Postprocess_Folder(myFolder,configuration,FILTER)

% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

% Initialization of the relevant information
PF=[];XP=[];QP=[];Power=[];QB=[]; % brut 
% Loop over all the relevant file in the folder
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  File = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', baseFileName);
  % Rename adequately the name of the file for postprocessing
  filename_buffer=load(File);
  
  %Correct name of feed pressure below
   P_feed=filename_buffer.output_RO.signals.values(:,5); %Feed pressure [Pa]
    
  oldnames = {'Q_brin','Q_feed','Q_perm','F_PTO','P_PTO','X_brin','X_perm','X_feed','dP','t'};
  newnames = {'QB'    ,  'QF'  ,'QP'    ,'F'    ,'Power'  ,'XB'    ,'XP'    ,'XF'  ,'P_RO_drop','time'};
  for kk=1:max(size(oldnames))
      SeaStatesResults(k).(newnames{kk}) = filename_buffer.(oldnames{kk}) ;   
  end
  SeaStatesResults(k).waves=filename_buffer.waves.waveAmpTime(:,2);
  % Concatenate the results
  %PF=[PF,SeaStatesResults(k).P_RO_drop]; %This is not pressure feed
  PF=[PF,P_feed]; %*********change this
  XP=[XP,SeaStatesResults(k).XP];
  QB=[QB,SeaStatesResults(k).QB];
  QP=[QP,SeaStatesResults(k).QP];
  Power=[Power,SeaStatesResults(k).Power];
end


%--------------------------------------------------------------------
if FILTER==1
period=100*1600:100*1800;
nb=100;
time=SeaStatesResults(5).time;
time=time(period,1);
QP_filter=hampel(SeaStatesResults(5).QP(period,1),nb);
QB_filter=hampel(SeaStatesResults(5).QB(period,1),100*nb);
[QB_up,QB_down]=envelope(QB_filter,100,'peak');
[PF_up,PF_down]=envelope(SeaStatesResults(5).P_RO_drop(period,1),100,'peak');
Power_filter=SeaStatesResults(5).Power(period,1);
[Power_up,Power_down]=envelope(Power_filter,50,'peak');
amplitude=SeaStatesResults(5).waves;
amplitude=amplitude(period,1);
QF_filter=QB_up+QP_filter;
Posmo=30*ones(size(time));

figure()
subplot(4,1,1)
plot(time,amplitude,'-c')
xlabel('Time [s]','Fontsize',15)
ylabel('Wave elevation [m]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,2)
plot(time,Power_up/10^3,'-k')
xlabel('Time [s]','Fontsize',15)
ylabel('Absorbed Power [kW]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,3)
plot(time,QP_filter,'-m',time,QB_filter,'--b',time,QF_filter,'--r')
legend('Q_{P}','Q_{B}','Q_{F}')
xlabel('Time [s]','Fontsize',15)
ylabel('Flow Rate [m^3 s^{-1}]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,4)
plot(time,PF_up/10^5,'-r',time,Posmo,'--r')
xlabel('Time [s]','Fontsize',15)
ylabel('Feed Pressure,P [bar]','Fontsize',15)
set(gca,'FontSize',15);
ylim([0 70])
sgtitle(['Sea State 5 with PTO Configuration : ',configuration])

end % FILTER
%--------------------------------------------------------------------



%--------------------------------------------------------------------
if FILTER==0
period=100*1600:100*1800;

for kk=1:6
time=SeaStatesResults(kk).time;
amplitude=SeaStatesResults(kk).waves;
plot_QP=QP(:,kk);
plot_QB=QB(:,kk);
plot_QF=QF(:,kk);
plot_PF=PF(:,kk);
plot_Power=Power(:,kk);

Posmo=30*ones(size(time));

figure()
subplot(4,1,1)
plot(time(period,1),amplitude(period,1),'-c')
xlabel('Time [s]','Fontsize',15)
ylabel('Wave elevation [m]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,2)
plot(time(period,1),plot_Power(period,1)/10^3,'-k')
xlabel('Time [s]','Fontsize',15)
ylabel('Absorbed Power [kW]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,3)
plot(time(period,1),plot_QP(period,1),'-m',time(period,1),plot_QB(period,1),'--b',time(period,1),plot_QF(period,1),'--r')
legend('Q_{P}','Q_{B}','Q_{F}')
xlabel('Time [s]','Fontsize',15)
ylabel('Flow Rate [m^3 s^{-1}]','Fontsize',15)
set(gca,'FontSize',15);
subplot(4,1,4)
plot(time(period,1),plot_PF(period,1)/10^5,'-r',time(period,1),Posmo(period,1),'--r')
xlabel('Time [s]','Fontsize',15)
ylabel('Feed Pressure,P [bar]','Fontsize',15)
set(gca,'FontSize',15);
ylim([0 70])
sgtitle(['Sea State ',num2str(kk),'with PTO Configuration : ',configuration])
end

end % FILTER

%--------------------------------------------------------------------

% Plot a boxplot. X axis = the SeaStates. Y axis the median, 25% and 75%
% percent as well as outliers

figure()
subplot(2,2,1)
boxplot(PF/10^5,'symbol','+')
ylabel('Feed Pressure [bar]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title('Summary of the Feed Pressure')
set(gca,'FontSize',15);
subplot(2,2,2)
boxplot(XP,'symbol','+')
ylabel('Permeate Salinity [ppm]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title('Summary of Permeate Salinity')
set(gca,'FontSize',15);
subplot(2,2,3)
boxplot(QP,'symbol','+')
ylabel('Permeate Salinity [m^3/s]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title('Summary of Permeate Flow')
set(gca,'FontSize',15);
subplot(2,2,4)
boxplot(Power/10^3,'symbol','+')
ylabel('Absorbed Power [kW]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title('Summary of Absorbed Power ')
set(gca,'FontSize',15);
sgtitle(['PTO Configuration :',configuration])

% figure()
% subplot(4,1,1)
% plot(Time(1,:),Wave(1,:),'-c')
% xlabel('Time [s]','Fontsize',15)
% ylabel('Wave elevation [m]','Fontsize',15)
% set(gca,'FontSize',15);
% subplot(4,1,2)
% plot(time_SS1,Power_up_SS1/10^3,'-k')
% xlabel('Time [s]','Fontsize',15)
% ylabel('Absorbed Power [kW]','Fontsize',15)
% ylim([0 0.5])
% set(gca,'FontSize',15);
% subplot(4,1,3)
% plot(time_SS1,QP_SS1,'-m',time_SS1,QB_SS1,'--b',time_SS1,QF_SS1,'--r')
% legend('Q_{P}','Q_{B}','Q_{F}')
% xlabel('Time [s]','Fontsize',15)
% ylabel('Flow Rate [m^3 s^{-1}]','Fontsize',15)
% ylim([0 0.4*10^(-3)])
% set(gca,'FontSize',15);
% subplot(4,1,4)
% plot(time_SS1,PF_up_SS1/10^5,'-r',time_SS1,Posmo,'--r')
% xlabel('Time [s]','Fontsize',15)
% ylabel('Feed Pressure,P [bar]','Fontsize',15)
% ylim([0 50])
% set(gca,'FontSize',15);
end