clc;clear;close all;
num = 10; den = conv([1, 1], conv([1, 3], [1, 5]));
k = 0.6667; L = 0.293; T = 1.947;
G = tf(num, den);
Kp = 1.2 * T / (k * L);
Ti = 2 * L;
Td = 0.5 * L;
Kp, Ti, Td
s = tf('s')
Gc = Kp * (1 + 1/(Ti * s) + Td * s);
GcG = feedback(Gc * G, 1);step(GcG);
h = findobj(gcf, 'Type', 'line');
set(h, 'LineWidth', 2);
set(h, 'Color', 'b');
set(gca, 'LineWidth', 1.5);
grid on;