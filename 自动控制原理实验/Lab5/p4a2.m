clc;clear;close all;
G1 = tf(100,conv([1,2,3],[3,2,0]));
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
title('$G_1(s)=\frac{100}{s(s^2+2s+3)(3s+2)}$','fontsize',20,'Interpreter','latex')

figure;
G2 = tf([100,100],conv([1,2,3,0],[1,4,5]));
bode(G2,'r--');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid on;
figure;
w=10e-2:0.01:10;
[x2,y2]=bd_asymp(G2,w);
semilogx(x2,y2,"LineWidth",1.5),grid on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('$\omega/\omega_n$','fontsize',14,'Interpreter','latex');
ylabel('$L(\omega)/dB$','fontsize',14,'Interpreter','latex');
title('$G_2(s)=\frac{100(s+1)}{s(s^2+2s+3)(s^2+4s+5)}$','fontsize',20,'Interpreter','latex')

figure;
syms s; 
p = s*(s+2)*(s+3)*(s+4)*(s+5); %定义多项式p
a = sym2poly(p);%求多项式p的系数
G3 = tf([10,10],a);
bode(G3,'r--');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
grid on;
figure;
w=10e-3:0.01:10;
[x3,y3]=bd_asymp(G3,w);
semilogx(x3,y3,"LineWidth",1.5),grid on;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlabel('$\omega/\omega_n$','fontsize',14,'Interpreter','latex');
ylabel('$L(\omega)/dB$','fontsize',14,'Interpreter','latex');
title('$G_3(s)=\frac{10(s+1)}{s(s+2)(s+3)(s+4)(s+5)}$','fontsize',20,'Interpreter','latex')