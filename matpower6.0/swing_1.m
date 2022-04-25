


N=7;   %Number of generators for each system
pmax= 5;
pe = pmax;
M=1;      %Inertia
D=0.001;      %Damping ratio
steps = 0.01;  
Adj=[0,1,1,0,0,0,0;1,0,1,1,0,0,0;1,1,0,0,1,0,0;0,1,0,0,1,0,0;0,0,1,1,0,1,0;  ...
    0,0,0,0,1,0,1;0,0,0,0,0,1,0];

G = graph(Adj); %Draw Adj
Weight=[1 2 3 4 5 6 7 8];
AAA = adjacency(G,Weight);


tmin=0;
tmax=30;
allt = tmin:steps:tmax;

tspan = [tmin tmax];

theta0=2*pi*rand(N,1); %Random starting point for 2N+1 numbers of point

omegaTemp = 0.5*ones(N,1); 

Omega = [omegaTemp; -omegaTemp; 1]; %OmegaR


% Adj = zeros(2*N+1);
% for iAdj = 1:2*N+1 %Adjcency matrix for this system
%     for jAdj = 1:2*N+1
%         if iAdj <= N && jAdj <= N
%             Adj(iAdj,jAdj)= 1;
%         end
%         if iAdj > N && iAdj <= 2*N && jAdj > N && jAdj <= 2*N
%             Adj(iAdj,jAdj) = 1;
%         end
%         if iAdj == N && jAdj == 2*N+1
%             Adj(iAdj,jAdj) = 1;
%         end
%         if jAdj == N && iAdj == 2*N+1
%             Adj(iAdj,jAdj) = 1;
%         end
%         if iAdj == 2*N && jAdj == 2*N+1
%             Adj(iAdj,jAdj) = 1;
%         end
%         if jAdj == 2*N && iAdj == 2*N+1
%             Adj(iAdj,jAdj) = 1;
%         end
%         if iAdj == jAdj
%             Adj(iAdj,jAdj) = 0;
%         end
%     end



y0=[theta0; zeros(N,1)];
sol = ode45(@(t,y) swingequation(t,y,pmax,pe,M,N,D,Adj,AAA,Omega),tspan,y0);
thetaAndThetaDot = deval(sol,allt);

% dy/dt = f(y)
% 
% delta_dot = w
% w_dot = 1/(2*H)* (Pm - Pe - D*w)
% 
% y = [delta, w]';

% function dydt = swingequation(~,y,N)
%     delta = y(1:N);
%     w = y(N+1:2*N);
%     delta_dot = w;
%     w_dot = 1/(2*H) * (Pm - Pe - D*w);
%     
%     Pe = E*V/X*sin
%     dydt = [delta_dot, w_dot]';
% end
% 
% x_dot = f(x ,V)
% 0 = g(x, V)

function dydt = swingequation(~,y,pmax,pe,M,N,D,Adj,AAA,Omega)


     theta=y(1:N);
     thetadot = y(N+1:2*N);
     ydot = zeros(2*N,1);
     ydot(1:N)=thetadot;
     
     thetadoubledot = zeros(N,1);
     
     for j = 1:N
         
         thetadoubledot(j) = ((pmax-pe)/M)- (thetadot(j)*D/(Omega(j)*M));
         
         for innerj = 1:N
             thetadoubledot(j) = thetadoubledot(j) - ...
                 (Adj(j,innerj))*sin(theta(j)-theta(innerj));
         end
         
     end
     
     ydot(N+1:2*N) = thetadoubledot;
     
     dydt = ydot;



end    

