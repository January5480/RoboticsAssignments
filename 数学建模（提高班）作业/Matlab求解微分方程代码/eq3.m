function dy=eq3(t,y)
dy=zeros(2,1);
dy(1)=20*(10+20*cos(t)-y(1))/sqrt((10+20*cos(t)-y(1))^2+(20+15*sin(t)-y(2))^2);
dy(2)=20*(20+15*sin(t)-y(2))/sqrt((10+20*cos(t)-y(1))^2+(20+15*sin(t)-y(2))^2);

