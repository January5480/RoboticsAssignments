     [t,x]=ode45('shier',[0 15],[25 2]);         
     plot(t,x(:,1),'-',t,x(:,2),'*')
     figure(2)
     plot(x(:,1),x(:,2))
