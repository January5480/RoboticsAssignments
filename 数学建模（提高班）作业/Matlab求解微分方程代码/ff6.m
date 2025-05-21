x0=0;xf=0.99999;
[x,y]=ode23('eq1',[x0 xf],[0 0]);
 Y=0:0.01:2;
   plot(1,Y,'g.')
   hold on
plot(x,y(:,1),'b*') 
     
   
