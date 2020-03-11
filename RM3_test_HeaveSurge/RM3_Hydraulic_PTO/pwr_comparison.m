
pwr_H=abs(out_H.signals.values(:,9));
for_H=abs(out_H.signals.values(:,3));
pwr_S=abs(out_S.signals.values(:,9));
for_S=abs(out_S.signals.values(:,3));
pwr_HS=abs(out_HS.signals.values(:,4));
for_HS=abs(out_HS.signals.values(:,3));
time=out_H.time;


figure()
plot(time,pwr_H,'--b')
title('Power Heave only')
figure()
plot(time,pwr_S,'--r')
title('Power Surge only')
figure()
plot(time,pwr_HS,'--k')
title('Power HS')

figure()
plot(time,pwr_H,'--b',time,pwr_S,'--r',time,pwr_HS,'--k')
legend('Heave only','Surge only','HS')
title('Power')

figure()
plot(time,for_H,'--b')
title('Force Heave only')
figure()
plot(time,for_S,'--r')
title('Force Surge only')
figure()
plot(time,for_HS,'--k')
title('Force HS')

figure()
plot(time,for_H,'--b',time,for_S,'--r',time,for_HS,'--k')
legend('Heave only','Surge only','HS')
title('Force Total')