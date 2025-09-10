clc;clear;close all;

% 开！！让大局逆转吧！！

[speechIn1,FS1] = audioread('Jan.wav');
[speechIn2,FS2] = audioread('Feb.wav');
[speechIn3,FS3] = audioread('Mar.wav');

speechIn1 = speechIn1 / max(abs(speechIn1));                        % 幅度归一化
speechIn2 = speechIn2 / max(abs(speechIn2));                        % 幅度归一化
speechIn3 = speechIn3 / max(abs(speechIn3));                        % 幅度归一化

wlen1 = round(0.025 * FS1); % 帧长为25毫秒
inc1 = round(0.02 * FS1); % 帧移为12.5毫秒
IS=0.1; overlap=wlen1-inc1;               % 设置IS
NIS1=fix((IS*FS1-wlen1)/inc1 +1);           % 计算NIS

wlen2 = round(0.025 * FS2); % 帧长为25毫秒
inc2 = round(0.02 * FS2); % 帧移为12.5毫秒
IS=0.1; overlap=wlen2-inc2;               % 设置IS
NIS2=fix((IS*FS2-wlen2)/inc2 +1);           % 计算NIS

wlen3 = round(0.025 * FS3); % 帧长为25毫秒
inc3 = round(0.02 * FS3); % 帧移为12.5毫秒
IS=0.1; overlap=wlen1-inc1;               % 设置IS
NIS3=fix((IS*FS3-wlen3)/inc3 +1);           % 计算NIS

fn1 = fix((length(speechIn1) - wlen1) / inc1) + 1; % 求帧数
fn2 = fix((length(speechIn2) - wlen1) / inc1) + 1;
fn3 = fix((length(speechIn3) - wlen1) / inc1) + 1;

% 计算每帧对应的时间
frameTime1=FrameTimeC(fn1, wlen1, inc1, FS1);
frameTime2=FrameTimeC(fn2, wlen2, inc2, FS2);
frameTime3=FrameTimeC(fn3, wlen3, inc3, FS3);

% 端点检测函数
[voiceseg1, ~, ~, ~, amp1, zcr1] = vad_TwoThr(speechIn1, wlen1, inc1, NIS1);
[voiceseg2, ~, ~, ~, amp2, zcr2] = vad_TwoThr(speechIn2, wlen1, inc1, NIS1);
[voiceseg3, ~, ~, ~, amp3, zcr3] = vad_TwoThr(speechIn3, wlen1, inc1, NIS1);

Segments1 = struct('startIdx', {}, 'endIdx', {});
for i = 1:length(voiceseg1)
    % 将帧索引转换为样本索引
    Segments1(i).startIdx = fix(frameTime1(voiceseg1(i).begin) * FS1);
    Segments1(i).endIdx = fix(frameTime1(voiceseg1(i).end) * FS1);    
end
Segments2 = struct('startIdx', {}, 'endIdx', {});
for i = 1:length(voiceseg2)
    % 将帧索引转换为样本索引
    Segments2(i).startIdx = fix(frameTime2(voiceseg2(i).begin) * FS2);
    Segments2(i).endIdx = fix(frameTime2(voiceseg2(i).end) * FS2);    
end
Segments3 = struct('startIdx', {}, 'endIdx', {});
for i = 1:length(voiceseg3)
    % 将帧索引转换为样本索引
    Segments3(i).startIdx = fix(frameTime3(voiceseg3(i).begin) * FS3);
    Segments3(i).endIdx = fix(frameTime3(voiceseg3(i).end) * FS3);    
end



% % 初始化 obs 结构体数组
obs = struct('fea', {}, 'segment', {});
for i = 1:length(voiceseg1)
    segment = speechIn1(Segments1(i).startIdx:Segments1(i).endIdx);
    obs(i).sph = segment;
    obs(i).fea = mfcc(segment);
    obs(i).segment = segment;
    speechSegments(1, i) = obs(i);
end

for i = 1:length(voiceseg2)
    segment = speechIn2(Segments2(i).startIdx:Segments2(i).endIdx);
    obs(i+length(voiceseg1)).fea = mfcc(segment);
    obs(i+length(voiceseg1)).segment = segment;
    speechSegments(2, i) = obs(i+length(voiceseg1));
end

for i = 1:length(voiceseg3)
    segment = speechIn3(Segments3(i).startIdx:Segments3(i).endIdx);
    obs(i+length(voiceseg1)+length(voiceseg2)).fea = mfcc(segment);
    obs(i+length(voiceseg1)+length(voiceseg2)).segment = segment;
    speechSegments(3, i) = obs(i+length(voiceseg1)+length(voiceseg2));
end

tic;

N = 4; % 状态数
M = [4, 4, 4, 4]; % 每个状态的混合模型成分数
% M = [1, 1, 1, 1];
% M = [2, 2, 2, 2];
% M = [3, 3, 3, 3];
% M = [4, 4, 4, 4];
% M = [6, 6, 6, 6];
% 初始化 HMM
hmm = struct('N', {}, 'M', {}, 'init', {}, 'trans', {}, 'mix', {});

% 训练 HMM
for d = 1:10 % 遍历每个数字
    for p = 1:2 % 遍历每个人
        fprintf('\n训练数字%d的hmm\n', d);
        hmm_temp = inithmm(speechSegments(p, d), N, M); % 初始化 HMM模型
        hmm{d} = baum_welch(hmm_temp, speechSegments(p, d)); % 迭代更新 HMM的各参数
    end
end
toc;
fprintf('运行时间: %f 秒\n', toc);
% for i = 1:length(tdata)  % 数字的循环
%     fprintf('\n计算数字%d的mfcc特征参数\n',i);
%     for k = 1:length(tdata{i})  % 样本数的循环
%       obs(k).sph = tdata{i}{k};  % 数字i的第k个语音
%       obs(k).fea = mfcc(obs(k).sph);  % 对语音提取mfcc特征参数
%     end
%     
%     fprintf('\n训练数字%d的hmm\n',i);
%     hmm_temp=inithmm(obs,N,M); %初始化hmm模型
%     hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
% end
% fprintf('\n训练完成！\n');









% 
% % 初始化一个结构体数组来存储每个语音段的起始和结束样本索引
% speechSegments = struct('startIdx', {}, 'endIdx', {});
% for i = 1:length(voiceseg)
%     % 将帧索引转换为样本索引
%     startIdx = fix(frameTime(voiceseg(i).begin) * FS1);
%     endIdx = fix(frameTime(voiceseg(i).end) * FS1);    
%     speechSegments(i).startIdx = startIdx;
%     speechSegments(i).endIdx = endIdx;
% end
% 
% % 定义 HMM 和 N
% N1 = 4; % 状态数
% M = [3, 3, 3, 3]; % 每个状态的混合模型成分数
% 
% 
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
% -----*32
% N = 4;   % hmm的状态数
% M = [3,3,3,3]; % 每个状态对应的混合模型成分数
% 
% for i = 1:length(tdata)  % 数字的循环
%     fprintf('\n计算数字%d的mfcc特征参数\n',i);
%     for k = 1:length(tdata{i})  % 样本数的循环
%       obs(k).sph = tdata{i}{k};  % 数字i的第k个语音
%       obs(k).fea = mfcc(obs(k).sph);  % 对语音提取mfcc特征参数
%     end
%     
%     fprintf('\n训练数字%d的hmm\n',i);
%     hmm_temp=inithmm(obs,N,M); %初始化hmm模型
%     hmm{i}=baum_welch(hmm_temp,obs); %迭代更新hmm的各参数
% end
% fprintf('\n训练完成！\n');

