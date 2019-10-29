%read data
[Leg1,Site1,Topcm1,Botcm,Depthmbsf1,CalciumCamM,ChlorinityClmM,MagnesiumMgmM,pHpHna,SodiumNamM,StrontiumSruM,SulfateSO4mM,SilicaH4SiO4uM,AlkalinityALKmM,SalinitySALna] = importfile_water('water.xlsx');
[site_sr,depth_sr,age_sr,SrCaRatio_Solid] = importfile_Solid_Sr('SrCaSolid.xlsx');

load parameters_sr_927_Ksr0;
load parameters_sr_927_Ksr1;
load parameters_sr_927_Ksr2;
load parameters_sr_927_Ksr3;

load parameters_sr_no_celestite_927_Ksr0;
load parameters_sr_no_celestite_927_Ksr1;
load parameters_sr_no_celestite_927_Ksr2;
load parameters_sr_no_celestite_927_Ksr3;

load workspace_927.mat

site_Number=927;


index=(Site1==site_Number);
depth=Depthmbsf1(index);
Sr=StrontiumSruM(index);
Ca=CalciumCamM(index);
sulfate=SulfateSO4mM(index);

index_solid=(site_sr==site_Number);
depth_solid=depth_sr(index_solid);
Sr_solid=SrCaRatio_Solid(index_solid);


figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,3,1);
title('(a)');

hold on
xlabel('[Sr]_f (\muM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on
plot(fitSr_Ksr0*1000,depth,'linewidth',2)
% plot(fitSr_Ksr1*1000,depth,'--','linewidth',2)
% plot(fitSr_Ksr2*1000,depth,':','linewidth',2)
plot(fitSr_Ksr3*1000,depth,'-.','linewidth',2)

plot(fitSr_no_celestite_Ksr0*1000,z,'linewidth',2)
% plot(fitSr_no_celestite_Ksr1*1000,z,'--','linewidth',2)
% plot(fitSr_no_celestite_Ksr2*1000,z,':','linewidth',2)
plot(fitSr_no_celestite_Ksr3*1000,z,'-.','linewidth',2)

scatter(Sr,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;
legend({'With celestite, K_{eq}=0','With celestite, K_{eq}=0.03','Without celestite, K_{eq}=0','Without celestite, K_{eq}=0.03','Sr data'},'FontSize',12);


load fit_ca_927.mat

subplot(2,3,2);
title('(b)');

hold on
xlabel('[Ca]_f (mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on
plot(fit_ca_927,depth,'linewidth',2)

scatter(Ca,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;
legend({'Model','Ca data'},'FontSize',12);


subplot(2,3,3);
title('(c)');

hold on
xlabel('[Sr/Ca]_s (\muM/mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(Sr_solid,depth_solid,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;


load fit_sulfate_927.mat

subplot(2,3,4);
title('(d)');

hold on
xlabel('[SO_4]_f (mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on
plot(fit_sulfate_927,depth,'linewidth',2)

scatter(sulfate,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;
legend({'Model','Sulfate data'},'FontSize',12,'Location','SouthEast');

subplot(2,3,5);
title('(e)');

hold on
xlabel('[Sr]_f[SO_4]_f (mM^2)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(Sr.*sulfate/1000,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;

subplot(2,3,6);
title('(f)');

hold on
xlabel('[Sr/Ca]_s/[Sr/Ca]_f');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

[C,ia,ib]=intersect(depth,depth_solid);

scatter(Sr_solid(ib).*Ca(ia)./Sr(ia),depth_solid(ib),'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;
load('data927.mat');
plot(Ksr927,z927,'--','LineWidth',2);
xlim([0.02,0.2]);
xticks([0.02,0.05,0.08,0.11,0.14,0.17,0.20]);
legend({'Measured [Sr]_f','Reconstructed [Sr]_f'},'FontSize',12,'Location','SouthEast');
print('data927.jpg','-djpeg','-r300');
% saveas(gcf,'data927.pdf')


min(Sr_solid(ib).*Ca(ia)./Sr(ia))
