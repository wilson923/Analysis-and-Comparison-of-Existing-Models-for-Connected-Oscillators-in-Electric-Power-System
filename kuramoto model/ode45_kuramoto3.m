clc, clf, clear, close all


 
N=5;   %Number of points

K=10;    %Coupling constant

steps = 0.01; %Step of interation

tmin=0;
tmax=50;
allt = tmin:steps:tmax;

 
theta0=2*pi*rand(2*N+1,1);
 %Random starting point for N numbers of point
 
omegaTemp = 1*ones(N,1);

Omega = [omegaTemp; 2*omegaTemp; 0];
 %Random starting omega for N numbers of point

% Adj = [0,1,1,1,1;1,0,1,1,1;1,1,0,1,1;1,1,1,0,1;1,1,1,1,0]
 
Adj = zeros(2*N+1);
for iAdj = 1:2*N+1 %Adjcency matrix for this system
    for jAdj = 1:2*N+1
        if iAdj <= N && jAdj <= N
            Adj(iAdj,jAdj)= 1;
        end
        if iAdj > N && iAdj <= 2*N && jAdj > N && jAdj <= 2*N
            Adj(iAdj,jAdj) = 1;
        end
        if iAdj == N && jAdj == 2*N+1
            Adj(iAdj,jAdj) = 1;
        end
        if jAdj == N && iAdj == 2*N+1
            Adj(iAdj,jAdj) = 1;
        end
        if iAdj == 2*N && jAdj == 2*N+1
            Adj(iAdj,jAdj) = 1;
        end
        if jAdj == 2*N && iAdj == 2*N+1
            Adj(iAdj,jAdj) = 1;
        end
        if iAdj == jAdj
            Adj(iAdj,jAdj) = 0;
        end
    end
end

% Adj=[0,1,1,0,0,0,0;1,0,1,1,0,0,0;1,1,0,0,1,0,0;0,1,0,0,1,0,0;0,0,1,1,0,1,0; - ...
%     0,0,0,0,1,0,1;0,0,0,0,0,1,0];

% Adj = [0,1,1,1,10,0,0,0,0,0,0;1,0,1,1,10,0,0,0,0,0,0;1,1,0,1,10,0,0,0,0,0,0;1,1,1,0,10,0,0,0,0,0,0;10,10,10,10,0,0,0,0,0,0,20;0,0,0,0,0,0,1,1,1,10,0;0,0,0,0,0,1,0,1,1,10,0;0,0,0,0,0,1,1,0,1,10,0;0,0,0,0,0,1,1,1,0,10,0;0,0,0,0,0,10,10,10,10,0,20;0,0,0,0,20,0,0,0,0,20,0]

% Adj = [0,5,5,5,10,0,0,0,0,0,0;5,0,5,5,10,0,0,0,0,0,0;5,5,0,5,10,0,0,0,0,0,0;5,5,5,0,10,0,0,0,0,0,0;10,10,10,10,0,0,0,0,0,0,20;0,0,0,0,0,0,5,5,5,10,0;0,0,0,0,0,5,0,5,5,10,0;0,0,0,0,0,5,5,0,5,10,0;0,0,0,0,0,5,5,5,0,10,0;0,0,0,0,0,10,10,10,10,0,20;0,0,0,0,20,0,0,0,0,20,0]

tspan = [tmin tmax];

% MATLAB can create a new function funname by going
%funname = @(x1,x2,x3) x1 + x2*x3;

ode_kuramoto_for_solver= @(t,theta) ode_kuramoto(t,theta,K,N,Omega,Adj);
sol = ode45(ode_kuramoto_for_solver,tspan,theta0); %ode45 function
alltheta = deval(sol,allt);


alltheta = wrapToPi(alltheta);

% alltheta_d = acos(cos(alltheta));
% phasedifference115 = alltheta_d(11,:)-alltheta_d(5,:);
% phasedifference1110 = alltheta_d(11,:)-alltheta_d(10,:);
% phasedifference111 = alltheta_d(11,:)-alltheta_d(1,:);
% phasedifference116 = alltheta_d(11,:)-alltheta_d(6,:);
% 
% plot(allt,phasedifference111,'b',allt,phasedifference115,'g',allt,phasedifference116,'r',allt,phasedifference1110,'m')
% legend('\theta_{11}-\theta_{1}','\theta_{11}-\theta_{5}','\theta_{11}-\theta_{6}','\theta_{11}-\theta_{10}')

plot(allt,alltheta(1,:),'b',allt,alltheta(5,:),'g',allt,alltheta(6,:),'r',allt,alltheta(10,:),'m',allt,alltheta(11,:),'k')
legend('oscillator 1','oscillator 5','oscillator 6','oscillator 10','oscillator11')


% plot(allt,alltheta(1,:),'b',allt,alltheta(2,:),'g',allt,alltheta(3,:),'r',allt,alltheta(4,:),'m',allt,alltheta(5,:),'y')
% legend('oscillator 1','oscillator 2','oscillator 3','oscillator 4','oscillator 5')

ylabel('Phase angle (rad)')
xlabel('Time (s)')
axis([0 50 -5 5])


% %  plotgraph function
% 
%         for i=1:numel(allt)
%          s=linspace(0,2*pi,100);%Plot original circles
%          originalx=cos(s);
%          originaly=sin(s);
%  
%          xaxis=cos(alltheta(1:N-1,i));%Plot the moving points 
%          yaxis=sin(alltheta(1:N-1,i));%in axis, from 1 to N
%          
%          xaxis2=cos(alltheta(N,i));%Plot the moving points 
%          yaxis2=sin(alltheta(N,i));%in axis, node N
%          
%          xaxis3=cos(alltheta(N+1:2*N-1,i));%Plot the moving points 
%          yaxis3=sin(alltheta(N+1:2*N-1,i));%in axis, from N+1 to 2N
%                   
%          xaxis4=cos(alltheta(2*N,i));%Plot the moving points 
%          yaxis4=sin(alltheta(2*N,i));%in axis, node 2N
%          
%          xaxis5=cos(alltheta(2*N+1,i));%Plot the moving points 
%          yaxis5=sin(alltheta(2*N+1,i));%in axis, from 1 to 2N+1
%          
%          clf
%          hold on
%          plot(originalx,originaly,'k');
%          plot(xaxis,yaxis,'p','color','r'); 
%          
%          plot(xaxis2,yaxis2,'+','color','#D95319'); 
% 
%          plot(xaxis3,yaxis3,'o','color','b'); 
% 
%          plot(xaxis4,yaxis4,'x','color','#0072BD'); 
% 
%          plot(xaxis5,yaxis5,'d','color','k'); 
%          
%          axis([-3 3 -3 3]);
%          drawnow limitrate
% 
%         end
% 

%how far apart between two oscillators. the angle between two oscillators.
%take cos (difference). if cos (difference) > 1? does it stay
%synchronization.
%diameter network
%

function dthetadt = ode_kuramoto(~,theta,K,N,omega,Adj)  %Original kuramoto function (RHS function)
                       

             
     dthetadt = zeros(size(theta));
     %    dthetadt = ode(t,theta);
 
     for j=1:2*N+1  %For node 1 to (2N+1) using adjcency matrix
         dthetadt(j) = omega(j);
         for innerj = 1:2*N+1
            dthetadt(j) = dthetadt(j) +  K/N*Adj(j,innerj)*sin(theta(innerj)-theta(j));
         end
     end

end



