%Plotting file - after having loaded the six sea state files for
%Crankshaft w/o accum, linear B & T w/o accum, linear B & T w/ accum

%------------------------------------
%5/3/2020 -Michael changed how the average permeate concentration is
%brought in. In the "userDefinedFunctions" avg Perm concentration is
%calculated using the code below, so now we just use the average that's
%already calculated in the SS files.
%{
% Salinity of the permeate (derived from the diffusion model)
dP=output_RO.signals.values(:,2); %[Pa]
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
Vtot_perm=trapz(Q_perm);
Xavg_perm=Xavg_perm/Vtot_perm;

X_brin=(X_feed.*Q_feed-X_perm.*Q_perm)./Q_brin; % [mg/L]
%}
%------------------------------------



function Postprocess_Folder_Michael(myFolder,configuration,FILTER,PTO_num)

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
PF=[];XP=[];QP=[];Power=[];QB=[];QF=[]; Q_permMat=[]; Xavg_perm_Mat=[]; % brut
% Loop over all the relevant file in the folder

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    File = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', baseFileName);
    % Rename adequately the name of the file for postprocessing
    filename_buffer=load(File);
    
        %Correct name of feed pressure below
    P_feed=filename_buffer.output_RO.signals.values(:,5); %Feed pressure [Pa]
    
   % mean(filename_buffer.Q_perm)
    oldnames = {'Q_brin','Q_feed','Q_perm','F_PTO','P_PTO','X_brin','X_perm','X_feed','dP','t'};
    newnames = {'QB'    ,  'QF'  ,'QP'    ,'F'    ,'Power'  ,'XB'    ,'XP'    ,'XF'  ,'P_RO_drop','time'};
    
    for kk=1:max(size(oldnames))
        SeaStatesResults(k).(newnames{kk}) = filename_buffer.(oldnames{kk}) ;
    end
    
    %SeaStatesResults(k).waves=filename_buffer.waves.waveAmpTime(:,2);
    
    
    % Concatenate the results
    Q_permMat=[Q_permMat,filename_buffer.Q_perm];
    %QP=[Q_permMat,filename_buffer.Q_perm];
    Xavg_perm_Mat=[ Xavg_perm_Mat,filename_buffer.Xavg_perm];
    PF=[PF,P_feed];
    XP=[XP,SeaStatesResults(k).XP];
    QB=[QB,SeaStatesResults(k).QB];
    %QP=[QP,SeaStatesResults(k).QP];
    QF=[QF,SeaStatesResults(k).QF];
    Power=[Power,SeaStatesResults(k).Power];
    QP=Q_permMat.*60;
    QF=QF*60;
    QB=QB*60;
    RR=QP./QF;
end


%--------------------------------------------------------------------
if FILTER==0

    if PTO_num==3
        period=4*100*1600:4*100*1800;
    else
        period=100*1600:100*1800;
    end
    
    for kk=[1 3 5] %1:6 is for all sea states
        time=SeaStatesResults(kk).time;
        amplitude=SeaStatesResults(kk).waves;
        plot_QP=QP(:,kk); %L/min
        plot_QB=QB(:,kk); %L/min
        plot_QF=QF(:,kk); %L/min
        plot_PF=PF(:,kk); %Pa
        plot_RR=RR(:,kk); % %
        plot_Power=Power(:,kk); %Watt
        
        Posmo=30*ones(size(time));
        P_relief=69*ones(size(time));
        
        figure
        %subplot(4,1,1)
        plot(time(period,1),amplitude(period,1),'-b')
        xlabel('Time [s]','Fontsize',15)
        ylabel('Wave elevation [m]','Fontsize',15)
        set(gca,'FontSize',15);
        title(['SS',num2str(kk),' : ',configuration]);
        
        figure
        %subplot(4,1,2)
        plot(time(period,1),plot_Power(period,1)/10^3,'-k')
        xlabel('Time [s]','Fontsize',15)
        ylabel('Absorbed Power [kW]','Fontsize',15)
        set(gca,'FontSize',15);
        title(['SS',num2str(kk),' : ',configuration]);
        
        figure
        %subplot(4,1,3)
        %plot(time(period,1),plot_QP(period,1),'-m',time(period,1),plot_QB(period,1),'--b',time(period,1),plot_QF(period,1),'--r')
        %legend('Q_{P}','Q_{B}','Q_{F}')
        plot(time(period,1),plot_QP(period,1),'-b')
        legend('Q_{P}')
        xlabel('Time [s]','Fontsize',15)
        ylabel('Flow Rate [L/min]','Fontsize',15)
        set(gca,'FontSize',15);
        title(['SS',num2str(kk),' : ',configuration]);
        
        figure
        %subplot(4,1,3)
        %plot(time(period,1),plot_QP(period,1),'-m',time(period,1),plot_QB(period,1),'--b',time(period,1),plot_QF(period,1),'--r')
        %legend('Q_{P}','Q_{B}','Q_{F}')
        plot(time(period,1),plot_RR(period,1),'-b')
        %legend('Q_{P}')
        xlabel('Time [s]','Fontsize',15)
        ylabel('Recovery Ratio [-]','Fontsize',15)
        set(gca,'FontSize',15);
        title(['SS',num2str(kk),' : ',configuration]);
        
        figure
        %subplot(4,1,4)
        plot(time(period,1),plot_PF(period,1)/10^5,'-b',time(period,1),Posmo(period,1),'--r')
        xlabel('Time [s]','Fontsize',15)
        ylabel('Feed Pressure,P [bar]','Fontsize',15)
        set(gca,'FontSize',15);
        %ylim([0 70])
        title(['SS',num2str(kk),' : ',configuration]);
        
        
    end
    
