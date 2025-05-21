function dy=shier2(t,y)
    dy=zeros(2,1); 
    dy(1)=y(1)*(0.9-0.1*y(2));
    dy(2)=y(2)*(-0.6+0.02*y(1));