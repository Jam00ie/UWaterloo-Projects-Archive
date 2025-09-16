% PROPTERTIES -------------------------------------------------------------------------
filePath = 'sb_3ptData.xlsx';
name = "3pt Sawbones";
full_range = 'E2:F217';
linear_range = 2:115;
% LENGTHS -------------------------------------------------------------------------
L = (10^-3)*(58.94 - 3.14);
a = (10^-3)*(12.43);
b = (10^-3)*(7.51);
%disp(name + " L: " + L + " m");
%disp(name + " a: " + a + " m");
%disp(name + " b: " + b + " m");
% FORCE DISPLACEMENT -------------------------------------------------------------------------
data = readmatrix(filePath, 'Range', full_range);
displacement = (10^-3)*data(:, 1);
force = data(:, 2);
% LINEAR FD -------------------------------------------------------------------------
l_displacement = displacement(linear_range);
l_force = force(linear_range);
% MOI -------------------------------------------------------------------------
moi = (1./2)*(b)*(a^3);
disp(name + " MOI (I_x): " + moi + " m^4");
% SLOPE INTERCEPT -------------------------------------------------------------------------
linear_fit = polyfit(displacement(linear_range), force(linear_range), 1);
slope = linear_fit(1);
intercept = linear_fit(2);
%disp(name + " FD Slope : " + slope + " N");
% YOUNGS MODULUS -------------------------------------------------------------------------
E = ((slope)*(L^3))./((48)*(moi));
disp(name + " Young's Modulus : " + E + " Pa");
% ULT STRESS -------------------------------------------------------------------------
M = (max(force)*L)./4;
c = a./2;
ultimate_stress = (M*c)./(moi);
%disp(name + " M: " + M + " N*m");
disp(name + " c: " + c + " m");
disp(name + " Ultimate Stress : " + ultimate_stress + " Pa");
% STRESS -------------------------------------------------------------------------
area = a*b;
stress = force./area;
% STRAIN -------------------------------------------------------------------------
size = (10^-3)*(51.523);
strain = displacement./size;

ss_linear_fit = polyfit(strain(linear_range), stress(linear_range), 1);
ss_slope = ss_linear_fit(1);
ss_intercept = ss_linear_fit(2);
% R -------------------------------------------------------------------------
R = (E*c)./stress;
% SAVE -------------------------------------------------------------------------
save('fd_3pt.mat', 'displacement', 'force', 'l_displacement', 'l_force', 'moi', 'slope', 'intercept', 'stress', 'strain', 'R', 'ss_slope', 'ss_intercept');