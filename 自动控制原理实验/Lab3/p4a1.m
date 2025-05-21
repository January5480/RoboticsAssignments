clc;clear;close all;
G1 = tf(1,[1,1]);
t = [0:0.01:5];
u1 = sin(2*t);
[y,x] = lsim(G1,u1,t);
figure;
y1 = y-u1';
plot(t,y1);
