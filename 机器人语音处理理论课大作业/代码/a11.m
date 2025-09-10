clc;clear;close all;
% 读取音频文件
[y_1, fs_1] = audioread('Jan.wav'); 
ymax_1 = max(abs(y_1));
y_1 = y_1 / ymax_1;
% 绘制音频信号波形图
t_1 = (1:length(y_1)) / fs_1; 
% subplot(1,3,1);
plot(t_1, y_1);
xlabel('时间 (秒)');
ylabel('振幅');
title('Jan的音频信号波形图');
grid on; 
print('Jan','-depsc','-painters');

% 读取音频文件
[y_2, fs_2] = audioread('Feb.wav'); % 'your_audio_file.wav' 是你的音频文件名
ymax_2 = max(abs(y_2));
y_2 = y_2 / ymax_2;
% 绘制音频信号波形图
t_2 = (1:length(y_2)) / fs_2; % 创建时间向量
subplot(1,3,2);
plot(t_2, y_2);
xlabel('时间 (秒)');
ylabel('振幅');
title('Feb的音频信号波形图');
grid on; % 添加网格线以便于观察
print('Feb','-depsc','-painters');

% 读取音频文件
[y_3, fs_3] = audioread('Mar.wav'); % 'your_audio_file.wav' 是你的音频文件名
ymax_3 = max(abs(y_3));
y_3 = y_3 / ymax_3;
% 绘制音频信号波形图
t_3 = (1:length(y_3)) / fs_3; % 创建时间向量
% subplot(1,3,3);
plot(t_3, y_3);
xlabel('时间 (秒)');
ylabel('振幅');
title('Mar的音频信号波形图');
grid on; % 添加网格线以便于观察
print('Mar','-depsc','-painters');



