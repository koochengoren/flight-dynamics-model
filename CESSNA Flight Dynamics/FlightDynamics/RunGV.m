% program to plot Glide Path angle.
% RunGV.m 

clear all;

%rearth=6378140.;
rearth=6378140;
rpd=pi/180.;
dpr=180./pi;
t0 = 1000; % point(10.5 km)where the engine is shut off to make the cessna glide.
tf = 3300;
pa = 0 * rpd; % path angle
velocity = 100; % m/s
%velocity=300;
heading = 0;
Gs = 0.33;



x0 = [(rearth+10670) 0 0 (300) pa heading Gs];
TSPAN = [t0 tf];
tol = 1e-9;
options = odeset('AbsTol',[tol tol tol tol tol tol tol]);
[t,x] = ode45('GlideVel',TSPAN,x0,options);

altitude = (x(:,1)-rearth)/1000;



figure(3) % to open a separate figure from the GUI
plot(x(:,4), x(:,5))
xlabel('Velocity (m/s)')
ylabel('Glide Path Angle (deg)')
title('Glide Path Angle Vs. Velocity')


figure(2) % to open a separate figure from the GUI
subplot(2,2,1);plot(t,altitude);
xlabel('Time (sec)')
ylabel('Altitude (km)')
title('Altitude Vs. Time')
%axis([0 1600 0 17])

subplot(2,2,2);plot(x(:,7),altitude);
xlabel('Acceleration (Gs)')
ylabel('Altitude (km)')
title('Altitude Vs. G-force')


subplot(2,2,3);plot(t,x(:,4))
xlabel('Time (sec)')
ylabel('Velocity (m/s)')
title('Velocity Vs. Time')
%axis([0 1600 1 300])

subplot(2,2,4);plot(t,(x(:,5)*dpr));
xlabel('Time(sec)')
ylabel('Gamma (deg)')
title('Gamma Vs. Time')

figure(8) % to open a separate fig for Altitude vs Time
plot(t,altitude);
xlabel('Time (sec)')
ylabel('Altitude (km)')
title('Altitude Vs. Time')

