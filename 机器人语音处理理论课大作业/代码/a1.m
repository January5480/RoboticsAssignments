% 实现语音的采集和图表的展示

clc; clear; close all;

Fs = 11025; % 采样率
NumChannels = 2; % 通道数
nBits = 16; % 采样位数
duration = 5; % 录音时长（秒）

% 创建录音对象
recorder = audiorecorder(Fs, nBits, NumChannels);

% 开始录音
disp('开始录音...');
recordblocking(recorder, duration); % 录制指定时长的音频

% 获取录音数据
audioData = getaudiodata(recorder);

% 归一化音频数据
ymax = max(abs(audioData(:)));
audioData = audioData / ymax;

% 保存录音
audiowrite('test.wav', audioData, Fs);

% 绘制音频波形
t = (0:length(audioData)-1) / Fs; % 时间轴
figure;
plot(t, audioData);
xlabel('时间 (秒)');
ylabel('振幅');
title('录音波形');