%% Design Parameter values for the Simulink file

%For the Crankshaft rotary pump

%% Misc
sample_time=0.01/2;
g=9.81;
rho=1024; %[kg/m^3] water density
P_atmos=101325; %[Pa]
depth=5;
%solver='ode45';
%solver='ode15s';

%accumulator_volume=3.78*2.5;%[L]
accumulator_volume=3.78*2.5/1.01;%[L] 3.78 liters per gallon
minimum_gas_volume=0.08;%[L]
precharge_pressure=30e5; %[Pa]


%Below not typed into slx yet
cyl_ExtA_1=0.00114; %[m^2]
cyl_CompB_1=0.00114/3; %[m^2]
%
%Below not typed into slx yet
cyl_ExtA_2=0.00114; %[m^2]
cyl_CompB_2=0.00114/3; %[m^2]

cyl_ExtA_3=0.00114; %[m^2]
cyl_CompB_3=0.00114/3; %[m^2]

cyl_ExtA_4=0.00114; %[m^2]
cyl_CompB_4=0.00114/3; %[m^2]
%}

%%%% RO membrane 
Aw=3.812*10^(-12); %[m^3/(Ns)]
Bs=6.986*10^(-8); %[ms-1]
Am=7.4*2;%7.2; %[m^2] the multiplication by 2 means there are two RO membranes

FR_coeff=0.8; %******************

RO_Membrane_Resistance=1/((Aw)*(Am) ) ;
Flow_Restrictor_Resistance=FR_coeff * RO_Membrane_Resistance;

%1000 psi = 6894757.29 Pa -> ~69e5
%800 psi = 55.16e5 Pa
%435 psi = 30e5 Pa

%Pressure relief valve
cracking_pressure=10*3e4;
maximum_opening_pressure=10*12e4;

%% Crankshaft Pump [SI]

%{
%valve_radius=0.0075;%0.0075; %[m]
%piston_stroke=2;%0.1792; %[m] or 7 in 

%top_piston_area=3.14*(0.01)^2;%3.14*(0.01)^2;%3.14*(0.02)^2;%0.00114; % [m^2]
%bot_piston_area=top_piston_area/3;

%NEW PISTON AREAS
%top_piston_area=(1/8)*0.0037262385749178; %for 0.5m wave height and 7s wave
%top_piston_area=(1/6)*0.0037262385749178; %for 0.5m wave height and 7s wave
%top_piston_area=(1/4)*0.0037262385749178; %for 0.5m wave height and 7s wave
%top_piston_area=(1/2)*0.0037262385749178; %for 1m wave height and 7s wave
top_piston_area=(3/4)*0.0037262385749178; %for 1.5m wave height and 7s wave
%top_piston_area=0.0037262385749178; %for 2m wave height and 7s wave

%top_piston_area=2*0.0037262385749178; %for 2m wave height and 7s wave


top_piston_area=Block_tackle_ratio * top_piston_area;
bot_piston_area=top_piston_area;
%bot_piston_area=0.00184368853769991;
%dis_cap_A1=2.826*2.56*0.01; % initial distance double acting piston [m]

% spool_radius=0.114;%[m]
% crank_radius=0.08; % [m] or 3.136 in 
% rod_length=0.1792; %[m] or 7 in 
% crank_inertia=0.01;
% 
% Crank_ini_angle_C1=pi/2;
% Crank_ini_angle_C2=0;
% Crank_ini_angle_C3=3*pi/2;
% Crank_ini_angle_C4=pi;
% 
% dis_cap_A1=2.826*2.56*0.01; % [m]
% dis_cap_A2=6.5*2.56*0.01;
% dis_cap_A3=2.826*2.56*0.01;
% dis_cap_A4=0.25*2.56*0.01;

%% Hydraulic system 






% %%% Flow restrictor
% coeff_flow_rest=0.5;%0.5;
% 



%}