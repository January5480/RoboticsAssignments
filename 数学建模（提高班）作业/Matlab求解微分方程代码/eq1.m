   function dy=eq1(x,y)
    dy=zeros(2,1);
    dy(1)=y(2);
    dy(2)=1/5*sqrt(1+y(1)^2)/(1-x); 