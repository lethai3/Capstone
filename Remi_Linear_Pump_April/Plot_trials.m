%PF=PF3;

%{
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

min(PF3./10^5)
max(PF3./10^5)
%------------------------------------------------

%-------------------------------------------
%Permeate Salinity Summary over all Sea States
%-------------------------------------------

XP_1_99 = prctile(XP,[1 99],1); %Bar
XP_p1_99p9 = prctile(XP,[0.1 99.9],1); %Bar
XP_mean=mean(XP); %Bar

SS_Vec=[1 2 3 4 5 6];
figure()
plot(SS_Vec,XP_1_99(1,:),'k.',SS_Vec,XP_1_99(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,XP_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [XP_1_99(1,1) XP_1_99(2,1)]);
line([2 2], [XP_1_99(1,2) XP_1_99(2,2)]);
line([3 3], [XP_1_99(1,3) XP_1_99(2,3)]);
line([4 4], [XP_1_99(1,4) XP_1_99(2,4)]);
line([5 5], [XP_1_99(1,5) XP_1_99(2,5)]);
line([6 6], [XP_1_99(1,6) XP_1_99(2,6)]);
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Permeate Salinity [ppm]');
xlim([0 6.75])
ylim([0 2000])
title('avg , 1 and 99 percentiles');


figure()
plot(SS_Vec,XP_p1_99p9(1,:),'k.',SS_Vec,XP_p1_99p9(2,:),'k.', 'MarkerSize',12,'MarkerFaceColor','black');
hold on
plot(SS_Vec,XP_mean,'or', 'MarkerSize',6,'MarkerFaceColor','red')
line([1 1], [XP_p1_99p9(1,1) XP_p1_99p9(2,1)]);
line([2 2], [XP_p1_99p9(1,2) XP_p1_99p9(2,2)]);
line([3 3], [XP_p1_99p9(1,3) XP_p1_99p9(2,3)]);
line([4 4], [XP_p1_99p9(1,4) XP_p1_99p9(2,4)]);
line([5 5], [XP_p1_99p9(1,5) XP_p1_99p9(2,5)]);
line([6 6], [XP_p1_99p9(1,6) XP_p1_99p9(2,6)]);
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Permeate Salinity [ppm]');
xlim([0 6.75])
ylim([0 2000])
title('avg , 0.1 and 99.9 percentiles');

%min(PF./10^5)
%max(PF./10^5)
%------------------------------------------------
%}
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
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Permeate Flow rate [L/min]');
xlim([0 6.75])
%ylim([0 2000])
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
yline(30,'--k'); yline(69,'--k');
xlabel('Sea State');
ylabel('Permeate Flow rate [L/min]');
xlim([0 6.75])
%ylim([0 2000])
title('avg , 0.1 and 99.9 percentiles');

%min(PF./10^5)
%max(PF./10^5)
%------------------------------------------------




