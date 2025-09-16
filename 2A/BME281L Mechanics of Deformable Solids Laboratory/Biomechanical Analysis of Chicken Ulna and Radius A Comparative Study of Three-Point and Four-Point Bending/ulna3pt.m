% PROPTERTIES -------------------------------------------------------------------------
filePath = 'ulna_3pt.csv';
name = "3pt Ulna";
full_range = 'E2:F56';
linear_range = 6:14;
% LENGTHS -------------------------------------------------------------------------
L = (10^-3)*(58.94 - 3.14);
t = (10^-3)*(0.66);
long_outer = (10^-3)*(5.72);
short_outer = (10^-3)*(7.20);
long_inner = long_outer - t;
short_inner = short_outer - t;
ao = short_outer./2;
bo = long_outer./2;
ai = short_inner./2;
bi = long_inner./2;
%disp(name + " L: " + L + " m");
%disp(name + " a_outer: " + ao + " m");
%disp(name + " b_outer: " + bo + " m");
%disp(name + " a_inner: " + ai + " m");
%disp(name + " b_inner: " + bi + " m");
%disp(name + " t: " + t + " m");
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
moi_image = (71.23)*(10^-12);
moi_outer = ((pi)*(ao)*(bo^3))./4;
moi_inner = ((pi)*(ai)*(bi^3))./4;
moi_ellipse = moi_outer - moi_inner;
%disp(name + " (I_x)outer: " + moi_outer + " m^4");
%disp(name + " (I_x)inner: " + moi_inner + " m^4");
moi_diff = ((abs(moi_image - moi_ellipse))./((moi_image + moi_ellipse)./2))*100;
disp(name + " MOI_ellipse (I_x): " + moi_ellipse*(10^12) + " mm^4");
disp(name + " MOI_image (I_x): " + moi_image*(10^12) + " mm^4");
disp(name + " % Difference MOI: " + moi_diff + " %");
% YOUNGS MODULUS -------------------------------------------------------------------------
E_image = ((slope)*(L^3))./((48)*(moi_image));
disp(name + " Young's Modulus (Image): " + E_image + " Pa");
E_ellipse = ((slope)*(L^3))./((48)*(moi_ellipse));
disp(name + " Young's Modulus (Ellipse): " + E_ellipse + " Pa");
E_diff = ((abs(E_image - E_ellipse))./((E_image + E_ellipse)./2))*100;
disp(name + " % Difference Young's Modulus: " + E_diff + " %");
% ULT STRESS -------------------------------------------------------------------------
M = (max(force)*L)./4;
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
save('ulna_3pt.mat', 'displacement','force', 'l_displacement', 'l_force', 'slope', 'intercept');