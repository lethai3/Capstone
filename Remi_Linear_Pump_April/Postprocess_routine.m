close all
clear all


%% LPWAcc
%myFolder1='C:\Users\remil\Desktop\WEC-Sim\MEng Report\SweetWaves\Post Processing MEng Report\LPWAcc';
myFolder1='C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\Linear pump B and T - With Accumulator';
config1=' Linear Pump with Acc';
FILTER1=0;
%% LPNAcc
%myFolder2='C:\Users\remil\Desktop\WEC-Sim\MEng Report\SweetWaves\Post Processing MEng Report\LPNAcc';
myFolder2='C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\Linear pump B and T - No Accumulator';
config2=' Linear Pump without Acc';
FILTER2=0;
%% CPNAcc
%myFolder3='C:\Users\remil\Desktop\WEC-Sim\MEng Report\SweetWaves\Post Processing MEng Report\CPNAcc';
myFolder3='C:\Users\ASUS\Documents\GitHub\Harvesting-Wave-Energy-Capstone-Project\Remi_Linear_Pump_April\Crankshaft Pump - No Accumulator';
config3=' Crankshaft Pump without Acc';
FILTER3=0;

%Postprocess_Folder(myFolder1,config1,FILTER1)
%Postprocess_Folder(myFolder2,config2,FILTER2)
%Postprocess_Folder(myFolder3,config3,FILTER3)

%Postprocess_Folder_Michael(myFolder1,config1,FILTER1,1);
%Postprocess_Folder_Michael(myFolder2,config2,FILTER2,2);
Postprocess_Folder_Michael(myFolder3,config3,FILTER3,3);
