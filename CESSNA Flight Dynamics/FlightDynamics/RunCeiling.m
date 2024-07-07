% program to plot Ceiling
% RunCeiling.m 

clear all;
pi=3.14;
rearth=6378140.;
rpd=pi/180.;
dpr=180./pi;
t0 = 0;
tf = 6000;
pa = 0 * rpd; % path_angle
velocity = 100; % m/s
heading = 0;
Gs = 0.3;


x0 = [rearth 0 0 velocity pa heading Gs];
TSPAN = [t0 tf];
tol = 1e-9;
options = odeset('AbsTol',[tol tol tol tol tol tol tol]);
[t,x] = ode45('Ceiling',TSPAN,x0,options);

figure(4) % to open a separate figure from the GUI
altitude = ((x(:,1)-rearth)/1000); % common for most plots

subplot(2,2,1);plot(t,altitude);
xlabel('Time (sec)')
ylabel('Altitude (km)')
title('Altitude Vs. Time')


subplot(2,2,2);plot(x(:,7),altitude);
xlabel('Acceleration (Gs)')
ylabel('Altitude (km)')
title('Altitude Vs. G-force')


subplot(2,2,3);plot(t,x(:,5)*dpr)
xlabel('Time (sec)')
ylabel('Gamma (degrees)')
title('Gamma Vs. Time')

subplot(2,2,4);plot(altitude,(x(:,4)));
xlabel('Altitude (km))')
ylabel('Velocity (m/s)')
title('Altitude Vs. Velocity')

