% Clearpath motor for Desal Pump actuation

clear all
close all

Lin_Vel=0.75; %[m/s]
Lin_Force=6300; %[N]



Motor_AngVel_RPM=0:250:2500;
Motor_AngVel_radPsec=Motor_AngVel_RPM.*(2*pi/1).*(1/60);
Motor_radius_req = Lin_Vel./Motor_AngVel_radPsec;
Lin_Vel_10cm=0.01*Motor_AngVel_radPsec;
Lin_Vel_20cm=0.02*Motor_AngVel_radPsec;
Lin_Vel_5mm=0.005*Motor_AngVel_radPsec;

Motor_Torque_6300=Motor_radius_req*6300;
Motor_Torque_6000=Motor_radius_req*6000;
Motor_Torque_5000=Motor_radius_req*5000;
Motor_Torque_4000=Motor_radius_req*4000;
Motor_Torque_3000=Motor_radius_req*3000;
Motor_Torque_2000=Motor_radius_req*2000;

Motor_Torque_6300_5mm=0.005*6300;
Motor_Torque_6000_5mm=0.005*6000;
Motor_Torque_5000_5mm=0.005*5000;
Motor_Torque_4000_5mm=0.005*4000;
Motor_Torque_3000_5mm=0.005*3000;
Motor_Torque_2000_5mm=0.005*2000;

Motor_Torque_6300_10mm=0.01*6300;
Motor_Torque_6000_10mm=0.01*6000;
Motor_Torque_5000_10mm=0.01*5000;
Motor_Torque_4000_10mm=0.01*4000;
Motor_Torque_3000_10mm=0.01*3000;
Motor_Torque_2000_10mm=0.01*2000;

Motor_Torque_6300_20mm=0.02*6300;
Motor_Torque_6000_20mm=0.02*6000;
Motor_Torque_5000_20mm=0.02*5000;
Motor_Torque_4000_20mm=0.02*4000;
Motor_Torque_3000_20mm=0.02*3000;
Motor_Torque_2000_20mm=0.02*2000;

%----------------------------------------------------------------
%plotting
%----------------------------------------------------------------

%Plotting Motor Radius for different RPMs
figMotorGearRad=figure;
plot(Motor_AngVel_RPM,Motor_radius_req,'-ro','LineWidth',1.5);
xlabel('Motor speed [rpm]');
ylabel('Motor Gear Radius for 1.7 V [m] ');
%legend();
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
%xlim([xlimLowAmp xlimHighAmp]);
grid on;
%xlim([0 0.8]);

%Plotting Motor Req Torque for different Forces vs. rotary speed
figMotorTorque=figure;
plot(Motor_AngVel_RPM,Motor_Torque_6300,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_6000,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_5000,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_4000,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_3000,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_2000,'-o','LineWidth',1.5); hold on;
xlabel('Motor speed [rpm]');
ylabel('Motor Req Torque for 0.75 V [N m] ');
legend('6300 N','6000 N','5000 N','4000 N','3000 N','2000 N');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
%xlim([xlimLowAmp xlimHighAmp]);
grid on;
%xlim([0 0.8]);

