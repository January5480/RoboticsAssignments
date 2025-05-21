clc;clear;close all;
G1 = tf(100,conv([1,2,3],[3,2,0]));
% w = [0.6667,1.732];
bode(G1,'r--');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
% title('$G_1(s)=\frac{100}{s(s^2+2s+3)(3s+2)}$','fontsize',14,'Interpreter','latex')
grid on;
figure;
w=10e-2:0.01:10;
[x1,y1]=bd_asymp(G1,w);
semilogx(x1,y1,"LineWidth",1.5);grid on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('$\omega/\omega_n$','fontsize',14,'Interpreter','latex');
ylabel('$L(\omega)/dB$','fontsize',14,'Interpreter','latex');
title('$G_1(s)=\frac{100}{s(s^2+2s+3)(3s+2)}$','fontsize',20,'Interpreter','latex')