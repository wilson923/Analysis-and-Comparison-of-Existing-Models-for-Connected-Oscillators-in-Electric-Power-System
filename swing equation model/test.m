clear;clc;

Ep = [1.017052534821209 + 0.268511632192802i;1.197389870423100 + 0.313214269749231i;1.184122930149753 + 0.005027180042545i;0.925862506266288 + 0.534276078469940i];
Pm = [2.100000000000000;3.234900000000000;0.050271800425449;4.665100000000003];
E_angle = angle(Ep);
Omega = ones(4,1);
Vm = [1.000000000000000,0.989261237118525,1.000000000000000,1,1.000000000000000]';
Va = [0.057130924508643,-0.013251748935062,-0.008591534692033,0,0.071768479905378]';
y0 = [E_angle; Omega; Vm; Va];
yp0 = zeros(18,1);
tspan = (0:1/240:100);
y0(5) = 2.7;
swingeq(0, y0,yp0)
% y=y0;


M = diag([ones(8,1);zeros(10,1)]);

options = odeset('Mass',M,'RelTol',1e-1,'AbsTol',1e-4);
[t,y] = ode15i(@swingeq,tspan,y0, yp0, options);


plot(t,y(:,5),'b',t,y(:,6),'g',t,y(:,7),'r',t,y(:,8),'k')
legend('generator1','generator2','generator3','generator4')
ylabel('Angular speed (rad/s)')
xlabel('Time (s)')
axis([0 100 0 3])