%Plotting Motor Req Torque for different Forces vs. rotary speed
figMotorTorque_10cm=figure;
plot(Motor_AngVel_RPM,Motor_Torque_6300_10mm,'-','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_6000_10mm,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_5000_10mm,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_4000_10mm,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_3000_10mm,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Motor_Torque_2000_10mm,'-o','LineWidth',1.5); hold on;
xlabel('Motor speed [rpm]');
ylabel('Motor Req Torque with 10cm Rad [N m] ');
legend('6300 N','6000 N','5000 N','4000 N','3000 N','2000 N');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
%xlim([xlimLowAmp xlimHighAmp]);
grid on;
%xlim([0 0.8]);


%Figure 4 plotting the linear velocity at different spool size (on left)
%and the Torque for different spool size on right 
figLinVel_10cm=figure;
yyaxis left
plot(Motor_AngVel_RPM,Lin_Vel_10cm,'-o','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Lin_Vel_20cm,'--s','LineWidth',1.5); hold on;
plot(Motor_AngVel_RPM,Lin_Vel_5mm,'-.^','LineWidth',1.5); hold on;
xlabel('Motor speed [rpm]');
ylabel('Lin Vel [m/s] ');
%legend('10 cm','20 cm');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
%xlim([xlimLowAmp xlimHighAmp]);
ylim([0 1]);

grid on;

yyaxis right
yline(Motor_Torque_6000_10mm,'-r','LineWidth',1.5); hold on;
yline(Motor_Torque_4000_10mm, '-g','LineWidth',1.5); hold on;
yline(Motor_Torque_3000_10mm, '-k','LineWidth',1.5); hold on;
yline(Motor_Torque_6000_20mm,'--r','LineWidth',1.5); hold on;
yline(Motor_Torque_4000_20mm, '--g','LineWidth',1.5); hold on;
yline(Motor_Torque_3000_20mm, '--k','LineWidth',1.5); hold on;
legend('10 cm','20 cm','5 mm','6000 N|10cm','4000 N|10cm','3000 N|10cm',...
    '6000 N|20cm','4000 N|20cm','3000 N|20cm');
ylabel('Torque [Nm] ');
ylim([0 130]);


%%  Figure 4 plotting the linear velocity at different spool size (on left)
%and the Torque for different spool size on right 
figLinVel_5mm=figure;
yyaxis left
plot(Motor_AngVel_RPM,Lin_Vel_5mm,'-.^','LineWidth',1.5); hold on;
xlabel('Motor speed [rpm]');
ylabel('Lin Vel [m/s] ');
%legend('10 cm','20 cm');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
%xlim([xlimLowAmp xlimHighAmp]);
ylim([0 1]);

grid on;

yyaxis right
yline(Motor_Torque_6000_5mm,'-r','LineWidth',1.5); hold on;
yline(Motor_Torque_5000_5mm, '-g','LineWidth',1.5); hold on;
yline(Motor_Torque_4000_5mm, '-k','LineWidth',1.5); hold on;
yline(Motor_Torque_3000_5mm,'--r','LineWidth',1.5); hold on;
yline(Motor_Torque_2000_5mm,'--k','LineWidth',1.5); hold on;
ylabel('Torque [Nm] ');
legend('5 mm Vel','6000 N|5mm','5000 N|5mm','4000 N|5mm',...
    '3000 N|5mm','2000 N|5mm');
ylim([0 50]);

%% Velocities needed


H=0.5:0.5:3;
T=5:1:15;
T_check=5;

for ii=1:size(H,2)
   for jj=1:size(T,2)       
        Velocity_Wave(ii,jj)=2*H(ii)/T(jj);
    end
end


t=linspace(0, 50, 1000);
y_sine_6000=abs(30*sin((2*pi./T_check).*t));
%y_sine_6000=6000*sin((2*pi/T_check)*t);

%Square
freq=1/T_check; %Hz
offset=0.5;
amp=0.5;
duty=50;
%sq_wave=offset+amp*square(2*pi*freq.*t,duty);
sq_wave=offset+amp*square(2*pi*freq.*t);

y_halfsine_6000=y_sine_6000.*sq_wave;

% Plotting the torque of the sinusoid and that times square wave to get RMS
figure
%for iii=1:2 %size(T,2)
    plot(t,y_sine_6000,'LineWidth',1.5); hold on;
    plot(t,y_halfsine_6000,'k','LineWidth',1.5); hold on;
    plot(t,sq_wave,'r','LineWidth',1.5); hold on;
%end
yline(rms(y_sine_6000),'LineWidth',1.5);
yline(rms(y_halfsine_6000),'LineWidth',1.5);
xlabel('time [s]');
ylabel('Torque [Nm] ');
%legend('10 cm','20 cm');
set(gca,'fontname','arial')  % Set it to arial
set(gcf,'color','w');
set(gca,'FontSize',14);
legend('5s','5s half','Square2','RMS 5s','RMS 5s half');
