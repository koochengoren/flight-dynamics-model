% To calculate the range
% Actually, the aircraft starts at 0 degree Latitude and 0 degree Longitude on 
% a heading of 0 degree. Thus to compute range, we need to compute the change in 
% Longitude during the ascent.

pi=3.14;
rpd=pi/180;
mu= 3.986e5;
rearth=6378140;

to=0;
tf=800;
%0.273
xo=[rearth 0 0 100.0 0 0 1];
options=odeset('AbsTol',[1e-9 1e-9 1e-9 1e-9 1e-9 1e-9 1e-9]);
tspan=[to tf];
% tol=1.d-9;
[t,x]=ode45('aceqs',tspan,xo,options);

figure(5);
plot(t,x(:,2))
xlabel('Time (sec)')
ylabel('Longitude (radians)')
Title('Longitude Vs. Time (800s max)');

to=0;
tf=1000;
xo=[rearth 0 0 100.0 0 0 1];
options=odeset('AbsTol',[1e-9 1e-9 1e-9 1e-9 1e-9 1e-9 1e-9]);
tspan=[to tf];
% tol=1.d-9;
[t,x]=ode45('aceqs',tspan,xo,options);

figure(7);
plot(t,x(:,2))
xlabel('Time (sec)')
ylabel('Longitude (radians)')
Title('Longitude Vs. Time (1000s max)');

to=0;
tf=6000;
xo=[rearth 0 0 100.0 0 0 1];
options=odeset('AbsTol',[1e-9 1e-9 1e-9 1e-9 1e-9 1e-9 1e-9]);
tspan=[to tf];
% tol=1.d-9;
[t,x]=ode45('aceqs',tspan,xo,options);

figure(9);
plot(t,x(:,2))
xlabel('Time (sec)')
ylabel('Longitude (radians)')
Title('Longitude Vs. Time (6000s max)');
