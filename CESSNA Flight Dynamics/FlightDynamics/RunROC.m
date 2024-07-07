%RunRoc.m - program that invokes the EOM's for the rate of climb

clear all;

rearth=6378140.;
rpd=pi/180.;
dpr=180./pi;
t0 = 0;
tf = 50;
path_angle = 0 * rpd;
velocity = 100;
heading = 0;
Gs = 0.3;

x0 = [rearth 0 0 velocity path_angle heading Gs];
TSPAN = [t0 tf];
tol = 1e-9;
OPTIONS = odeset('AbsTol',[tol tol tol tol tol tol tol]);
[t,x] = ode45('roc',TSPAN,x0,OPTIONS);

figure(6)
altitude = x(:,1)-rearth;
%altitude = ((x(:,1)-rearth)/1000); % common for most plots
subplot(2,2,1);plot(t,altitude);
xlabel('Time (s)')
ylabel('Altitude (m)')
title('Altitude Vs. Time')


subplot(2,2,2);plot(x(:,7),altitude);
xlabel('Acceleration (Gs)')
ylabel('Altitude (m)')
title('Altitude Vs. G-force')


subplot(2,2,3);plot(t,x(:,4)/1000)
xlabel('Time (sec)')
ylabel('Velocity (km/s)')
title('Velocity Vs. Time')

subplot(2,2,4);plot(altitude,(x(:,5)*dpr));
xlabel('Altitude (m)')
ylabel('Gamma (deg)')
title('Gamma Vs. Altitude')

% rate of climb vs velocity
figure(14)
roc=(303)*sin(3.0224);
plot(roc,x(:,4)/1000);
xlabel('roc');
ylabel('velocity');


 