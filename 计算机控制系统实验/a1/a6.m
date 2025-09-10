clc; clear; close all;
num = [1, 1, 0];
den = [1, 5, 6];
T = 0.1;
Gs1 = tf(num, den)
Gz1 = tf(num, den, T)
disp('传递函数模型转换为零点增益')
[z, p, k] = tf2zp(num, den);
Gs2 = zpk(z, p, k)
Gz2 = zpk(z, p, k, T)

z = [0, -1];
p = [-2, -3];
k = [1];
T = 0.1;
Gs2 = zpk(z, p, k)
Gz2 = zpk(z, p, k, T)
disp('零点增益转换为传递函数模型')
z = [0, -1];
p = [-2, -3];
k = [2];
T = 0.1;
Gs1 = zpk(z, p, k)
Gz1 = zpk(z, p, k, T)
[num, den] = zp2tf(z', p', k');
Gs2 = tf(num, den)
Gz2 = tf(num, den, T)

