%% Simulation Data
simu = simulationClass();
value_modif; % to load the parameters associated with MyDesignRO.slx
simu.simMechanicsFile = 'basis_modif.slx';      %Location of Simulink Model File with PTO-SIm
simu.startTime = 0;                     
simu.rampTime =10;                       
simu.endTime=500;
simu.solver = 'ode4';
simu.dt = sample_time;  
simu.CITime=sample_time; 

%% Wave Information
%waves = waveClass('irregular');
%waves.spectrumType='BS';
waves = waveClass('regular');
waves.H = 2;
waves.T = 7;

%% Body Data
body(1) = bodyClass('C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\hydroData\buoyExt.h5');
body(1).geometryFile = ('C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\geometry\buoy.stl');
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
