%Numerical Solution IVP by Modified Euler's Method
%input: @(x,y) 1+(y/x)+(y/x)^2
clc;
clear all;
close all;

f = input('Enter the function: '); % The DE of the form dy/dx = f(x,y)
x0 = input('Enter the initial value of the independent variable (x0): '); % y(1) = 0, so x0 = 1
y0 = input('Enter the initial value of the dependent variable (y0): '); % y(1) = 0, so y0 = 0
xn = input('Enter the end point of the solution interval at which you want to find the approximation (xn): ');
h = input('Enter the step size (h): ');
n = (xn - x0) / h;
x(1) = x0;
y(1) = y0;
fprintf('y(%0.2f) = %0.8f\n', x(1), y(1))

for i = 1:n
    y(i+1) = y(i) + h * f(x(i), y(i));
    x(i+1) = x0 + i * h;
    y(i+1) = y(i) + (1/2) * h * (f(x(i+1), y(i+1)) + f(x(i), y(i))); 
    fprintf('y(%0.2f) = %0.4f\n', x(i+1), y(i+1))
end

% Solve using ode45 solver to find the exact solution
[xex, yex] = ode45(f, [x0:h:xn], y0);

% Calculate error percentage
error = abs(yex - y');
error_percentage = abs((yex - y') ./ yex) .* 100;

% Combine the results into a matrix
output = [x', y', yex, error, error_percentage];

% Define the headings for the CSV file
headings = {'x', 'Modified Euler''s Method', 'Exact Solution', 'Error', 'Error (%)'};

% Write the matrix to a CSV file
outputFile = 'm_euler_2.csv';
writecell(headings, outputFile, 'Delimiter', ',');
dlmwrite(outputFile, output, 'Delimiter', ',', '-append');

% Plot the solution Euler's vs Exact
plot(x, y, 'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r', 'MarkerSize', 8);
hold on;
plot(xex, yex, 'bs--', 'LineWidth', 1.5, 'MarkerFaceColor', 'b', 'MarkerSize', 8);
hold off;
xlabel('x');
ylabel('y');
grid on;
title('Modified Euler''s Method vs Exact Solution of dy/dx=1+(y/x)+(y/x)^2');
legend("Modified Euler's Method", 'Exact Solution', 'Location', 'best');
set(gca, 'FontSize', 20)
