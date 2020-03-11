%% Simulation Data
simu = simulationClass();               
simu.simMechanicsFile = 'RM3_Hydraulic_PTO.slx';      %Location of Simulink Model File with PTO-SIm
simu.startTime = 0;                     
simu.rampTime = 50;                       
simu.endTime=200;

%simu.solver = 'ode4'; %default
%simu.solver = 'ode45'; %default
%simu.solver = 'ODE15s';
%simu.solver = 'ode23t';
simu.solver = 'ode14x';

%simu.dt = 0.01;  
%simu.dt = 0.001;  
simu.dt = 0.01/4; %worked with PTO-Sim - Crankshaft DA Cylinder Try 2 - WORKS!
%simu.dt = 0.01/8; 

%% Wave Information
% Irregular Waves using PM Spectrum
waves = waveClass('regular');
waves.H = 2.0;
%waves.T = 7;
waves.T = 6;

% waves.spectrumType = 'PM';
% waves.phaseSeed=1;

%% Body Data
% Float
body(1) = bodyClass('../hydroData/buoy.h5');             
body(1).geometryFile = '../geometry/buoy.stl';      
body(1).mass = 500;
body(1).momOfInertia = 2*500/12*[1 1 1];
%body(1).mass = 6.3;
%body(1).momOfInertia = 6.3/12*[1 1 1];
%body(1).momOfInertia = [20907301 21306090.66 37085481.11];     

% % Spar/Plate
% body(2) = bodyClass('../hydroData/rm3.h5');     
% body(2).geometryFile = '../geometry/plate.stl';  
% body(2).mass = 'equilibrium';                   
% body(2).momOfInertia = [94419614.57 94407091.24 28542224.82];

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
