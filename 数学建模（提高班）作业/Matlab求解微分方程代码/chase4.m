t0=0;tf=100;
[t,y]=ode45('eq4',[t0 tf],[0 0]);
T=0:0.1:2*pi;
X=10+20*cos(T);
Y=20+15*sin(T);
plot(X,Y,'-')
hold on
plot(y(:,1),y(:,2),'*')

