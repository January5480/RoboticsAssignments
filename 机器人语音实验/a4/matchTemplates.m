clear all;
close all;
ncoeff = 12;          %MFCC参数阶数
N = 10;               %10个数字
fs=16000;             %采样频率
duration2 = 2;        %录音时长

k = 3;                %训练样本的人数

correct = 0;
for i = 1 : 3
    for j = 0: 9
        [speechIn,FS1] = audioread(['./SpeechData/p' num2str(i) '/' num2str(j) '.wav']);
        speechIn = my_vad(speechIn);                    %端点检测
        rMatrix1 = mfccf(ncoeff,speechIn,fs);            %采用MFCC系数作为特征矢量
        rMatrix = CMN(rMatrix1);                         %归一化处理

        Sco = DTWScores(rMatrix,N);                      %计算DTW值
        [SortedScores,EIndex] = sort(Sco,2);             %按行递增排序，并返回对应的原始次序
        Nbr = EIndex(:,1:2)                              %得到每个模板匹配的2个最低值对应的次序

        [Modal,Freq] = mode(Nbr(:));                      %返回出现频率最高的数Modal及其出现频率Freq
        if Modal == j + 1
            correct = correct + 1;
        end
    end
end
correct / 30

% correct = 0;
% for j = 0: 9
%     [speechIn,FS1] = audioread(['./Mar/Marker '  num2str(j) '.wav']);
%     speechIn = my_vad(speechIn);                    %端点检测
%     rMatrix1 = mfccf(ncoeff,speechIn,fs);            %采用MFCC系数作为特征矢量
%     rMatrix = CMN(rMatrix1);                         %归一化处理
% 
%     Sco = DTWScores(rMatrix,N);                      %计算DTW值
%     [SortedScores,EIndex] = sort(Sco,2);             %按行递增排序，并返回对应的原始次序
%     Nbr = EIndex(:,1:2)                              %得到每个模板匹配的2个最低值对应的次序
% 
%     [Modal,Freq] = mode(Nbr(:));                      %返回出现频率最高的数Modal及其出现频率Freq
%     if Modal == j + 1
%         correct = correct + 1;
%     end
% end
% correct / 10


