clc; clear; close all;

num = [3];
den = [1, 3];
T = 0.1;
gs = tf(num, den)
gz = c2d(gs, T, 'zoh')

[z, p, k] = tf2zp(num, den);
figure;pzmap(gs)
title('零极点图');grid;
figure;pzmap(gz);
title('零极点图');grid;
figure;rlocus(gs)
title('根轨迹图');grid;
figure;rlocus(gz)
grid;title('根轨迹图');
figure;impulse(gs); title('单位脉冲响应');
figure; impulse(gz);title('单位脉冲响应');
figure; step(gs); title('单位阶跃相应');
figure; step(gz); title('单位阶跃相应');

figure; freqs(num, den); 

figure; freqz(num, den); 
figure; bode(gs); 
figure; bode(gz); 

figure; nyquist(gs); 
figure; nyquist(gz); 

figure; nichols(gs); 
figure; nichols(gz); 



