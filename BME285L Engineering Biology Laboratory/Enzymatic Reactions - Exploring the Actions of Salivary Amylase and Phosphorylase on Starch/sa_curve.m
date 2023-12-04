% Salivary amylase concentrations
concentrations = [2, 5, 10]; % in percent

% Time required to reach the end-point
time = [1140, 105, 30]; % in seconds

% Extend the range of x-axis values
extendedConcentrations = linspace(0, 15, 100); % Adjust the range and number of points as needed

% Fit: 'Exponential Fit of Salivary Amylase Concentration vs. Time'.
[xData, yData] = prepareCurveData(concentrations, time);

% Set up fittype and options.
ft = fittype('exp1');
opts = fitoptions('Method', 'NonlinearLeastSquares');
opts.Display = 'Off';
opts.StartPoint = [4341.37201331313 -0.658843946232523];

% Fit model to data.
[fitresult, gof] = fit(xData, yData, ft, opts);

% Plot fit with data.
figure('Name', 'Exponential Fit of Salivary Amylase Concentration vs. Time');
% Plot the extended range with the fitted curve
extendedFit = feval(fitresult, extendedConcentrations);
plot(extendedConcentrations, extendedFit, 'r--');
hold on;

% Plot the data points
scatter(concentrations, time, 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');

% Add labels and title
xlabel('Salivary Amylase Concentration (%)');
ylabel('Time to Reach End-Point (s)');
title('Reaction Rate of Salivary Amylase Concentrations');

% Set axis limits
xlim([0 15]);
ylim([0 1200]);

% Add legend
legend('Exponential Fit', 'Data Points', 'Location', 'NorthEast');

% Show the grid
grid on;

% Hold off to stop overlaying on the same plot
hold off;

exportgraphics(gcf,'sa_curve.pdf','ContentType','vector');