end % FILTER

%--------------------------------------------------------------------

% Plot a boxplot. X axis = the SeaStates. Y axis the median, 25% and 75%
% percent as well as outliers
%{
figure
%subplot(2,2,1)
boxplot(PF/10^5,'symbol','+')
ylabel('Feed Pressure [bar]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title(['Feed Pressure: ',configuration])
set(gca,'FontSize',15);

figure
%subplot(2,2,2)
boxplot(XP,'symbol','+')
ylabel('Permeate Salinity [ppm]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title(['Permeate Salinity: ',configuration])
set(gca,'FontSize',15);

figure
%subplot(2,2,3)
boxplot(QP,'symbol','+')
ylabel('Permeate Flow rate [m^3/s]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title(['Permeate Flow: ',configuration])
set(gca,'FontSize',15);

figure
%subplot(2,2,4)
boxplot(Power/10^3,'symbol','+')
ylabel('Absorbed Power [kW]','FontSize', 24)
xlabel('Sea States','FontSize', 24)
title(['Absorbed Power: ',configuration])
set(gca,'FontSize',15);
%title(['PTO Configuration :',configuration])

%}



%------------------------------------------------
%Plotting average, 1% and 99% percentiles
%------------------------------------------------

%-------------------------------------------
%Feed Pressure Summary over all Sea States
%-------------------------------------------
PF_1_99 = prctile(PF,[1 99],1)/10^5; %Bar
PF_p1_99p9 = prctile(PF,[0.1 99.9],1)/10^5; %Bar
PF_mean=mean(PF./10^5); %Bar

SS_Vec=[1 2 3 4 5 6];
figure()
plot(SS_Vec,PF_1_99(1,:),'k.',SS_Vec,PF_1_99(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,PF_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [PF_1_99(1,1) PF_1_99(2,1)]);
line([2 2], [PF_1_99(1,2) PF_1_99(2,2)]);
line([3 3], [PF_1_99(1,3) PF_1_99(2,3)]);
line([4 4], [PF_1_99(1,4) PF_1_99(2,4)]);
line([5 5], [PF_1_99(1,5) PF_1_99(2,5)]);
line([6 6], [PF_1_99(1,6) PF_1_99(2,6)]);
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Feed Pressure [bar]');
xlim([0 6.75])
ylim([-1 75])
title('avg , 1 and 99 percentiles');


figure()
plot(SS_Vec,PF_p1_99p9(1,:),'k.',SS_Vec,PF_p1_99p9(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,PF_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [PF_p1_99p9(1,1) PF_p1_99p9(2,1)]);
line([2 2], [PF_p1_99p9(1,2) PF_p1_99p9(2,2)]);
line([3 3], [PF_p1_99p9(1,3) PF_p1_99p9(2,3)]);
line([4 4], [PF_p1_99p9(1,4) PF_p1_99p9(2,4)]);
line([5 5], [PF_p1_99p9(1,5) PF_p1_99p9(2,5)]);
line([6 6], [PF_p1_99p9(1,6) PF_p1_99p9(2,6)]);
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Feed Pressure [bar]');
xlim([0 6.75])
ylim([-1 75])
title('avg , 0.1 and 99.9 percentiles');

%min(PF./10^5)
%max(PF./10^5)
%------------------------------------------------

%-------------------------------------------
%Permeate Salinity Summary over all Sea States
%-------------------------------------------

XP_1_99 = prctile(XP,[1 99],1); %Bar
XP_p1_99p9 = prctile(XP,[0.1 99.9],1); %Bar
%XP_mean=mean(XP); %Bar

SS_Vec=[1 2 3 4 5 6];
figure()
plot(SS_Vec,XP_1_99(1,:),'k.',SS_Vec,XP_1_99(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,Xavg_perm_Mat,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [XP_1_99(1,1) XP_1_99(2,1)]);
line([2 2], [XP_1_99(1,2) XP_1_99(2,2)]);
line([3 3], [XP_1_99(1,3) XP_1_99(2,3)]);
line([4 4], [XP_1_99(1,4) XP_1_99(2,4)]);
line([5 5], [XP_1_99(1,5) XP_1_99(2,5)]);
line([6 6], [XP_1_99(1,6) XP_1_99(2,6)]);
yline(1000,'--k'); yline(500,'--k');
xlabel('Sea State');
ylabel('Permeate Salinity [ppm]');
xlim([0 6.75])
ylim([0 2000])
title('avg , 1 and 99 percentiles');


figure()
plot(SS_Vec,XP_p1_99p9(1,:),'k.',SS_Vec,XP_p1_99p9(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,Xavg_perm_Mat,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [XP_p1_99p9(1,1) XP_p1_99p9(2,1)]);
line([2 2], [XP_p1_99p9(1,2) XP_p1_99p9(2,2)]);
line([3 3], [XP_p1_99p9(1,3) XP_p1_99p9(2,3)]);
line([4 4], [XP_p1_99p9(1,4) XP_p1_99p9(2,4)]);
line([5 5], [XP_p1_99p9(1,5) XP_p1_99p9(2,5)]);
line([6 6], [XP_p1_99p9(1,6) XP_p1_99p9(2,6)]);
yline(1000,'--k'); yline(500,'--k');
xlabel('Sea State');
ylabel('Permeate Salinity [ppm]');
xlim([0 6.75])
ylim([0 2000])
title('avg , 0.1 and 99.9 percentiles');

%min(PF./10^5)
%max(PF./10^5)
%------------------------------------------------

%-------------------------------------------
%Permeate Flow rate Summary over all Sea States
%-------------------------------------------

QP_1_99 = prctile(QP,[1 99],1); %Bar
QP_p1_99p9 = prctile(QP,[0.1 99.9],1); %Bar
QP_mean=mean(QP); %Bar

SS_Vec=[1 2 3 4 5 6];
figure()
plot(SS_Vec,QP_1_99(1,:),'k.',SS_Vec,QP_1_99(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,QP_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [QP_1_99(1,1) QP_1_99(2,1)]);
line([2 2], [QP_1_99(1,2) QP_1_99(2,2)]);
line([3 3], [QP_1_99(1,3) QP_1_99(2,3)]);
line([4 4], [QP_1_99(1,4) QP_1_99(2,4)]);
line([5 5], [QP_1_99(1,5) QP_1_99(2,5)]);
line([6 6], [QP_1_99(1,6) QP_1_99(2,6)]);
xlabel('Sea State');
ylabel('Permeate Flow rate [L/min]');
xlim([0 6.75])
ylim([0 10])
title('avg , 1 and 99 percentiles');


figure()
plot(SS_Vec,QP_p1_99p9(1,:),'k.',SS_Vec,QP_p1_99p9(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,QP_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [QP_p1_99p9(1,1) QP_p1_99p9(2,1)]);
line([2 2], [QP_p1_99p9(1,2) QP_p1_99p9(2,2)]);
line([3 3], [QP_p1_99p9(1,3) QP_p1_99p9(2,3)]);
line([4 4], [QP_p1_99p9(1,4) QP_p1_99p9(2,4)]);
line([5 5], [QP_p1_99p9(1,5) QP_p1_99p9(2,5)]);
line([6 6], [QP_p1_99p9(1,6) QP_p1_99p9(2,6)]);
xlabel('Sea State');
ylabel('Permeate Flow rate [L/min]');
xlim([0 6.75])
ylim([0 10])
%ylim(0)
title('avg , 0.1 and 99.9 percentiles');

%min(PF./10^5)
%max(PF./10^5)
%------------------------------------------------

QP_mean
Xavg_perm_Mat

end











