clc;clear;close all;
% 读取音频文件
[y, fs] = audioread('Jan.wav');

% 计算频谱图
noverlap = 128; % 帧重叠
window = hamming(256); % 汉明窗
nfft = 512; % FFT 点数
% 绘制频谱图

spectrogram(y, window, noverlap, nfft, fs, 'yaxis');title('Jan的音频信号频谱图'); 
print('Jan_sp','-depsc','-painters');
% 读取音频文件
[y, fs] = audioread('Feb.wav');

% 计算频谱图
noverlap = 128; % 帧重叠
window = hamming(256); % 汉明窗
nfft = 512; % FFT 点数
% 绘制频谱图

spectrogram(y, window, noverlap, nfft, fs, 'yaxis');title('Feb的音频信号频谱图'); 
print('Feb_sp','-depsc','-painters');
% 读取音频文件
[y, fs] = audioread('Mar.wav');

% 计算频谱图
noverlap = 128; % 帧重叠
window = hamming(256); % 汉明窗
nfft = 512; % FFT 点数
% 绘制频谱图

spectrogram(y, window, noverlap, nfft, fs, 'yaxis');title('Mar的音频信号频谱图'); 
print('Mar_sp','-depsc','-painters');
% figure;
% melSpectrogram(y, window, noverlap, nfft, fs, 'yaxis');
% title('梅尔频谱图');

% 
% % 读取音频文件
% [y, fs] = audioread('Jan.wav');
% 
% % 计算梅尔频谱图
% window = hamming(256); % 汉明窗
% noverlap = 128; % 帧重叠
% nfft = 512; % FFT 点数
% 
% figure;
% melSpectrogram(y, fs, 'WindowLength', 256, 'OverlapLength', 128, 'NumBands', 40:3);
% title('梅尔频谱图');
% figure;
% % 绘制梅尔频图
% melSpectrogram(y, window, noverlap, nfft, fs, 'yaxis');
% title('梅尔频谱图');