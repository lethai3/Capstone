%%%% RO membrane 
Aw=3.812*10^(-12); %[m^3/(Ns)]
Bs=6.986*10^(-8); %[ms-1]
Am=7.2; %m^2
%%%% Osmotic pressure
valve_radius=0.01;%0.0095; % m [0.375 in]

%%% Flow restrictor
coeff_flow_rest=0.5;%0.5;

%%% Spring coefficient
K=-200;
spool_radius=0.114;%[m]
crank_radius=0.08; % [m] or 3.136 in 
rod_length=0.1792; %[m] or 7 in 
crank_inertia=0.01;
%%% slider crank

piston_stroke=0.1792; %[m] or 7 in 
top_piston_area=0.00114; % [m^2]
bot_piston_area=top_piston_area/3;
Crank_ini_angle_C1=pi/2;
Crank_ini_angle_C2=0;
Crank_ini_angle_C3=3*pi/2;
Crank_ini_angle_C4=pi;

dis_cap_A1=2.826*2.56*0.01; % [m]
dis_cap_A2=6.5*2.56*0.01;
dis_cap_A3=2.826*2.56*0.01;
dis_cap_A4=0.25*2.56*0.01;

sample_time=0.001;

g=9.81;
rho=1024;
P_atmos=101325;
depth=5;
