function dy=eq2(t,y)
dy=zeros(2,1);
dy(1)=5*(1-y(1))/sqrt((1-y(1))^2+(t-y(2))^2);
dy(2)=5*(t-y(2))/sqrt((1-y(1))^2+(t-y(2))^2);

