Yphase = zeros(N,301);
Yphaseangle= zeros(N,301);


% p = plot(G,'layout','force')
% 
% G = graph(Adj); %Draw Adj
% Weight=[1 2 3 4 5 6 7 9999];
% AAA = adjacency(G,Weight)


for NON = 1:N  %number of node
    for SOI =1:301   %steps of interation
        
        Yphase(NON,SOI) = thetaAndThetaDot(NON,SOI);
    end

end    

for SOI = 1:301
    Yphaseangle(SOI) = angle(Yphase(SOI));
end

plot(allt,Yphaseangle(3,:),'b',allt,Yphaseangle(4,:),'g')
ylabel('phase angle')


%     figure
%  
%Find phase difference

% phasedifference15 = zeros (1,3001);


% for i=1:3001
%     phasedifference15(1,i) = phasediff(3,i)-phasediff(4,i);
% 
% end
% 
% plot(allt,phasedifference15, 'b')
