


L=linspace(0.25,8,10);
g=9.81;
Nat_Per=2*pi*sqrt(L/g);
figure
plot(L,Nat_Per)
xlabel('Pendulum Length [m]');
xlabel('Natural Frequency [s]');
