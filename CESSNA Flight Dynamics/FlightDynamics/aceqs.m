% Filename : aceqs.m - EOM's for the main cessnagui file

function xdot = aceqs(t,x)
 rpd = pi/180.;
 cla = 0.1;
 

alpha=7;
if t>5
   alpha=4;
end
if t>100
   alpha=3;
end
if t>200
   alpha=2;
end

if t>300 
   alpha=1.9; 
end

if t>400
   alpha=2.5;
end

if t>500
   alpha=1.9;
end

if t>600
   alpha=1.8;
end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Second best alpha strategy
%alpha = 6; if t>5 alpha=3.5; end; if t>20 & t<35 alpha=3; end; if t>35 & t<55 alpha=3.2; end;
%if t>55 & t<60 alpha=3.3;end; if t>60 & t<65 alpha=3.5;end; if t>65 & t<70 alpha=3.4;end;
%if t>70 & t<75 alpha=3.4;end; if t>75 & t<80 alpha=3.5;end; if t>80 & t<85 alpha=3.9;end;
%if t>85 & t<90 alpha=3.7; end; if t>90 & t<95 alpha=3.8; end; if t>95 & t<100 alpha=3.9; end;
%if t>100 & t<300 alpha=4.0; end; if t>300 & t<400 alpha=3.9;end; if t>400 & t<500 alpha=3.8;end;
%if t>500 & t<600 %alpha=3.7;alpha=2;end; if t>600 & t<700 %alpha=3.6; alpha=2;end; 
%if t>700 & t<800 %alpha=3.4; alpha=2; end;
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Third best alpha strategy
%alpha = 8;  if t>5 alpha=3.0; end;  if t>20 & t<35  alpha=3.1; end;  if t>35 & t<55 alpha=3.2; end; 
%if t>55 & t<60 alpha=3.3; end; if t>60 & t<65 alpha=3.4; end;  if t>65 & t<70 alpha=3.5; end; 
%if t>70 & t<75 alpha=4.0;end; if t>75 & t<80 alpha=4.0;end; if t>80 & t<85 alpha=4.0; end; 
%if t>85 & t<90 alpha=4.0;end; if t>90 & t<95 alpha=4.0;end; if t>95 & t<100 alpha=4.0;end;
%if t>100 & t<105 alpha=4.3; end; if t>105 & t<250 alpha=4.3; end; if t>250 & t<800 alpha=7.9; end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 cdo = 0.0195;
 k = 0.0392;
 cl = cla * alpha;
 cd = cdo + k * cl ^ 2;
%s = 34.35; %m^2
s = 29.792 ; %m^2
 mass = 9072; % Maximum takeoff weight
 %mass=8186;
 xdot=zeros(7,1);
 rplanet = 6378140.;
 wplanet = 2.*pi/86400.;
 h = x(1) - rplanet;
 mu= 3.986e5;
 g = (mu/(rplanet/1000.)^2)*1000.;
 rhoo = 1.225;
 ry = 287.;
 tkel = 288.;
 z = g/(ry*tkel);
 rho = rhoo*exp(-z*h);

 lift = .5*rho*x(4)^2*cl*s;
 drag = .5*rho*x(4)^2*cd*s;
%thrust = 18291.1*2;
thrust = 18291.1*2*(rho/rhoo);
 alphat = alpha*rpd;
 xdot(1) = x(4)*sin(x(5));
 xdot(2) = x(4)*cos(x(5))*cos(x(6))/(x(1)*cos(x(3)));
 xdot(3) = x(4)*cos(x(5))*sin(x(6))/x(1);
 xdot(4) = ((-drag+thrust*cos(alphat))/mass) - g*sin(x(5)) ...
 + wplanet^2*x(1)*cos(x(3))*(sin(x(5))*cos(x(3))-cos(x(5))*sin(x(3))*sin(x(6)));
 xdot(5) = (1./x(4))*(((lift+thrust*sin(alphat))/mass) - g*cos(x(5)) + ...
  x(4)^2*cos(x(5))/x(1) + 2.*wplanet*x(4)*cos(x(3))*cos(x(6)) + ...
  wplanet^2*x(1)*cos(x(3))*(cos(x(5))*cos(x(3))+sin(x(5))*sin(x(3))*sin(x(6))));
 xdot(6) = (1./x(4))*(-x(4)^2*cos(x(5))*cos(x(6))*tan(x(3))/x(1) + ...
  2.*wplanet*x(4)*(tan(x(5))*cos(x(3))*sin(x(6))-sin(x(3))) - ...
  wplanet^2*x(1)*sin(x(3))*cos(x(3))*cos(x(6))/cos(x(5)));
 rhodot = -z*xdot(1)*rhoo*exp(-z*h);
 ddrag = .5*cd*s*(rhodot*x(4)^2 + 2*rho*x(4)*xdot(4));
 cg=cos(x(5));
 sg=sin(x(5));
 cl=cos(x(3));
 sl=sin(x(3));
 cp=cos(x(6));
 sp=sin(x(6));
 junk = sg*cl-cg*sl*sp;
 djunk = xdot(5)*cg*cl-xdot(3)*sg*sl+xdot(5)*sg*sl*sp-xdot(3)*cg*cl*sp ...
   - xdot(6)*cg*sl*cp;
 xdot(7) = (-ddrag/mass - g*xdot(5)*cg + wplanet^2*(xdot(1)*cl*junk ...
    - x(1)*xdot(3)*junk*sl + x(1)*cl*djunk))/9.8;
 
