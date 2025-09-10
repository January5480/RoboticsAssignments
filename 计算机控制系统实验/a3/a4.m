clc;clear;close all;
k = 10; z = []; p = [-1, -3, -5];
Go = zpk(z, p, k);G = tf(Go)
Km = 19.2;Tm = 1.313;
Kp = 0.5 * Km; Ti = 0.5 * Tm; Td = 0.125 * Tm;
Kp, Ti, Td
s = tf('s');
Gc = Kp * (1 + 1 / (Ti * s) + Td * s);
sys = feedback(Gc * G, 1);
step(sys);
h = findobj(gcf, 'Type', 'line');
set(h, 'LineWidth', 2);
set(h, 'Color', 'b');
set(gca, 'LineWidth', 1.5);
grid on;
