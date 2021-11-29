%Saving the summary stats from the regular wave modeling

wavesT=waves.T;
wavesH=waves.H;
wavesType=waves.type;
wavesDepth=waves.waterDepth;

simu_rampTime=simu.rampTime;
simu_solver=simu.solver;
simu_endTime=simu.endTime;
simu_CITime=simu.CITime;
Body_Mass=body(1).mass;


save(['2cyl_Bore_1.96in_T',num2str(waves.T),'s_H',num2str(waves.H),'m.mat'],'result','results_Pow_tab',...
    'results_Water_tab','Am','Aw','Bs','cyl_CompA_1','cyl_CompA_3','FR_coeff',...
   'wavesType','wavesH','wavesT','wavesDepth','sample_time',...
    'accumulator_volume', 'precharge_pressure','simu_rampTime','simu_solver',...
    'simu_endTime','simu_CITime','Body_Mass');



