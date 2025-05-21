clc;clear;close all;
xi = 0.1;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys0 = feedback(sys,1);
xi = 0.2;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys1 = feedback(sys,1);
xi = 0.3;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys2 = feedback(sys,1);
xi = 0.4;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys3 = feedback(sys,1);
xi = 0.5;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys4 = feedback(sys,1);
xi = 0.6;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys5 = feedback(sys,1);
xi = 0.7;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys6 = feedback(sys,1);
xi = 0.8;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys7 = feedback(sys,1);
xi = 0.9;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys8 = feedback(sys,1);
xi = 1;
a = (sqrt(8)*xi-1)/4
G1 = tf([8],[1,2,0]);
G2 = tf([a,0],[1]);
sys = feedback(G1,G2,-1);
sys9 = feedback(sys,1);
t = [0:0.05:5];
step(sys0, sys1, sys2, sys3, sys4, sys5, sys6, sys7, sys8, sys9, t);
h = findobj(gcf, 'Type', 'Line');
for i = 1:length(h)
    set(h(i), 'LineWidth', 2);  
end
set(gca,'LineWidth',1);
axis([0 5 0 1.8]);
lgd = legend('a=-0.1793','a=-0.1086','a=-0.0379','a=-0.0328','a=0.1036','a=0.1743','a=0.2450','a=0.3157','a=0.3864','a=0.4571');
lgd.NumColumns = 2;
legendLines = findobj(lgd, 'Type', 'Line');  
for i = 1:length(legendLines)
    set(legendLines(i), 'LineWidth', 2);  
end
grid on;
title('不同a下的响应曲线');