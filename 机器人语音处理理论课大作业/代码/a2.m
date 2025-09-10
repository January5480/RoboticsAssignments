clc; clear; close all;

% 读取语音信号
[y, fs] = audioread('test.wav');

% 设置阈值
high_threshold = 0.01; % 高门限（根据信号的能量调整）
low_threshold = 0.001; % 低门限（根据信号的能量调整）

% 调用双门限法端点检测函数
[start_point, end_point] = vad_TwoThr(y, fs, high_threshold, low_threshold);

