clc;clear;close all;

[speechIn1,FS1] = audioread('Jan.wav');
[speechIn2,FS2] = audioread('Feb.wav');
[speechIn3,FS3] = audioread('Mar.wav');

speechIn1 = speechIn1 / max(abs(speechIn1));                        % 幅度归一化
speechIn2 = speechIn2 / max(abs(speechIn2));                        % 幅度归一化
speechIn3 = speechIn3 / max(abs(speechIn3));                        % 幅度归一化
N1 = length(speechIn1);                            % 取信号长度
time=(0:N1-1)/FS1;  
wlen = round(0.025 * FS1); % 帧长为25毫秒
inc = round(0.02 * FS1); % 帧移为12.5毫秒
IS=0.1; overlap=wlen-inc;               % 设置IS
NIS=fix((IS*FS1-wlen)/inc +1);           % 计算NIS
fn=fix((N1-wlen)/inc)+1;                 % 求帧数
frameTime=FrameTimeC(fn, wlen, inc, FS1);% 计算每帧对应的时间
[voiceseg,vsl,SF,NF,amp,zcr]=vad_TwoThr(speechIn1,wlen,inc,NIS);  % 端点检测
% 初始化一个结构体数组来存储每个语音段的起始和结束样本索引
speechSegments = struct('startIdx', {}, 'endIdx', {});
for i = 1:length(voiceseg)
    % 将帧索引转换为样本索引
    
    startIdx = fix(frameTime(voiceseg(i).begin) * FS1);
    endIdx = fix(frameTime(voiceseg(i).end) * FS1);    
    speechSegments(i).startIdx = startIdx;
    speechSegments(i).endIdx = endIdx;
    fprintf('数字 %d 对应的语音段从样本 %d 到 %d\n', i, speechSegments(i).startIdx, speechSegments(i).endIdx);
end

% 定义 HMM 和 N
N1 = 4; % 状态数
M = [3, 3, 3, 3]; % 每个状态的混合模型成分数


% obs = struct('fea', {}, 'segment', {}); 
% for i = 1:length(speechSegments)
%     
%     segment = speechIn1(speechSegments(i).startIdx:speechSegments(i).endIdx);
%     % 初始化 obs 结构体数组
% 
%     for k = 1:3  % 样本数的循环
%       obs(k).sph = tdata{i}{k};  % 数字i的第k个语音
%       obs(k).fea = mfcc(obs(k).sph);  % 对语音提取mfcc特征参数
%     end
%        
%     obs(i).fea = mfcc(segment);
% %     obs(i).segment = segment;
%     % 调用 inithmm 函数
% %     hmm = inithmm(obs, N, M);
%     fprintf('\n训练数字%d的hmm\n',i);
%     disp(length(obs));
%     hmm_temp=inithmm(obs,N1,M); %初始化hmm模型
%     hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
%     
% 
% end