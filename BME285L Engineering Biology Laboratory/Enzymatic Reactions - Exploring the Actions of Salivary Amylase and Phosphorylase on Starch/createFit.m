function [fitresult, gof] = createFit(concentrations, time)
%CREATEFIT(CONCENTRATIONS,TIME)
%  Create a fit.
%
%  Data for 'Exponential Fit of Salivary Amylase Concentration vs. Time' fit:
%      X Input: concentrations
%      Y Output: time
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Nov-2023 21:54:28


%% Fit: 'Exponential Fit of Salivary Amylase Concentration vs. Time'.
% Salivary amylase concentrations
concentrations = [2, 5, 10]; % in percent

% Time required to reach the end-point
time = [1140, 105, 30]; % in seconds

[xData, yData] = prepareCurveData( concentrations, time );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [4341.37201331313 -0.658843946232523];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'Exponential Fit of Salivary Amylase Concentration vs. Time' );
plot( fitresult, xData, yData );
% Label axes
xlabel( 'concentrations', 'Interpreter', 'none' );
ylabel( 'time', 'Interpreter', 'none' );
grid on

