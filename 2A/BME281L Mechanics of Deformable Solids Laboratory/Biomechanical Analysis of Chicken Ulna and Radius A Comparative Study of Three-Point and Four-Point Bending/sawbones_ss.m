run("sawbones3pt.m");
three = load("fd_3pt.mat");
% STRESS FORCE -------------------------------------------------------------------------
figure;
plot(three.force, three.stress, 'b', 'LineWidth', 1);
hold on;
xlim([0 13]);
ylim([0 140000]);
xlabel('Force (N)');
ylabel('Stress (Pa)');
grid on;
hold off;

exportgraphics(gca,'sawbones_sf.pdf','ContentType','vector');

% STRESS STRAIN -------------------------------------------------------------------------
figure;
plot(three.strain, three.stress, 'b', 'LineWidth', 1);
hold on;
fplot(@(x) ((three.ss_intercept) + (three.ss_slope)*(x - 0.002)), 'k--');
xlim([0 0.11]);
ylim([0 140000]);
xlabel('Strain');
ylabel('Stress (Pa)');
legend('Stress Strain Curve', '0.2% Offset Line', Location="northwest");
grid on;
hold off;

exportgraphics(gca,'sawbones_ss.pdf','ContentType','vector')

% R DISPLACEMENT -------------------------------------------------------------------------
figure;
plot(three.displacement, three.R, 'b', 'LineWidth', 1);
hold on;
xlim([0 0.0055]);
%ylim([0 140000]);
xlabel('Displacement (m)');
ylabel('Radius of Curvature (m)');
grid on;
hold off;

exportgraphics(gca,'sawbones_rd.pdf','ContentType','vector')