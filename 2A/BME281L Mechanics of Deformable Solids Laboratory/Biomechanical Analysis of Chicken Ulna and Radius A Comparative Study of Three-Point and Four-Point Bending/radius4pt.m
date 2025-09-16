% PROPTERTIES -------------------------------------------------------------------------
filePath = 'radius_4pt.csv';
name = "4pt Radius";
full_range = 'E2:F65';
linear_range = 14:29;
% LENGTHS -------------------------------------------------------------------------
L = (10^-3)*(64.22 - 4.76);
t = (10^-3)*(0.90);
long_outer = (10^-3)*(4.00);
short_outer = (10^-3)*(3.56);
long_inner = long_outer - t;
short_inner = short_outer - t;
ao = short_outer./2;
bo = long_outer./2;
ai = short_inner./2;
bi = long_inner./2;
% FORCE DISPLACEMENT -------------------------------------------------------------------------
data = readmatrix(filePath, 'Range', full_range);
displacement = (10^-3)*data(:, 1);
force = data(:, 2);
% LINEAR FD -------------------------------------------------------------------------
l_displacement = displacement(linear_range);
l_force = force(linear_range);
% SLOPE INTERCEPT -------------------------------------------------------------------------
linear_fit = polyfit(displacement(linear_range), force(linear_range), 1);
slope = linear_fit(1);
intercept = linear_fit(2);
%disp(name + " FD Slope : " + slope + " N");
% MOI -------------------------------------------------------------------------
moi_image = (16.26)*(10^-12);
moi_outer = ((pi)*(ao)*(bo^3))./4;
moi_inner = ((pi)*(ai)*(bi^3))./4;
moi_ellipse = moi_outer - moi_inner;
%disp(name + " (I_x)outer: " + moi_outer + " m^4");
%disp(name + " (I_x)inner: " + moi_inner + " m^4");
disp(name + " MOI_image (I_x): " + moi_image*(10^12) + " mm^4");
disp(name + " MOI_ellipse (I_x): " + moi_ellipse*(10^12) + " mm^4");
moi_diff = ((abs(moi_image - moi_ellipse))./((moi_image + moi_ellipse)./2))*100;
disp(name + " % Difference MOI: " + moi_diff + " %");
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
E_image = (slope*factor)./(moi_image);
E_ellipse = (slope*factor)./(moi_ellipse);
disp(name + " Young's Modulus (Image): " + E_image + " Pa");
disp(name + " Young's Modulus (Ellipse): " + E_ellipse + " Pa");
E_diff = ((abs(E_image - E_ellipse))./((E_image + E_ellipse)./2))*100;
disp(name + " % Difference Young's Modulus: " + E_diff + " %");
% ULT STRESS -------------------------------------------------------------------------
M = (max(force)*aa)./2;
c = bo;
ultimate_stress_image = (M*c)./(moi_image);
ultimate_stress_ellipse = (M*c)./(moi_ellipse);
%disp(name + " M: " + M + " N*m");
%disp(name + " c: " + c + " m");
disp(name + " Ultimate Stress (Image): " + ultimate_stress_image + " Pa");
disp(name + " Ultimate Stress (Ellipse): " + ultimate_stress_ellipse + " Pa");
ultimate_stress_diff = ((abs(ultimate_stress_image - ultimate_stress_ellipse))./((ultimate_stress_image + ultimate_stress_ellipse)./2))*100;
disp(name + " % Difference Ultimate Stress: " + ultimate_stress_diff + " %");
% SAVE -------------------------------------------------------------------------
save('radius_4pt.mat', 'displacement','force', 'l_displacement', 'l_force', 'slope', 'intercept');