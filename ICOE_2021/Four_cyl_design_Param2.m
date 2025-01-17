%% Design Parameter values for the Simulink file

%For the Crankshaft rotary pump

%The design parameters specified below were used for the DESIGN stage
%submission. 

%% Misc Simulation parameters
sample_time=0.01/2;
g=9.81;
rho=1024; %[kg/m^3] salt water density
P_atmos=101325; %[Pa]
depth=5; %[m]
%solver='ode45';
%solver='ode15s';

%% Absorber

%Width=2m | Height=1m | Length=1m
%Weight= 1000 kg coming from water ballast
%Lower half is water ballast, upper half is air inflatables


%% Hydraulic Circuit

%--------------------------------------
% Accumulator
%--------------------------------------
%accumulator_volume=3.78*2.5;%[L] This is for 2.5 gallons
accumulator_volume=3.78*2.5/1.01;%[L] 3.78 liters per gallon
minimum_gas_volume=0.08;%[L]
precharge_pressure=30e5; %[Pa]

%--------------------------------------
% RO membrane 
%--------------------------------------
Aw=3.812*10^(-12); %[m^3/(Ns)] - Water transport coeff from membrane manufacturer
Bs=6.986*10^(-8); %[ms-1] - Salt transport coeff from membrane manufacturer
Am=7.4*2;%7.2; %[m^2] the multiplication by 2 means there are two RO membranes

FR_coeff=0.8; %********* Setting of flow restrictor (as fraction of membrane)
              %usually around 0.5

RO_Membrane_Resistance=1/((Aw)*(Am) ) ; %resistance provided by membrane
Flow_Restrictor_Resistance=FR_coeff * RO_Membrane_Resistance; %resistance provided by flow restrictor

Input_Conc=35000; %[ppm] or [mg/L] - concentration of salt in ocean water
%1000 psi = 6894757.29 Pa -> ~69e5
%800 psi = 55.16e5 Pa
%435 psi = 30e5 Pa

%Osmotic pressure relief valve - simulates pressure need above osmotic pressure
max_pass_A_OSM=10*pi*(0.75/2)^2; %[in^2] %This is a nonphysical valve just for simulation
valve_P_OSM=30; %[bar] - valve pressure setting
valve_reg_OSM=2; %[bar] - valve regulation range

%--------------------------------------
%Pressure relief valve
%--------------------------------------
max_pass_A=pi*(0.75/2)^2; %[in^2] - max passage area (0.75 in line)
cracking_pressure=10*3e4;
maximum_opening_pressure=10*12e4;

%% Rotary pump


%---------------------------------------
%Spring
%---------------------------------------
Spring_const=-200; %[N/m] We may shrink this but this was used for DESIGN stage
Zero_Spr_F=4; %[m] the depth at which there would be zero spring force
              %The spring is preloaded with tension, but if the absorber
              %was at Zero_Spr_F depth, there wouldn't be any tension
%---------------------------------------
%Crankshaft elements
%---------------------------------------
Crank_radius= 0.1593/2; %[m]
Spool_radius= 3*0.1520/4; %[m]

Crank_init_angle_1= pi/2; %[rad]
Crank_init_angle_2= 0;    %[rad]
Crank_init_angle_3= 3*pi/2; %[rad]
Crank_init_angle_4= pi; %[rad]
%---------------------------------------
%Cylinders
%---------------------------------------
%Cylinder 1
cyl_ExtA_1=0.00114; %[m^2] Cylinder Area extension side
cyl_CompB_1=0.00114/3; %[m^2] Cylinder Area compression side
Stroke_1=7; %[in] cylinder stroke length
Init_dist_Cap_1=2.826; %[in] %initial distance from cap 
%Computed to match the crankshaft angular offset for all cylinders

%Cylinder 2
%Below not typed into slx yet
cyl_ExtA_2=0.00114; %[m^2] Cylinder Area extension side
cyl_CompB_2=0.00114/3; %[m^2] Cylinder Area compression side
Stroke_2=7; %[in] cylinder stroke length
Init_dist_Cap_2=6.5; %[in] %initial distance from cap 

%Cylinder 3
cyl_ExtA_3=0.00114; %[m^2] Cylinder Area extension side
cyl_CompB_3=0.00114/3; %[m^2] Cylinder Area compression side
Stroke_3=7; %[in] cylinder stroke length
Init_dist_Cap_3=2.826; %[in] %initial distance from cap 

%Cylinder 4
cyl_ExtA_4=0.00114; %[m^2] Cylinder Area extension side
cyl_CompB_4=0.00114/3; %[m^2] Cylinder Area compression side
Stroke_4=7; %[in] cylinder stroke length
Init_dist_Cap_4=0.25; %[in] %initial distance from cap 
%}



%% Linear Pump older values from Remi [SI]

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
%}


%% "Measurements" that we get out of simulation

%{
%Absorber
abs_Lin_velocity= ; %[m/s]
abs_Lin_disp= ; %[m]

%Rotary pump
crank_ang_vel= ; %[ ]
crank_ang_desp= ; %[ ]

crank_torque_Cyl_1= ; %[Nm]
crank_torque_Cyl_2= ; %[Nm]
crank_torque_Cyl_3= ; %[Nm]
crank_torque_Cyl_4= ; %[Nm]
crank_torque_Total= ; %[Nm]

%Hydraulic components
P_sensor_RV= ; %[]

P_cyl_Ext_1= ; %[ ]
P_cyl_Comp_1= ; %[ ]

P_cyl_Ext_2= ; %[ ]
P_cyl_Comp_2= ; %[ ]

P_cyl_Ext_3= ; %[ ]
P_cyl_Comp_3= ; %[ ]

P_cyl_Ext_4= ; %[ ]
P_cyl_Comp_4= ; %[ ]

%-----------------------------------------
%Power and Forces
%-----------------------------------------
F_Cyl_1= ; %[N]
F_Cyl_2= ; %[N]
F_Cyl_3= ; %[N]
F_Cyl_4= ; %[N]

F_PTO_Cyl_1= ; %[N]
F_PTO_Cyl_2= ; %[N]
F_PTO_Cyl_3= ; %[N]
F_PTO_Cyl_4= ; %[N]

F_PTO_Pump= ; %[N]
F_PTO_Spring= ; %[N]
F_PTO_Total= ; %[N]

Pow_Abs_Total= ; %[W]
Pow_Abs_pump= ; %[W]
Pow_Abs_spring= ; %[W]

%-----------------------------------------
%Water Production
%-----------------------------------------
%Permeate
P_Perm_B4= ; %[] - Pressure before the RO membrane
P_drop_Perm= ; %[] - Pressure drop over RO membrane
P_Perm_abv_OSM= ; %[] - Pressure permate above osmotic pressure
P_Perm_Exit= ; %[] Pressure at permeate exit
Cperm= ; %[mg/L] permeate salt concentration
Q_perm= ; %[ ] -flow rate permeate
mdot_Perm= ; %[kg/s] - permeate mass flow rate

%Feed
P_feed= ; %[]
Q_feed= ; % [L/s] - flow rate feed
mdot_feed= ; %[kg/s] - feed mass flow rate

%Brine
Q_Brine= ; % [L/s] - brine flow rate
mdot_Brine= ; %[kg/s] - brine mass flow rate
P_Brine= ; %[] - brine pressure at the RO exit 


%}