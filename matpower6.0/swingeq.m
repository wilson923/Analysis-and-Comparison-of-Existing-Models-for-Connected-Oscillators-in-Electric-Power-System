function out = swingeq(t, y, yp)
    Ep = [1.017052534821209 + 0.268511632192802i;1.197389870423100 + 0.313214269749231i;1.184122930149753 + 0.005027180042545i;0.925862506266288 + 0.534276078469940i];
    Pm = [2.100000000000000;3.234900000000000;0.050271800425449;4.665100000000003];
%     E_angle = angle(Ep);
%     Omega = zeros(4,1);
%     Vm = [1.000000000000000,0.989261237118525,1.000000000000000,1,1.000000000000000]';
%     Va = [0.057130924508643,-0.013251748935062,-0.008591534692033,0,0.071768479905378]';
%     y0 = [E_angle; Omega; Vm; Va];
%     y=y0;
    H = 3;
    X = 0.1;
    D = 0.1;
    Ybus = makeYbus(loadcase('case5'));
    Pload = [0,300,300,400,0]'/100;
    Qload = [0,98.61,98.61,131.47,0]'/100;
    delta = y(1:4);
    Omega = y(5:8);
    Vm = y(9:13);
    Va = y(14:18);
    d_delta = yp(1:4);
    d_omega = yp(5:8);

    Vmgen = Vm([1,3,4,5]);
    Vagen = Va([1,3,4,5]);
    F_delta = d_delta - (Omega - 1);
    F_w = d_omega - 1/(2*H) * (Pm - abs(Ep).* Vmgen  /X .* sin(delta - Vagen) - D*(Omega-1));


    Pg = abs(Ep).*Vmgen/X.* sin(delta - Vagen);
    Qg = (Vmgen.* abs(Ep) .*cos(delta-Vagen) - Vmgen.^2)./X;

    V_cplx = Vm .* exp(1i *Va);

    Sbus = diag(V_cplx)*conj(Ybus*V_cplx);

    
    F = [Pg(1);0;Pg(2:4);Qg(1);0;Qg(2:4)] - [Pload;Qload] - [real(Sbus);imag(Sbus)];
    out = [F_delta; F_w; F];
end