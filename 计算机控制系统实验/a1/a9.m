clc; clear; close all;
% 定义原始传递函数参数
num = [1, 1, 0];  % s^2 + s (连续) 或 z^2 + z (离散)
den = [1, 5, 6];  % s^2 + 5s + 6 或 z^2 + 5z + 6
T = 0.1;          % 采样时间

% 转换为零极点增益模型
[z_zeros, p_poles, k_gain] = tf2zp(num, den);
Gs2 = zpk(z_zeros, p_poles, k_gain);      % 连续系统（默认）
Gz2 = zpk(z_zeros, p_poles, k_gain, T);   % 离散系统（指定采样时间）
syms s z  
Gs2_sym = k_gain * prod(s - z_zeros.') / prod(s - p_poles.');
Gz2_sym = k_gain * prod(z - z_zeros.') / prod(z - p_poles.');
% 
% % 简化表达式（可选）
% Gs2_sym = simplify(Gs2_sym);
% Gz2_sym = simplify(Gz2_sym);
Gz2_latex = latex(Gs2_sym)
pretty(Gz2_sym)