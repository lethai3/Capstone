%% Simulation Data
simu = simulationClass();               
%simu.simMechanicsFile = 'RM3_Hydraulic_PTO.slx';      %Location of Simulink Model File with PTO-SIm
simu.startTime = 0;                     
simu.rampTime = 10;                       
simu.endTime=250;
simu.explorer='on';
simu.solver ='ode14x';
simu.dt = 0.01;
simu.CITime =simu.dt;


%% Wave Information
% Irregular Waves using BS Spectrum
waves = waveClass('regular');
%waves.spectrumType = 'BS';
waves.H = 2;
waves.T = 6;

%% Body Data
% Float
body(1) = bodyClass('../hydroData/buoy.h5');             
body(1).geometryFile = '../geometry/buoy.stl';      
body(1).mass = 500;
body(1).momOfInertia = 2*500/12*[1 1 1];   

% %% PTO Heaving only
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_Heaving.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5]; 
% pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
% pto(1).k = 390;                           % PTO Stiffness [N/m]
% pto(1).c = 11000;  

% %% PTO Heaving only + Power
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingB.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5]; 
% pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
% pto(1).k = 390;                           % PTO Stiffness [N/m]
% pto(1).c = 11000;  


%% PTO Surging only
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_Heaving.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5];
% pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
% pto(1).k = 390;                           % PTO Stiffness [N/m]
% pto(1).c = 11000;  
% pto(1).orientation.z=[1 0 0];
% pto(1).orientation.x=[0 0 -1];

%% PTO Surging only + Power
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingC.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5];
% pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
% pto(1).k = 390;                           % PTO Stiffness [N/m]
% pto(1).c = 11000;  
% pto(1).orientation.z=[1 0 0];
% pto(1).orientation.x=[0 0 -1];

%% PTO Heaving and Surging 1 
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingSurging1.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5];
% constraint(2) = constraintClass('Constraint');
% constraint(2).loc= [0 0 -5];
% constraint(3) = constraintClass('Constraint');
% constraint(3).loc= [0 0 -5];
% constraint(3).orientation.z=[1 0 0];
% constraint(3).orientation.x=[0 0 -1];

%% PTO Heaving and Surging 2
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingSurging2.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5];
% constraint(2) = constraintClass('Constraint');
% constraint(2).loc= [0 0 -5];
% constraint(3) = constraintClass('Constraint');
% constraint(3).loc= [0 0 -5];
% constraint(3).orientation.z=[1 0 0];
% constraint(3).orientation.x=[0 0 -1];

%**********************************************************************
%**********************************************************************
%PTO Heaving and Surging 3
simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingSurging3.slx';
constraint(1) = constraintClass('Fixed'); 
constraint(1).loc = [-2.5 0 -5];
constraint(2) = constraintClass('Constraint');
constraint(2).loc= [-2.5 0 -5];
constraint(2).orientation.z=[1 0 0];
constraint(2).orientation.x=[0 0 -1];
constraint(3) = constraintClass('Constraint');
constraint(3).loc= [-2.5 0 -5];
%************************************************************
%************************************************************

%PTO Heaving and Surging 4 NOT WORKING
% simu.simMechanicsFile = 'RM3_Hydraulic_PTO_HeavingSurging4.slx';
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5];
% constraint(2) = constraintClass('Constraint');
% constraint(2).loc= [0 0 -5];
% constraint(2).orientation.z=[1 0 0];
% constraint(2).orientation.x=[0 0 -1];
% constraint(3) = constraintClass('Constraint');
% constraint(3).loc= [0 0 -5];
% constraint(4) = constraintClass('Constraint');
% constraint(4).loc= [2.5 0 -5];
% %% Mooring
% % Moordyn
% mooring(1) = mooringClass('mooring');       % Initialize mooringClass
% mooring(1).moorDynLines = 6;% Specify number of lines
% mooring(1).moorDynNodes(1:3) = 16;          % Specify number of nodes per line
% mooring(1).moorDynNodes(4:6) = 6;           % Specify number of nodes per line
% mooring(1).initDisp.initLinDisp = [0 0 -0.21];      % Initial Displacement

% % Spar/Plate
% body(2) = bodyClass('../hydroData/rm3.h5');     
% body(2).geometryFile = '../geometry/plate.stl';  
% body(2).mass = 'equilibrium';                   
% body(2).momOfInertia = [94419614.57 94407091.24 28542224.82];

%% PTO and Constraint Parameters
% Translational Constraint
% constraint(1) = constraintClass('Fixed'); 
% constraint(1).loc = [0 0 -5]; 

% constraint(2) = constraintClass('Fixed'); 
% constraint(2).loc = [0 0 -5]; 

% constraint(1) = constraintClass('Constraint'); 
% constraint(1).loc = [2.5 0 -5]; 
% angle=3.1415-62*3.1415/180;
% constraint(1).orientation.z=cos(angle)*[1 0 0]+sin(angle)*[0 0 1];
% constraint(1).orientation.x=cos(angle)*[1 0 0]-sin(angle)*[0 0 1];

% 
% angle=3.1415-62*3.1415/180;
% constraint(2).orientation.z=cos(angle)*[1 0 0]+sin(angle)*[0 0 1];
% constraint(2).orientation.x=cos(angle)*[1 0 0]-sin(angle)*[0 0 1];
% 
% % 
% constraint(2) = constraintClass('Constraint'); 
% constraint(2).loc = [10 0 -5];


% constraint(3) = constraintClass('Fixed'); 
% constraint(3).loc = [0 0 -5];

% constraint(4) =constraintClass('Constraint');
% constraint(4).loc=[10 0 -5];

% % Translational PTO
% pto(1) = ptoClass('PTO1');              % Create PTO Variable and Set PTO Name
% pto(1).k = 390;                           % PTO Stiffness [N/m]
% pto(1).c = 11000;                           % PTO Damping [N/(m/s)]
% pto(1).loc = [-2.5 0 -5]; 
% angle=62*3.1415/180;
% pto(1).orientation.z=cos(angle)*[1 0 0]+sin(angle)*[0 0 1];
% pto(1).orientation.x=cos(angle)*[1 0 0]-sin(angle)*[0 0 1];
% 

