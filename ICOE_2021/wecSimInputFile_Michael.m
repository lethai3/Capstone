%% Simulation Data

%To start WEC-SIM just type "wecSim" into the command line
simu = simulationClass();
simu.simMechanicsFile = 'Heave_NREL_solve_4cyl.slx';          % Specify Simulink Model File
%simu.mode = 'rapid-accelerator';                       % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='off';                         % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                         % Simulation Start Time [s]
simu.endTime=200;
simu.solver = 'ode4';                         %simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
%simu.solver = 'ode14x'; 
%simu.dt = 0.01; 							      %Simulation time-step [s] for a convolution function in the radiation force calculation 
simu.dt = 0.01/(8*2); 
simu.rampTime = 50;
%simu.CITime = 100;
%simu.morisonElement = 1;
%simu.zeroCrossCont= 'EnableAll';                                 % Disable zero cross control 

%From SD Cal Desal old
%{
simu = simulationClass();               
%simu.simMechanicsFile = 'RM3_Hydraulic_PTO.slx';      %Location of Simulink Model File with PTO-SIm
simu.startTime = 0;                     
simu.rampTime = 10;                       
simu.endTime=250;
simu.explorer='on';
simu.solver ='ode14x';
simu.dt = 0.01;
simu.CITime =simu.dt;
%}

% From NREL file
%{
simu = simulationClass();
simu.simMechanicsFile = 'OSWEC_RO.slx';          % Specify Simulink Model File
%simu.mode = 'rapid-accelerator';                       % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='off';                         % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                         % Simulation Start Time [s]
simu.endTime=3000;
simu.solver = 'ode4';                         %simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01; 							      %Simulation time-step [s] for a convolution function in the radiation force calculation 
simu.rampTime = 50;
simu.CITime = 30;
simu.morisonElement = 1;
%simu.zeroCrossCont= 'EnableAll';                                 % Disable zero cross control 
%}

%% Wave Information
%% Regular Waves

waves = waveClass('regular');
%waves = waveClass('regularCIC'); %with CIC (convolution integral calculation)
waves.H = 2;
waves.T = 7;

%% Irregular Waves using BS Spectrum with Convolution Integral Calculation
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2;                          % Significant Wave Height [m]
% waves.T = 7;                            % Peak Period [s]
% waves.spectrumType = 'BS';              % Specify Wave Spectrum Type
% waves.freqDisc = 'EqualEnergy';
% waves.phaseSeed = 1;
% %waves.numFreq = 250;

%% Body Data
% Float
  
%---------------------------------
%For the cube absorber 1x1x1m^3
%---------------------------------    
% body(1) = bodyClass('./hydroData/buoy.h5');      
% body(1).mass = 500;
% body(1).momOfInertia = 2*500/12*[1 1 1];   

%---------------------------------
%For the extended cube absorber 1x2x1m^3
%---------------------------------
title_hydro=('C:/Users/ASUS/Documents/GitHub/Harvesting-Wave-Energy-Capstone-Project/Heave_April_NREL_edited/hydroData/buoyExt.h5');

body(1) = bodyClass(title_hydro);

%body(1) = bodyClass('../hydroData/buoyExt.h5');
body(1).mass = 1000;
body(1).momOfInertia = 2*1000/12*[1 1 1];

title_geo=('C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Heave_April_NREL_edited\geometry');
body(1).geometryFile = (title_geo); 
%body(1).geometryFile = ('../geometry/buoy.stl'); 


%% PTO and Constraint Parameters
% Translational Constraint
% constraint(1) = constraintClass('Constraint1'); 
% constraint(1).loc = [0 0 -5]; 
% constraint(1).orientation.z=[cos(pi/4),0,sin(pi/4)];
% constraint(1).orientation.x=[cos(pi/4),0,-sin(pi/4)];
% constraint(1).orientation.y=[0,1,0];
% % Translational PTO
pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
pto(1).k = 0;                           % PTO Stiffness [N/m]
pto(1).c = 0;                           % PTO Damping [N/(m/s)]
pto(1).loc = [0 0 0];                   % PTO Location [m]


