s1_file = 'sample1_data.csv';
s1_data = readtable(s1_file, 'ReadVariableNames', true);
s1_force = (s1_data.Force_N_Run_2(1:end)) + 149;
s1_displacement = (s1_data.Position_m_Run_2(1:end)) + 0.0000152;
s1_G = 0.02;
s1_deltaG = 0.00012954;
s1_diameter = 0.00336;
s1_diameterp = 0.00334;
s1_area = (pi/4)*(s1_diameter)^2;
s1_stress = (s1_force)./(s1_area);
s1_strain = (s1_displacement)./(s1_G);
s1_elat = (s1_diameter - s1_diameterp) ./ s1_diameter;
s1_elong = s1_deltaG ./ s1_G;
s1_poisson = (-1)*((s1_elat)./(s1_elong));

s2_file = 'sample2_data.csv';
s2_data = readtable(s2_file, 'ReadVariableNames', true);
s2_forceP1 = (-1)*(s2_data.Force_N_Run_2(1:559)) + 158;
s2_forceP2 = (-1)*(s2_data.Force_N_Run_3(1:92)) + 1159;
s2_force = vertcat(s2_forceP1, s2_forceP2);
s2_displacementP1 = (-1)*(s2_data.Position_m_Run_2(1:559)) + 0.00147;
s2_displacementP2 = (-1)*(s2_data.Position_m_Run_3(1:92)) + 0.0016;
s2_displacement = vertcat(s2_displacementP1, s2_displacementP2);
s2_G = 0.02;
s2_deltaG = 0.000128905;
s2_diameter = 0.0033;
s2_diameterp = 0.0033;
s2_area = (pi/4)*(s2_diameter)^2;
s2_stress = (s2_force)./(s2_area);
s2_strain = ((s2_displacement)./(s2_G)) - 0.0725;
s2_elat = (s2_diameter - s2_diameterp) ./ s2_diameter;
s2_elong = s2_deltaG ./ s2_G;
s2_poisson = (-1)*((s2_elat)./(s2_elong));

[s1_max,s1_maxi] = max(s1_stress);
[s2_max,s2_maxi] = max(s2_stress);

format long
s1_linear_stress = s1_stress(1:2012);
s1_linear_strain = s1_strain(1:2012);
X1 = [ones(length(s1_linear_strain), 1) s1_linear_strain];
b1 = X1\s1_linear_stress;
s2_linear_stress = s2_stress(1:566);
s2_linear_strain = s2_strain(1:566);
X2 = [ones(length(s2_linear_strain), 1) s2_linear_strain];
b2 = X2\s2_linear_stress;


plot(s1_strain(1:2448), s1_stress(1:2448), 'b-', 'LineWidth', 1, 'DisplayName','Sample 1');
hold on;
plot(s2_strain(1:s2_maxi), s2_stress(1:s2_maxi), 'r-', 'LineWidth', 1, 'DisplayName','Sample 2');
ylim([0 800000000])

yieldx = [0.0299812 0.0212478];
yieldy = [710073000 357379000];
plot(yieldx,yieldy,'kpentagram','MarkerSize', 10, 'LineWidth', 1);

maximumx = [s1_strain(s1_maxi) s2_strain(s2_maxi)];
maximumy = [s1_stress(s1_maxi) s2_stress(s2_maxi)];
plot(maximumx,maximumy,'ko','MarkerSize', 10, 'LineWidth', 1);

failurex = [s1_strain(2448) s2_strain(s2_maxi)];
failurey = [s1_stress(2448) s2_stress(s2_maxi)];
plot(failurex,failurey,'kx','MarkerSize', 15, 'LineWidth', 1);

fplot(@(x) ((b1(1)) + (b1(2))*(x - 0.002)), [0 0.0325], 'k--', 'LineWidth', 1);
fplot(@(x) ((b2(1)) + (b2(2))*(x - 0.002)), [0 0.025], 'k--', 'LineWidth', 1);

grid on;
legend('Sample 1', 'Sample 2', 'Yield stress', 'Ultimate tensile stress', 'Fracture stress', '0.02 offset')
xlabel('Strain')
ylabel('Stress (Pa)')

exportgraphics(gca,'lab2curve.pdf','ContentType','vector')