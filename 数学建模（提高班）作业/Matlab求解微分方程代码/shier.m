function dx=shier(t,x)
    dx=zeros(2,1); 
    dx(1)=x(1)*(1-0.1*x(2));
    dx(2)=x(2)*(-0.5+0.02*x(1));