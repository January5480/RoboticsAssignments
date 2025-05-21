clc;clear;close all;
xi = 0.5;%欠阻尼
a = (sqrt(8)*xi-1)/4;
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys2 = feedback(sys,1)
subplot(2,2,1);
step(sys2,'b')
grid on;
title('\xi=0.5,欠阻尼')

xi = 1;%临界阻尼
a = (sqrt(8)*xi-1)/4;
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys2 = feedback(sys,1)
subplot(2,2,2);
step(sys2,'r')
grid on;
title('\xi=1,临界阻尼')

xi = 2;%过阻尼
a = (sqrt(8)*xi-1)/4;
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys2 = feedback(sys,1)
subplot(2,2,3);
step(sys2,'r')
grid on;
title('\xi=2,过阻尼')

xi = 0;%无阻尼
a = (sqrt(8)*xi-1)/4;
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys2 = feedback(sys,1)
subplot(2,2,4);
t = [0:0.005:10];
[y,x,t] = step(sys2,t);
plot(x,y,'r')
grid on;
title('\xi=0,无阻尼')



