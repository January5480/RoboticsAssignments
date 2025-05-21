clc;clear;close all;
num1=5;
den1=conv([1 1 0],[0 0.5 1]);
G0=tf(num1, den1);
% num2=[5*18.52 5];
% den2=conv([1 1 0],conv([0.5 1],[168.35 1]));
% G1=tf(num2,den2)
G1 = tf([18.52,1],[168.35,1]);
G=series(G1,G0);

w=10e-3:0.01:100;

[x,y]=bd_asymp(G,w);
[x0,y0]=bd_asymp(G0,w);
[x1,y1]=bd_asymp(G1,w);

figure(1)
hold on
semilogx(x0, y0, 'r'); 
semilogx(x, y, 'k'); 
semilogx(x1, y1, 'b');
hold off
grid 
legend