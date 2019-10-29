load KsrT.mat;
load('data925.mat');
load('data926.mat');
load('data927.mat');
load('data928.mat');

Ksr(1)=min(Ksr925);
Ksr(2)=min(Ksr926);
Ksr(3)=min(Ksr927);
Ksr(4)=min(Ksr928);

T_all=[5.4;T10;T16];
K_all=[0.0211;Ksr;Humphrey1];
[fitresult, gof] = createFit_KsrT(T_all, K_all);

T=[0:1:200];

figure;
hold on

scatter(5.4, 0.0211,'d');
scatter(T10,Ksr,'d');
scatter(T13,Baker1,'s');
scatter(T14,Katz1,'x');
scatter(T15,Malone1,'*');
scatter(T16,Humphrey1);
scatter(T18,Directprecipitation1,'+');
plot(T12,KsrA1,'-','LineWidth',2);

y=exp(fitresult.a+fitresult.b./(T+273.15)+fitresult.c./(T+273.15).^2);

plot(T,y,'--','LineWidth',2);
% plot(T12,KsrA2,'--','LineWidth',2);
% plot(T,fitresult(T),'-','LineWidth',2);
ylim([0.01,0.1]);
box on
ax = gca;
% ax.LineWidth = 1;
set(gca,'FontSize',12)

set(gca,'Yscale','log');  %reverse depth axis
xlabel('Temperature (^oC)');
ylabel('K_{Sr}^{eq}')
set(gca,'FontSize',12)
legend('Site 807, this study','Sites 925-928, this study','Baker et al., 1991','Katz et al., 1972','Malone et al., 1999,','Humphrey et al., 1999','DePaolo, 2011','Thermodynamic model','Empirical model','location','SouthEast')
print('KsrT.jpg','-djpeg','-r600');

