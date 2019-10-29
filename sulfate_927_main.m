clc
clear all
site_Number = 927;

[Leg1,Site1,Topcm1,Botcm,Depthmbsf1,CalciumCamM,ChlorinityClmM,MagnesiumMgmM,pHpHna,SodiumNamM,StrontiumSruM,SulfateSO4mM,SilicaH4SiO4uM,AlkalinityALKmM,SalinitySALna] = importfile_water('water.xlsx');
index3=(Site1==site_Number & SulfateSO4mM >0);
depth3=Depthmbsf1(index3);
sulfate_data=SulfateSO4mM(index3);

[depth3, a_order] = sort(depth3);
sulfate_data = sulfate_data(a_order,:);

G00 = 99;  %[mM/1 porewater]  by fitting
k_su0=2;
v0=0;
Ks0=10.0;
gra_su0=-0.1;

x0=[G00,k_su0,v0,Ks0,gra_su0];

lb=[0 ,0 ,0 ,0,-10];
ub=[1000000,1000,0,0.0001,10];

x = lsqcurvefit(@sulfate_927_function,x0,depth3,sulfate_data,lb,ub);


figure;
plot(sulfate_927_function(x,depth3),depth3,'linewidth',2)
hold on
scatter(sulfate_data,depth3,'ko')
hold on
set(gca,'Ydir','reverse')
title("Sulfate concentration in pore water (site:927)")
xlabel('Sulfate (mM) in pore water');
ylabel('Depth (m)')
set(gca,'FontSize',12)

newName = 'x927';
S.(newName) = [site_Number,x];
save('parameters_su_927.mat', '-struct', 'S'); 


newName = 'fit_sulfate_927';
S.(newName) = sulfate_927_function(x,depth3);
save('fit_sulfate_927.mat', '-struct', 'S'); 

% print -djpeg 927_Sulfate.jpg -r600