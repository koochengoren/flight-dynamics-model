% Ceiling - program to compute ceiling during Ascent

function xdot = aceqs(t,x)

rpd = pi/180.;% Radian to degree converstion
cla = .1000; % Coefficient of LIFT

alpha = 4.5;	 % Initial Angle of Attack


if t > 5
   alpha = 2.5;
end
if t > 20
   alpha = 2;
end
if t > 200
   alpha = 2.5;
end
if t > 300
   alpha = 3;
end
if t > 400
   alpha = 3.5;
end
if t > 500
   alpha = 5;
end

if t>800
   alpha=5.5;
end
if t>1000
   alpha=6;
end
if t>1200
   alpha=5;
end


   
 cdo = 0.0195;
 k = 0.0392;
 cl = cla * alpha;
 cd = cdo + k * cl ^ 2;
%s = 34.35; %m^2
s = 29.792 ; %m^2
mass=9072;
%mass = 6300; % Maximum takeoff weight
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
