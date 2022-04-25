clear,clc

f = 50
Omega = 2*pi*f*ones(5,1);
Omega = Omega'
X = 0.1;
H = 3;
D = 0.1;
%Initial values of generators

case5 = loadcase('case5');
result5 = runpf('case5');

Ybus = makeYbus(result5);
Ybus = full(Ybus);

Vm = result5.bus(:,8);
Va = result5.bus(:,9)*pi/180;

% voltagematrix = result5.bus;
% Voltage = voltagematrix(:,8);
% Voltage = Voltage';
% Va=voltagematrix(:,9)/180*pi;
% Va=Va';

Pg = result5.gen(:,2)/100;
Qg = result5.gen(:,3)/100;

Vcplx = Vm .* (exp(Va * sqrt(-1)));

Sg = (Pg+1i*Qg);
Sg = [Sg(1);0;Sg(2:4)];
% I = conj(Sg.*(1/Vcplx));
% %Voltage* e^i*Va

% Vcplx =zeros(1,5);
% for j=1:5
%     Vcplx(j) = Vm(j)*(exp(Va(j)*1i));
% end



% Sg = zeros(1,5);
% for j=1:5
%     Sg(j) = (Pg(j)+1i*Qg(j))/100;
% end
% 
gen_idx = [1,3,4,5];
I = (Pg - sqrt(-1)*Qg) ./ conj(Vcplx(gen_idx));
% % Ibus = Ybus.*Vcplx;

% I = zeros(1,5);
% 
% for i = 1:5
%     I(i) = conj(Sg(i)/Vcplx(i));
% end


%E = v+(1i*x*I)

Eprime = Vcplx(gen_idx) + 1i * X * I;
% Eprime=zeros (1,5);
% 
% for j = 1:5
%     Eprime(j) = Vcplx(j)+X*1i*I(j);
% end


%Give angle in [pi,-pi]
E_angle = angle(Eprime);

% E_angle = zeros(1,5);
% for i = 1:5
%     E_angle(i) = angle(E_phase(i));
% end

P_e = abs(Eprime).*Vm(gen_idx)/X.*sin(E_angle-Va(gen_idx));
% P_e = zeros(1,5);
% for j = 1:5
%     P_e(j) = abs(Eprime(j))*Vm(j)/X*sin(E_angle(j)-Va(j));
% end

P_m = P_e


% 
Pload = result5.bus(:,3)/100;
Pload=Pload';
Qload = result5.bus(:,4)/100;
Qload=Qload';


% P_in = result5.branch(:,14);
% Q_in = result5.branch(:,15);
% P_out= result5.branch(:,16);
% Q_out= result5.branch(:,17);
