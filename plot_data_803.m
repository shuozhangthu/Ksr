%read data
[Leg1,Site1,Topcm1,Botcm,Depthmbsf1,CalciumCamM,ChlorinityClmM,MagnesiumMgmM,pHpHna,SodiumNamM,StrontiumSruM,SulfateSO4mM,SilicaH4SiO4uM,AlkalinityALKmM,SalinitySALna] = importfile_water('water.xlsx');
[site_sr,depth_sr,age_sr,SrCaRatio_Solid] = importfile_Solid_Sr('SrCaSolid.xlsx');

site_Number=803;


index=(Site1==site_Number);
depth=Depthmbsf1(index);
Sr=StrontiumSruM(index);
Ca=CalciumCamM(index);
sulfate=SulfateSO4mM(index);

index_solid=(site_sr==site_Number);
depth_solid=depth_sr(index_solid);
Sr_solid=SrCaRatio_Solid(index_solid);


figure('units','normalized','outerposition',[0 0 0.8 0.8])

subplot(2,3,1);
hold on
xlabel('[Sr]_f (\muM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(Sr,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;

subplot(2,3,2);
hold on
xlabel('[Ca]_f (mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(Ca,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;

subplot(2,3,3);
hold on
xlabel('[Sr/Ca]_s (\muM/mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(Sr_solid,depth_solid,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;

subplot(2,3,4);
hold on
xlabel('[SO_4]_f (mM)');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

scatter(sulfate,depth,'k','LineWidth',1.5);
ax = gca;
ax.LineWidth = 1.5;

subplot(2,3,5);
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
hold on
xlabel('[Sr/Ca]_s/[Sr/Ca]_f');
ylabel('Depth (m)')
set(gca,'Ydir','reverse')
set(gca,'FontSize',16,'FontWeight','bold')
box on

[C,ia,ib]=intersect(depth,depth_solid);

scatter(Sr_solid(ib).*Ca(ia)./Sr(ia),depth_solid(ib),'k','LineWidth',1.5);
xlim([0.02,0.16]);
xticks([0.02,0.06,0.10,0.14]);

ax = gca;
ax.LineWidth = 1.5;
print('data803.jpg','-djpeg','-r400');
% saveas(gcf,'data803.pdf')

min(Sr_solid(ib).*Ca(ia)./Sr(ia))
