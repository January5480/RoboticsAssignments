clc; clear; close all;

den1 = conv([1, 0], [1, 0])
den2 = conv(den1, [0.1, 1])
den3 = conv(den2, [0.05, 1])
h = tf(5, den3)

zh = c2d(h, 0.2, 'zoh');

[num, den] = tfdata(zh, 'v')

[z, p, k] = tf2zpk(num, den)