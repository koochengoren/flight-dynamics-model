% roc.m - Rate of climb
function xdot = aceqs(t,x)
rpd = pi/180.;									
cla = .1000;									
alpha = 4.6;											

if t > 5
   alpha = 2;
end
if t > 20
   alpha = 1.3;
end
if t > 30
   alpha = 1.1;
end
if t > 40
   alpha = 3.1;
end

cdo = 0.0195;					
k = .0392;
cl = cla * alpha;								
cd = cdo + k*cl^2;
s = 29.73; 

mass = 8300;   
xdot=zeros(7,1);
rearth = 6378140.;
wplanet = 2.*pi/86400.;

h = x(1) - rearth;
mu = 3.986d5;
g = (mu/(rearth/1000.)^2)*1000.;
rhoo = 1.225;
ry = 287.;
tkel = 288.;
z = g/(ry*tkel);
rho = rhoo*exp(-z*h);

lift = .5*rho*x(4)^2*cl*s;
drag = .5*rho*x(4)^2*cd*s;

   thrust = 2 * 18291.1 * (rho/rhoo);

alphat = alpha * rpd;
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

 %fprintf('lift is %7.1f\n',lift);
 %fprintf('drag is %7.1f\n',drag);
