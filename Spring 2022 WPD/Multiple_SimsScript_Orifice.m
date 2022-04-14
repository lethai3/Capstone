%Multiple_SimsScript
clear all
close all


tic

%rad_Crank_Vec=[0.02; 0.03; 0.04; 0.05; 0.06; 0.07; 0.08];
%rad_Crank_Vec=[0.02; 0.03];
rad_Crank_Vec=[0.02; 0.03; 0.04; 0.05; 0.06; 0.07; 0.08];

%FR_coeff_Vec=[0.01; 0.05; 0.1; 0.2; 0.3; 0.4; 0.5; 0.6; 0.7; 0.8; 0.9]; %V2
%FR_coeff_Vec=[0.0001; 0.00025; 0.0005; 0.001; 0.0025; 0.005; 0.01; 0.025; 0.05; 0.1; 0.3]; %V3

%Apollo Globe Valve at 10% open
%FR_coeff_Vec=[0.0137; 0.02; 0.0275; 0.035; 0.0412; 0.05; 0.0549; 0.06; 0.0686; 0.075; 0.0824 ]; 

%McMaster 1/4" pipe orifice diameters
Orifice_diam=[0.01; 0.016; 0.018; 0.02; 0.029; 0.032; 0.033; 0.04; 0.047; 0.063; 1/8 ]; 
FR_coeff_Vec=pi*(Orifice_diam./2).^2; %[in^2]

for jj=1:size(rad_Crank_Vec,1)
    jj
    for ii=1:size(FR_coeff_Vec,1)
        %Set the flow restrictor coefficient
        FR_coeff=FR_coeff_Vec(ii,1);

        %Set the crank radius
        rad_Crank=rad_Crank_Vec(jj,1);

        %run the two cylinder design param script to set up the initial parameters
        Two_cyl_design_Param_NO_FR_Coeff ;
        simOut= sim("RotaryPumpOnly_2cyl_FixedOrifice.slx");%,'SaveOutput','on','OutputSaveName','out.output_RO',...
        %'OutputSaveName','out.output_Pow','out.output_Crankshaft','SaveFormat', 'Dataset');

        out.output_RO=simOut.output_RO;
        out.output_Power=simOut.output_Power;
        out.output_Crankshaft=simOut.output_Crankshaft;
        [Store_ParamAndPerform(ii+size(FR_coeff_Vec,1)*(jj-1),:)]=userDefFunc_PumpOnlyFunc(out,FR_coeff,rad_Crank);
    end
end

toc

