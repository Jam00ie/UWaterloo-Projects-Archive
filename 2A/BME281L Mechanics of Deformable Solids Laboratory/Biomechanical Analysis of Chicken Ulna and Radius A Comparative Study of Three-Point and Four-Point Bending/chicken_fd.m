run("ulna3pt.m");
run("radius4pt.m");

three = load("ulna_3pt.mat");
four = load("radius_4pt.mat");

% FORCE DISPLACEMENT -------------------------------------------------------------------------
figure;
plot(three.displacement, three.force, 'b', 'LineWidth', 1, 'DisplayName', 'Ulna');
hold on;
plot(four.displacement, four.force, 'r', 'LineWidth', 1, 'DisplayName', 'Radius');
xlim([0 0.0055]);
ylim([0 200]);
xlabel('Displacement (m)');
ylabel('Force (N)');
grid on;
legend(Location="northwest");
hold off;

exportgraphics(gca,'chicken_fd.pdf','ContentType','vector')

% LINEAR FD -------------------------------------------------------------------------
figure;
plot(three.l_displacement, three.l_force, 'b', 'LineWidth', 1);
hold on;
plot(four.l_displacement, four.l_force, 'r', 'LineWidth', 1);
xlim([0 0.0025]);
ylim([0 100]);
xlabel('Displacement (m)');
ylabel('Force (N)');
grid on;

fplot(@(x) ((three.intercept) + (three.slope)*(x)), 'k--');
fplot(@(x) ((four.intercept) + (four.slope)*(x)), 'k--');
legend('Ulna', 'Radius', 'Regression Lines', Location="northeast");
hold off;

exportgraphics(gca,'chicken_linear.pdf','ContentType','vector');