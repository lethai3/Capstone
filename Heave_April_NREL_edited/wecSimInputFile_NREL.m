<<<<<<< HEAD
%% Simulation Data
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

%% Wave Information
%% noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       %Create the Wave Variable and Specify Type  

%% Regular Waves 
% waves = waveClass('regularCIC');
% waves.H = 2;
% waves.T = 8;

%% Irregular Waves using PM Spectrum with Convolution Integral Calculation
waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
waves.H = 2.64;                          % Significant Wave Height [m]
waves.T = 9.86;                            % Peak Period [s]
waves.spectrumType = 'BS';              % Specify Wave Spectrum Type
waves.freqDisc = 'EqualEnergy';
waves.phaseSeed = 1;
waves.numFreq = 250;

%% Irregular Waves using User-Defined Spectrum
% waves = waveClass('irregularImport');
% waves.spectrumDataFile = 'ndbcBuoyData.txt';

%% Body Data
%% Flap
body(1) = bodyClass('./hydroData/oswec.h5');   % Initialize bodyClass for Flap
body(1).mass = 127000;                         % User-Defined mass [kg]
body(1).momOfInertia = [1.85e6 1.85e6 1.85e6]; % Moment of Inertia [kg-m^2]
body(1).geometryFile = './geometry/flap.stl';    % Geometry File
body(1).morisonElement.cd = ones (5,3);
body(1).morisonElement.ca = zeros(5,3);
body(1).morisonElement.characteristicArea = zeros(5,3);
body(1).morisonElement.characteristicArea(:,1) = 18*1.8;
body(1).morisonElement.characteristicArea(:,3) = 18*1.8;
body(1).morisonElement.VME  = zeros(5,1);
body(1).morisonElement.rgME = [0 0 -3; 0 0 -1.2; 0 0 0.6; 0 0 2.4; 0 0 4.2];

%% Base
body(2) = bodyClass('./hydroData/oswec.h5');   % Initialize bodyClass for Base
body(2).geometryFile = './geometry/base.stl';    % Geometry File
body(2).mass = 'fixed';                        % Creates Fixed Body

%% PTO and Constraint Parameters
constraint(1)= constraintClass('Constraint1'); % Initialize ConstraintClass for Constraint1
constraint(1).loc = [0 0 -10];

constraint(2)= constraintClass('Constraint2'); % Initialize ConstraintClass for Constraint1
constraint(2).loc = [0 0 -8.9];

constraint(3)= constraintClass('Constraint3'); % Initialize ConstraintClass for Constraint1
constraint(3).loc = [4.7021271782+0.9 0 -8.7];

constraint(4)= constraintClass('Constraint4'); % Initialize ConstraintClass for Constraint1
constraint(4).loc = [0+0.9 0 -7];

pto(1) = ptoClass('PTO1');                     % Initialize ptoClass for PTO1
pto(1).k = 0;                                  % PTO Stiffness Coeff [Nm/rad]
pto(1).c = 0;                                  % PTO Damping Coeff [Nsm/rad]
pto(1).loc = [2.35106397378+0.9 0 -7.849998936];                       % PTO Global Location [m]
=======
%% Simulation Data
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

%% Wave Information
%% noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       %Create the Wave Variable and Specify Type  

%% Regular Waves 
% waves = waveClass('regularCIC');
% waves.H = 2;
% waves.T = 8;

%% Irregular Waves using PM Spectrum with Convolution Integral Calculation
waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
waves.H = 2.64;                          % Significant Wave Height [m]
waves.T = 9.86;                            % Peak Period [s]
waves.spectrumType = 'BS';              % Specify Wave Spectrum Type
waves.freqDisc = 'EqualEnergy';
waves.phaseSeed = 1;
waves.numFreq = 250;

%% Irregular Waves using User-Defined Spectrum
% waves = waveClass('irregularImport');
% waves.spectrumDataFile = 'ndbcBuoyData.txt';

%% Body Data
%% Flap
body(1) = bodyClass('./hydroData/oswec.h5');   % Initialize bodyClass for Flap
body(1).mass = 127000;                         % User-Defined mass [kg]
body(1).momOfInertia = [1.85e6 1.85e6 1.85e6]; % Moment of Inertia [kg-m^2]
body(1).geometryFile = './geometry/flap.stl';    % Geometry File
body(1).morisonElement.cd = ones (5,3);
body(1).morisonElement.ca = zeros(5,3);
body(1).morisonElement.characteristicArea = zeros(5,3);
body(1).morisonElement.characteristicArea(:,1) = 18*1.8;
body(1).morisonElement.characteristicArea(:,3) = 18*1.8;
body(1).morisonElement.VME  = zeros(5,1);
body(1).morisonElement.rgME = [0 0 -3; 0 0 -1.2; 0 0 0.6; 0 0 2.4; 0 0 4.2];

%% Base
body(2) = bodyClass('./hydroData/oswec.h5');   % Initialize bodyClass for Base
body(2).geometryFile = './geometry/base.stl';    % Geometry File
body(2).mass = 'fixed';                        % Creates Fixed Body

%% PTO and Constraint Parameters
constraint(1)= constraintClass('Constraint1'); % Initialize ConstraintClass for Constraint1
constraint(1).loc = [0 0 -10];

constraint(2)= constraintClass('Constraint2'); % Initialize ConstraintClass for Constraint1
constraint(2).loc = [0 0 -8.9];

constraint(3)= constraintClass('Constraint3'); % Initialize ConstraintClass for Constraint1
constraint(3).loc = [4.7021271782+0.9 0 -8.7];

constraint(4)= constraintClass('Constraint4'); % Initialize ConstraintClass for Constraint1
constraint(4).loc = [0+0.9 0 -7];

pto(1) = ptoClass('PTO1');                     % Initialize ptoClass for PTO1
pto(1).k = 0;                                  % PTO Stiffness Coeff [Nm/rad]
pto(1).c = 0;                                  % PTO Damping Coeff [Nsm/rad]
pto(1).loc = [2.35106397378+0.9 0 -7.849998936];                       % PTO Global Location [m]
>>>>>>> f355352950ef964d7ebe4f5c5f729e388ef0882b
pto(1).orientation.z = [-4.7021271782/5 0 1.7/5];  % PTO orientation