% clc;clear;close all;
% num = 10;den = conv([1,1], conv([1, 3], [1, 5]));
% G = tf(num, den);step(G);
% k = dcgain(G)
% set(gca, 'LineWidth', 3);
% 
% set(gca.Children, 'linewidth', 3);
% grid on;
% k = 1.5;
% % k = 0.6667;
clc; clear; close all;
num = 10;
den = conv([1, 1], conv([1, 3], [1, 5]));
G = tf(num, den);
step(G);
h = findobj(gcf, 'Type', 'line');
set(h, 'LineWidth', 3);
set(h, 'Color', 'b'); 
set(gca, 'LineWidth', 3, 'FontSize', 14, 'FontWeight', 'bold');
grid on;

% 设置网格的样式
% set(gca, 'GridLineStyle', '--', 'GridColor', 'k', 'GridAlpha', 0.5);

% 添加标题和标签
% title('Step Response of Transfer Function G(s)', 'FontSize', 16, 'FontWeight', 'bold');
% xlabel('Time (s)', 'FontSize', 12);
% ylabel('Amplitude', 'FontSize', 12);

% 添加图例
% legend('Step Response', 'Location', 'best', 'FontSize', 12);

% 添加注释
% text(2, 0.8, 'Step Response of G(s)', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'r');

% 显示直流增益
k = dcgain(G);
disp(['DC Gain: ', num2str(k)]);