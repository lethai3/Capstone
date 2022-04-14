%% Simulation Data
simu = simulationClass();

%Loading the predefined PTO system design values & Simulink file
%Lin_pump_design_Param; % to load the parameters associated with MyDesignRO.slx
%simu.simMechanicsFile = 'basis_modif.slx';      %Location of Simulink Model File with PTO-SIm

Four_cyl_design_Param;
%simu.simMechanicsFile = 'Heave_NREL_solve_4cyl.slx';
%simu.simMechanicsFile = 'RM3_Hydraulic_PTO';
%simu.simMechanicsFile = 'ADAPT_SDCAL_NoAccum_11_17_2020.slx'  ;
%simu.simMechanicsFile = 'Post_ADAPT_SDCAL_NoAccum_Pitch_3_28_2021'  ;

%-----Using in November 30th 2021----------------------------------------
%simu.simMechanicsFile = 'ADAPT_SDCAL_NoAccum_2Cyl_DA_3_24_2021.slx'  ;
simu.simMechanicsFile = 'ADAPT_SDCAL_YesAccum_2Cyl_DA_11_30_2021.slx'  ;
%----------------------------------------------------------------------

%simu.simMechanicsFile = 'AD_HeavePitch_SDCAL_11_18_2020.slx';
%simu.simMechanicsFile = 'Post_ADAPT_SDCAL_NoAccum_12_16_2020.slx';
%simu.simMechanicsFile = 'ADAPT_SDCAL_PID_NoAccum_1_29_2021.slx';

%simu.simMechanicsFile = 'Heave_NREL_solve_4cyl_old.slx';

simu.startTime = 0;                     
simu.rampTime =50;                       
%simu.endTime=2050;
simu.endTime=200;
%simu.endTime=200;
%simu.solver = 'ode4';
%simu.solver = 'ode14x';
%simu.solver = 'ode45';
simu.dt = sample_time;  
simu.CITime=100; 

%% Wave Information

%waves = waveClass('irregular');
%waves.spectrumType='PM';

waves = waveClass('regular');

%Sea State 1
%{
waves.H = 0.5;
waves.T = 6;
%}

%Sea State 2
%{
waves.H = 0.5;
waves.T = 10;
%}

%Sea State 3
%
waves.H = 1.0;
waves.T = 6;
%}

%Sea State 4
%{
waves.H = 1.5;
waves.T = 7;
%}

%Sea State 5
%{
waves.H = 2;
waves.T = 7;
%}

%Sea State 6
%{
waves.H = 3;
waves.T = 7;
%}

waves.phaseSeed = 1;

%% Body Data

%body(1) = bodyClass('hydroData\buoy_cube_6m.h5');
%body(1) = bodyClass('hydroData\buoyExt_cube_6m.h5'); %works the same as the other one
body(1) = bodyClass('hydroData\Nemoh_Pitch2mx3mx3in_0p15_to_30p0_3_27_2021_6m.h5');

%body(1) = bodyClass('hydroData\buoyExtended_new.h5');
%body(1) = bodyClass('hydroData\buoy_cube_6m.h5');
%body(1) = bodyClass('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\hydroData\buoyExtended_new.h5');


body(1).geometryFile = ('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\geometry\buoy.stl');
%body(1).geometryFile = ('geometry\BF_Pitch_Flap_vOne.stl');
%body(1).geometryFile = ('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\ICOE_2021\geometry\BF_Pitch_Flap_vOne.stl');
%body(1).geometryFile = ('geometry\SD_CAL_ADAPT_Assembly.stl');

%body(1) = bodyClass('../hydroData/hydroData.h5'); 
%body(1).geometryFile = ('../geometry/buoyExt.stl');  

%***************************************************
%May need to change these below for the pitch case
body(1).mass = 244; %244kg for flap | 500for cube | 1000 for ext cube
I1=(1/12)*2*2^3;
I2=(1/12)*2*1^3;
Iyy=(I1+0.182*2^2) + (I2+244*0.5^2);
body(1).momOfInertia = [0 Iyy 0];
%***************************************************

% body(2) = bodyClass('hydroData\Anchor_907kg_6m.h5'); %anchor
% %body(2) = bodyClass('hydroData\buoyExt_cube_6m.h5');
% body(2).geometryFile = ('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\geometry\buoy.stl');      
% body(2).mass = 907; %500for cube | 1000 for ext cube
% %body(2).momOfInertia = body(2).mass/12*[1 1 1];

%body(1) = bodyClass('../hydroData/hydroData.h5'); 
%body(1).geometryFile = ('../geometry/buoyExt.stl');
%----------------------
%Viscous damping
%----------------------
%Linear Damping
%body(1).linearDamping %linear damping

%Quadratic Damping
%body(1).viscDrag.cd
%body(1).viscDrag.characteristicArea

%Morison Element viscosity
% simu.morisonElement  = 1;
% body(1).morisonElement.cd=
% body(1).morisonElement.ca=
% body(1).morisonElement.characteristicArea=
% body(1).morisonElement.VME=
% body(1).morisonElement.rgME=

%values used for the OSWEC desal flap
%They used a cd of 1 specified for the face normal to
%flap surface and used 5 Morison elements up the vertical side of
%the flap. 
% body(1).morisonElement.cd = ones (5,3);
% body(1).morisonElement.ca = zeros(5,3);
% body(1).morisonElement.characteristicArea = zeros(5,3);
% body(1).morisonElement.characteristicArea(:,1) = 18*1.8;
% body(1).morisonElement.characteristicArea(:,3) = 18*1.8;
% body(1).morisonElement.VME  = zeros(5,1);
% body(1).morisonElement.rgME = [0 0 -3; 0 0 -1.2; 0 0 0.6; 0 0 2.4; 0 0 4.2];


%% PTO and Constraint Parameters
% % Translational PTO
pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
pto(1).k = 0;                           % PTO Stiffness [N/m]
pto(1).c = 0;                           % PTO Damping [N/(m/s)]
pto(1).loc = [0 0 -3];                   % PTO Location [m]

% constraint(1)= constraintClass('Constraint1'); % Initialize ConstraintClass 
% constraint(1).loc = [0 0 0];
% 
% constraint(2)= constraintClass('Constraint2'); % Initialize ConstraintClass 
% constraint(2).loc = [0 0 -6];
% 
% constraint(3)= constraintClass('Constraint3'); % Initialize ConstraintClass 
