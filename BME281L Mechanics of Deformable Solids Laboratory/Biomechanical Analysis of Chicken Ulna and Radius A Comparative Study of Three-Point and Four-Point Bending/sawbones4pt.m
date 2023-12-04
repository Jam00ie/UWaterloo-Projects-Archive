% PROPTERTIES -------------------------------------------------------------------------
filePath = 'sb_4ptData.xlsx';
name = "4pt Sawbones";
full_range = 'E2:F199';
linear_range = 2:87;
% LENGTHS -------------------------------------------------------------------------
L = (10^-3)*(64.22 - 4.76);
a = (10^-3)*(9.25);
b = (10^-3)*(12.49);
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
bb = (10^-3)*(22.44 - 3.18);
aa = (L - bb)./2;
x = aa;
d1 = (L - aa)./(6*L);
s1 = (L./(L - aa))*(x - aa)^3 - (x)^3 + (L^2 - (L - aa)^2)*x;
p1 = d1 * s1;
%disp(name + " d1 : " + d1);
%disp(name + " s1 : " + s1);
d2 = aa./(6*L);
s2 = (L./aa)*(x - (L - aa))^3 - (x)^3 + (L^2 - aa^2)*x;
p2 = d2 * s2;
%disp(name + " d2 : " + d2);
%disp(name + " s2 : " + s2);
factor = p1 + p2;
%disp(name + " Factor : " + factor);
E = (slope*factor)./(moi);
disp(name + " Young's Modulus : " + E + " Pa");
% ULT STRESS -------------------------------------------------------------------------
M = (max(force)*aa)./2;
c = a./2;
ultimate_stress = (M*c)./(moi);
%disp(name + " M: " + M + " N*m");
%disp(name + " c: " + c + " m");
disp(name + " Ultimate Stress : " + ultimate_stress + " Pa");
% SAVE -------------------------------------------------------------------------
save('fd_4pt.mat', 'name', 'displacement', 'force', 'l_displacement', 'l_force', 'moi', 'slope', 'intercept');