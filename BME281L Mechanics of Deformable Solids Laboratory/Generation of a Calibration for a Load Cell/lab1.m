m1 = [324.27 325.21 325.09 324.37 325.75];
m1z = [334.32 332.4 333.6 332.44 332.21];
mean1 = mean(m1);
std1 = std(m1);

m2 = [317.22 315.42 317.06 318.68 316.8];
m2z = [331.67 332.77 333.97 332.76 334.12];
mean2 = mean(m2);
std2 = std(m2);


m5 = [296.73 298.02 298.43 295.32 296.02];
m5z = [330.49 333.88 333.79 333.28 331.41];
mean5 = mean(m5);
std5 = std(m5);

m7 = [282.85 280.27 283.44 281.45 283.23];
m7z = [330.35 332.5 334.41 331.77 333.28];
mean7 = mean(m7);
std7 = std(m7);

m10 = [260.15 261.61 263.19 261.01 260.3];
m10z = [333.29 332.7 332.85 334.27 332.19];
mean10 = mean(m10);
std10 = std(m10);

m12 = [248.16 246.41 248.48 247.85 246.79];
m12z = [333.73 332.93 333.61 333.03 333.27];
mean12 = mean(m12);
std12 = std(m12);

m15 = [225.77 225.53 224 224.19 225.92];
m15z = [334.3 334.46 331.97 332.19 332.22];
mean15 = mean(m15);
std15 = std(m15);

weights0 = [0; 0; 0; 0; 0; 0; 0; 100; 200; 500; 700; 1000; 1200; 1500];
weights1 = weights0*9.81;
weights2 = repelem(weights1, 1, 5);
weights3 = reshape(weights2, [], 1);
strains = [m1z; m2z; m5z; m7z; m10z; m12z; m15z; m1; m2; m5; m7; m10; m12; m15];
strains2 = reshape(strains, [], 1);

format long
WW = [ones(length(weights3),1) weights3];
b = WW \ strains2;

regression = WW*b;
scatter(weights3, strains2)
hold on
plot(weights3, regression)
legend('Calibration Data', 'Regression Line');
xlabel('Weight on strain gauged test bar (N)')
ylabel('Strain gauge amplifier output (arbitrary unit)')
txt1 = {'\textbf{Regression:}','$$\hat{Y} = 332.6821 - 0.0073X$$'};
txt2 = {'\textbf{Coefficient of Determination:}','$$R^2 = 0.9990$$'};
text(1000,275,txt1,'Interpreter', 'latex', 'fontsize', 10);
text(1000,260,txt2,'Interpreter', 'latex', 'fontsize', 10);
grid on

Rsq = 1 - sum((strains2 - regression).^2)/sum((strains2 - mean(strains2)).^2);

print -deps lab1fig