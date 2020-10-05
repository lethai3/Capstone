clc; clear all; close all;
hydro = struct();

hydro = Read_NEMOH(hydro,'C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Heave_April_NREL_edited\hydroData\');
% hydro = Read_WAMIT(hydro,'..\..\WAMIT\Cubes\cubes.out',[]);
% hydro = Combine_BEM(hydro); % Compare WAMIT
hydro = Radiation_IRF(hydro,100,[],[],[],[]);
hydro = Radiation_IRF_SS(hydro,[],[]);
hydro = Excitation_IRF(hydro,100,[],[],[],[]);
Write_H5(hydro)
Plot_BEMIO(hydro)


