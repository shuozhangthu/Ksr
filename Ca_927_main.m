site_Number = 927;

%-------input data----------
[Leg1,Site1,Topcm1,Botcm,Depthmbsf1,CalciumCamM,ChlorinityClmM,MagnesiumMgmM,pHpHna,SodiumNamM,StrontiumSruM,SulfateSO4mM,SilicaH4SiO4uM,AlkalinityALKmM,SalinitySALna] = importfile_water('water.xlsx');

index=(Site1==site_Number & CalciumCamM>0);
depth2=Depthmbsf1(index);
Ca2_data=CalciumCamM(index);

[depth2, a_order] = sort(depth2);
Ca2_data = Ca2_data(a_order,:);

alpha0=0.00015;
beta0=600;
gamma0=600;
v0=0;
grc_ca0=0;

y0=[alpha0,beta0,gamma0,v0,grc_ca0];
lb=[-100,-100,-100000,0,-100];
ub=[100,100,100000,0,100];

y = lsqcurvefit(@Ca_927_function,y0,depth2,Ca2_data,lb,ub);



figure
plot(Ca_927_function(y,depth2),depth2,'linewidth',2)
set(gca,'Ydir','reverse')
title('Calcium (mM) in pore water (site:927)')
xlabel('Calcium (mM) in pore water');
ylabel('Depth (m)')
set(gca,'FontSize',12)

hold on;

scatter (Ca2_data,depth2);

newName = 'y927';
S.(newName) = [site_Number,y];
save('parameters_Ca_927.mat', '-struct', 'S'); 


newName = 'fit_ca_927';
S.(newName) = Ca_927_function(y,depth3);
save('fit_ca_927.mat', '-struct', 'S'); 

% print -djpeg 927_Ca.jpg -r600