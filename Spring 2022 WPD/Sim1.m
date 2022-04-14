


% tvals = [0,10,10,23,23,40,40,50];
% uvals = [0,0,4, 4,2,2,3,3];
% R = timeseries(uvals, tvals);
R=800;




sim('FluidSim');
plot(Pi);
hold on
plot(Po);
hold on
plot(R);
title('Pressure Control');
xlabel('Time (sec)');
ylabel('Pressure at Outlet of the Valve');
legend('Inlet Pressure','Outlet Pressure','Reference');


saveas(gcf,['Valve Simulation.pdf'])
