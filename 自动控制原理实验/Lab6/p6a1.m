clc;clear;close all;
G1 = tf(5,conv([1,1,0],[0,0.5,1]));
bode(G1,'r--');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
figure;
w=10e-2:0.01:10;
[x1,y1]=bd_asymp(G1,w);
semilogx(x1,y1,"LineWidth",1.5),grid on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('$\omega/\omega_n$','fontsize',14,'Interpreter','latex');
ylabel('$L(\omega)/dB$','fontsize',14,'Interpreter','latex');
title('$G_1(s)=\frac{100}{s(s^2+2s+3)(3s+2)}$','fontsize',20,'Interpreter','latex');
syms x
eqn = 0.25*x^6 + 1.25*x^4 + x*2 == 25;
x = solve(eqn,x);
p = [0.25,0,1.25,0,1,0,-25];
roots(p)
figure;
margin(G1)
[x1,x2,x3,x4] = margin(G1);