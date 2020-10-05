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




