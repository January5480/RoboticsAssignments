t0=0,tf=2;
[t,y]=ode45('eq2',[t0 tf],[0 0]);
X=1;
Y=0:0.01:2;
plot(X,Y,'-')
hold on
plot(y(:,1),y(:,2),'*')

