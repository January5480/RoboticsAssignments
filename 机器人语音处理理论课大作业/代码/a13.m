clear all; clc; close all;

% 读取音频文件
[x, fs] = audioread('Jan.wav');

% 提取梅尔频率倒谱系数（MFCC）特征
wlen = round(0.025 * fs); % 帧长为25毫秒
inc = round(0.0125 * fs); % 帧移为12.5毫秒
mfcc_features = mfcc(x);
% 初始化和训练HMM
N = 4; % 状态数
M = [3, 3, 3, 3]; % 每个状态的混合模型成分数

% 初始化HMM
hmm_temp = inithmm(mfcc_features, N, M); % 初始化HMM模型
hmm = baum_welch(hmm_temp, mfcc_features); % 迭代更新HMM的各参数

% 保存结果到.mat文件
save('Jan_vad_results.mat', 'hmm', 'mfcc_features');