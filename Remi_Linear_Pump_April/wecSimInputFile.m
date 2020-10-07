%% Simulation Data
simu = simulationClass();

%Loading the predefined PTO system design values & Simulink file
%Lin_pump_design_Param; % to load the parameters associated with MyDesignRO.slx
%simu.simMechanicsFile = 'basis_modif.slx';      %Location of Simulink Model File with PTO-SIm

Four_cyl_design_Param;
simu.simMechanicsFile = 'Heave_NREL_solve_4cyl.slx';

simu.startTime = 0;                     
simu.rampTime =50;                       
%simu.endTime=2050;
simu.endTime=250;
simu.solver = 'ode4';
simu.dt = sample_time;  
simu.CITime=100; 

%% Wave Information

%waves = waveClass('irregular');
%waves.spectrumType='BS';
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
%{
waves.H = 1.0;
waves.T = 6;
%}

%Sea State 4
%
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
body(1) = bodyClass('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\hydroData\buoyExtended_new.h5');
body(1).geometryFile = ('C:\Users\mkell\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\geometry\buoy.stl');
%body(1) = bodyClass('../hydroData/hydroData.h5'); 
%body(1).geometryFile = ('../geometry/buoyExt.stl');      
body(1).mass = 1000;
body(1).momOfInertia = body(1).mass/12*[1 1 1];

%% PTO and Constraint Parameters
% % Translational PTO
pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
pto(1).k = 0;                           % PTO Stiffness [N/m]
pto(1).c = 0;                           % PTO Damping [N/(m/s)]
pto(1).loc = [0 0 0];                   % PTO Location [m]
