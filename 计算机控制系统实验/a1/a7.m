clc; clear; close all;
num1=[1,1];
num2=[1,2,2];
den1=[1,0,2];
den2=[1,4,8];
num=conv(num1,num2);
den=conv(den1,den2);
T=0.1;
Gs1=tf(num,den)
s = sym('s');
Gs1_sym = poly2sym(num, s) / poly2sym(den, s);
Gs1_latex = latex(Gs1_sym);
subplot 411
text(0.1, 0.5, ['$G_{s} = ' Gs1_latex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

Gz1=tf(num,den,T)
z = sym('z');
Gz1 = tf(num, den, T);
Gz1_sym = poly2sym(num, z) / poly2sym(den, z);
Gz2_latex = latex(Gz1_sym);
subplot 412
text(0.1, 0.5, ['$G_{z} = ' Gz2_latex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

[z,p,k]=tf2zp(num,den);

syms s z  
[z_zeros, p_poles, k_gain] = tf2zp(num, den);
Gs2 = zpk(z_zeros, p_poles, k_gain)      % 连续系统（默认）
Gz2 = zpk(z_zeros, p_poles, k_gain, T)   % 离散系统（指定采样时间）
Gs2_sym = k_gain * prod(s - z_zeros.') / prod(s - p_poles.');
Gz2_sym = k_gain * prod(z - z_zeros.') / prod(z - p_poles.');
Gz2_latex = latex(Gs2_sym);
subplot 413
text(0.1, 0.5, ['$G_{s} = ' Gz2_latex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

Gz2_latex = latex(Gz2_sym);
subplot 414
text(0.1, 0.5, ['$G_{z} = ' Gz2_latex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off
% Gs2=zpk(z,p,k)
% Gz2=zpk(z,p,k,T)