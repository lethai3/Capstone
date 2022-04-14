%% Design Parameter values for the Simulink file

%For the Crankshaft rotary pump

%% Misc

%For the new NREL solver block or Heave_NREL_solve_4cyl.slx
%sample_time=0.01/8;
%simu.solver = 'ode4';

%For the old solver block or RM3_Hydraulic_PTO.slx

%With no Accumulator
%sample_time=0.01/4;
%simu.solver = 'ode14x';

%With accumulator
sample_time=0.01/8;
simu.solver = 'ode15s';

g=9.81;
rho=1024; %[kg/m^3] water density
P_atmos=101325; %[Pa]
depth=6;
%solver='ode45';
%solver='ode15s';

%accumulator_volume=3.78*2.5;%[L] 3.78 liters per gallon
%accumulator_volume=(3.78/1.01)*2.5;%[L] 2.5 gal (320 fl oz) 
%accumulator_volume=(3.78/1.01)*2*0.5195313;%[L] 2*0.5195 gal (2 of the 66.5 fl oz accums) 
%accumulator_volume=(3.78/1.01)*0.5195313;%[L] 0.5195 gal (66.5 fl oz) - not work SS5
%accumulator_volume=(3.78/1.01)*0.2617188;%[L] 0.2617 gal (33.5 fl oz) 
accumulator_volume=(3.78/1.01)*0.1289063;%[L] 0.1289 gal (16.5 fl oz)  - not work SS5

minimum_gas_volume=0.08;%[L]
precharge_pressure=30e5; %[Pa]
%init_accum_volume=0*accumulator_volume; %[L]Could usually set to 0
init_accum_volume=0.5*accumulator_volume; %[L]Could usually set to 0


%********FOR RM3 file you have to change in xls
%Below not typed into slx yet
%-------1.5inch diameter bore-------------
cyl_CompA_1=0.00114; %[m^2] Cylinder Area extension side  (usually larger)
cyl_ExtB_1=0.00114/2; %[m^2] Cylinder Area compression side
%-------1.96inch diameter bore (50mm)-------------
% cyl_CompA_1=0.001946567; %[m^2] Cylinder Area extension side  (usually larger)
% cyl_ExtB_1=0.001946567/2; %[m^2] Cylinder Area compression side
%-----------------------------------------------------
Stroke_1=7; %[in] cylinder stroke length
Init_dist_Cap_1=2.826; %[in] %initial distance from cap 
%Computed to match the crankshaft angular offset for all cylinders

% %Cylinder 2
% %Below not typed into slx yet
% cyl_CompA_2=0.00114; %[m^2] Cylinder Area extension side (usually larger)
% cyl_ExtB_2=0.00114/2; %[m^2] Cylinder Area compression side
% Stroke_2=7; %[in] cylinder stroke length
% Init_dist_Cap_2=6.5; %[in] %initial distance from cap 

%Cylinder 3
%-------1.5inch diameter bore-------------
cyl_CompA_3=0.00114; %[m^2] Cylinder Area extension side  (usually larger)
cyl_ExtB_3=0.00114/2; %[m^2] Cylinder Area compression side
%-------1.96inch diameter bore (50mm)-------------
% cyl_CompA_3=0.001946567; %[m^2] Cylinder Area extension side  (usually larger)
% cyl_ExtB_3=0.001946567/2; %[m^2] Cylinder Area compression side
%-----------------------------------------------------
Stroke_3=7; %[in] cylinder stroke length
Init_dist_Cap_3=2.826; %[in] %initial distance from cap 

% %Cylinder 4
% cyl_CompA_4=0.00114; %[m^2] Cylinder Area extension side (usually larger)
% cyl_ExtB_4=0.00114/2; %[m^2] Cylinder Area compression side
% Stroke_4=7; %[in] cylinder stroke length
% Init_dist_Cap_4=0.25; %[in] %initial distance from cap
%}

%%%% RO membrane 4040
Aw=3.812*10^(-12); %[m^3/(Ns)]
Bs=6.986*10^(-8); %[ms-1]
Am=7.4;%7.2; %[m^2] the multiplication by 2 means there are two RO membranes

% %%%% RO membrane 4021
% Aw=3.689*10^(-12); %[m^3/(Ns)]
% Bs=6.761*10^(-8); %[ms-1]
% Am=3.1;%7.2; %[m^2] the multiplication by 2 means there are two RO membranes
% 
% %%%% RO membrane 2521
% Aw=3.472*10^(-12); %[m^3/(Ns)]
% Bs=6.363*10^(-8); %[ms-1]
% Am=1.20774;%7.2; %[m^2] the multiplication by 2 means there are two RO membranes

%FR_coeff=0.45; %******************
FR_coeff=0.6; %******************
%FR_coeff=0.9; %******************

C_Valve_Set=FR_coeff;

RO_Membrane_Resistance=1/((Aw)*(Am) ) ; 
%Flow_Restrictor_Resistance=FR_coeff * RO_Membrane_Resistance;
Flow_Restrictor_Resistance=C_Valve_Set * RO_Membrane_Resistance;

%1000 psi = 6894757.29 Pa -> ~69e5
%800 psi = 55.16e5 Pa
%435 psi = 30e5 Pa

%Pressure relief valve
cracking_pressure=10*3e4;
maximum_opening_pressure=10*12e4;

%% Rotary pump


%---------------------------------------
%Spring
%---------------------------------------
Spring_const=-50; %[N/m] We may shrink this but this was used for DESIGN stage
Zero_Spr_F=4; %[m] the depth at which there would be zero spring force
              %The spring is preloaded with tension, but if the absorber
              %was at Zero_Spr_F depth, there wouldn't be any tension

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