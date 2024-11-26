% Define the ODE as a function
dydx = @(x, y) exp(-x) - y;

% Initial conditions
x0 = 0;  % Initial x value
y0 = 1;  % Initial y value

% Solve the ODE using ode45
[x, y] = ode45(dydx, [x0 5], y0);

% Plot the solution
plot(x, y, 'b', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('y');
title('Solution of dy/dx + y = e^{-x}');
legend('Numerical Solution');

% Overlay the analytical solution for comparison
x_analytical = linspace(0, 5, 100);
y_analytical = exp(-x_analytical) .* (x_analytical + 1);
hold on;
plot(x_analytical, y_analytical, 'r--', 'LineWidth', 1.5);
legend('Numerical Solution', 'Analytical Solution');
hold off;

