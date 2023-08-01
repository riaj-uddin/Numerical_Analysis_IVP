%Numerical Solution IVP by Euler's Method
%input: @(x,y) x+y
clc
clear all
close all
f = input('Enter the function: '); % The DE of the form dy/dx = f(x,y)
x0 = input('Enter the initial value of the independent variable (x0): '); % y(0) = 1, so x0 = 0
y0 = input('Enter the initial value of the dependent variable (y0): '); % y(0) = 1, so y0 = 1
xn = input('Enter the end point of the solution interval at which you want to find the approximation (xn): ');
h = input('Enter the step size (h): ');
n = (xn - x0) / h;
x(1) = x0;
y(1) = y0;
fprintf('y(%0.2f) = %0.8f\n', x(1), y(1))

for i = 1:n
    y(i+1) = y(i) + h * f(x(i), y(i));
    x(i+1) = x0 + i * h;
    fprintf('y(%0.2f) = %0.8f\n', x(i+1), y(i+1))
end

% Solve using ode45 solver to find the exact solution
[xex, yex] = ode45(f, [x0:h:xn], y0);

% Calculate error percentage
error = abs(yex - y');
error_parcentage = abs((yex - y') ./ yex) .* 100;

% Combine the results into a matrix
output = [x', y', yex, error, error_parcentage];

% Define the headings for the CSV file
headings = {'x', 'Euler''s Method', 'Exact Solution', 'Error', 'Error (%)'};

% Write the matrix to a CSV file
outputFile = 'euler_example_1.csv';
writecell(headings, outputFile, 'Delimiter', ',');
dlmwrite(outputFile, output, 'Delimiter', ',', '-append');

% Plot the solution Euler's vs Exact
plot(x, y, '*r--', xex, yex, 'sb-', 'LineWidth', 2.5);
xlabel('x');
ylabel('y');
grid on;
title('Euler''s Method vs Exact Solution of dy/dx=x+y');
legend("Euler's Method", 'Exact Solution', 'Location', 'best');
set(gca, 'FontSize', 20)