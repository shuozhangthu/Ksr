function [fitresult, gof] = createFit_KsrT(T_all, K_all)
%CREATEFIT1(T_ALL,K_ALL)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : T_all
%      Y Output: K_all
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 11-Apr-2019 15:32:50


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( T_all, K_all );

% Set up fittype and options.
ft = fittype( 'exp(a+b/(x+273.15)+c/(x+273.15)^2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0461713906311539 0.0971317812358475 0.823457828327293];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'K_all vs. T_all', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel T_all
ylabel K_all
grid on


