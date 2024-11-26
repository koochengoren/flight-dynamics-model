L = 1;
T = 0.5;
alpha = 0.01;

Nx = 20;
Nt = 500;
dx = L / (Nx - 1);
dt = T / Nt;

if dt > dx^2 / (2 * alpha)
    error('Stability condition violated: reduce dt or increase dx');
end

x = linspace(0, L, Nx);
t = linspace(0, T, Nt);
u = zeros(Nx, Nt);

u(:, 1) = sin(pi * x)';

for n = 1:Nt-1
    for i = 2:Nx-1
        u(i, n+1) = u(i, n) + alpha * dt / dx^2 * (u(i+1, n) - 2 * u(i, n) + u(i-1, n));
    end
    u(1, n+1) = 0;
    u(Nx, n+1) = 0;
end

figure;

hold on;
plot(x, u(:, 1), 'DisplayName', 't = 0');
plot(x, u(:, round(Nt/4)), 'DisplayName', 't = T/4');
plot(x, u(:, round(Nt/2)), 'DisplayName', 't = T/2');
plot(x, u(:, end), 'DisplayName', 't = T');
xlabel('x');
ylabel('u(x, t)');
title('Heat Equation Solution');
legend show;
hold off;

