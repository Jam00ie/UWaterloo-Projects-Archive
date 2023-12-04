run("sawbones3pt.m");
run("sawbones4pt.m");

three = load("fd_3pt.mat");
four = load("fd_4pt.mat");

% FORCE DISPLACEMENT -------------------------------------------------------------------------
figure;
plot(three.displacement, three.force, 'b', 'LineWidth', 1);
hold on;
plot(four.displacement, four.force, 'r', 'LineWidth', 1);
%fplot(@(x) ((three.intercept) + (three.slope)*(x - 0.002)), 'k--');
%fplot(@(x) ((four.intercept) + (four.slope)*(x - 0.002)), 'k--');
xlim([0 0.0055]);
ylim([0 37.5]);
xlabel('Displacement (m)');
ylabel('Force (N)');
grid on;
legend('3pt Bending Test', '4pt Bending Test', Location="northwest");
hold off;

exportgraphics(gca,'sawbones_fd.pdf','ContentType','vector')

% LINEAR FD -------------------------------------------------------------------------
figure;
plot(three.l_displacement, three.l_force, 'b', 'LineWidth', 1);
hold on;
plot(four.l_displacement, four.l_force, 'r', 'LineWidth', 1);
xlim([0 0.003]);
ylim([0 25]);
xlabel('Displacement (m)');
ylabel('Force (N)');
grid on;

fplot(@(x) ((three.intercept) + (three.slope)*(x)), 'k--');
fplot(@(x) ((four.intercept) + (four.slope)*(x)), 'k--');
legend('3pt Bending Test', '4pt Bending Test', 'Regression Lines', Location="northwest");
hold off;

exportgraphics(gca,'sawbones_linear.pdf','ContentType','vector');