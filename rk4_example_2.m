%Numerical Solution IVP by RK-2 Method
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

for i=1:n
    x(i+1)=x0+i*h; k1=h*f(x(i),y(i)); 
    k2=h*f(x(i)+(h/2),y(i)+(k1/2));
    k3=h*f(x(i)+(h/2),y(i)+(k2/2)); 
    k4=h*f(x(i)+h,y(i)+k3); 
    y(i+1)=y(i)+(1/6)*(k1+2*k2+2*k3+k4);
    fprintf('y(%0.2f)=%0.4f\n',x(i+1),y(i+1))
end

% Solve using ode45 solver to find the exact solution
[x_exact, y_exact] = ode45(f, [x0:h:xn], y0);

% Calculate error and error percentage
error = abs(y_exact - y');
error_percentage = abs((y_exact - y') ./ y_exact) .* 100;

% Combine the results into a matrix
output = [x', y', y_exact, error, error_percentage];

% Define the headings for the CSV file
headings = {'x', 'RK-4 Method', 'Exact Solution', 'Error', 'Error (%)'};

% Write the matrix to a CSV file
outputFile = 'rk4_example_2.csv';
writecell(headings, outputFile, 'Delimiter', ',');
dlmwrite(outputFile, output, 'Delimiter', ',', '-append');

% Plot the solution RK-2 Method vs Exact
plot(x, y, '*r--', 'LineWidth', 1.5, 'MarkerFaceColor', 'r', 'MarkerSize', 7);
hold on;
plot(x_exact, y_exact, 'sb--', 'LineWidth', 1.5, 'MarkerFaceColor', 'b', 'MarkerSize', 7);
hold off;
xlabel('x');
ylabel('y');
grid on;
title('RK-4 Method vs Exact Solution');
legend("RK-4 Method", 'Exact Solution', 'Location', 'best');
set(gca, 'FontSize', 20)