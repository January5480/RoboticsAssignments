clc; clear; close all;

% 读取并上传数据到GPU
I = imread('..\实验课数据\圆木\圆木4.jpg');
I_gpu = gpuArray(im2double(I));  % 转换为双精度并上传GPU

% 分离通道 (直接在GPU操作)
Ir = I_gpu(:,:,1);
Ig = I_gpu(:,:,2);
Ib = I_gpu(:,:,3);

% 显示部分需要gather回CPU
figure;
subplot(1,3,1), imshow(gather(Ir)), title('R通道');
subplot(1,3,2), imshow(gather(Ig)), title('G通道');
subplot(1,3,3), imshow(gather(Ib)), title('B通道');

% 直方图计算需返回CPU
figure;
subplot(1,3,1), imhist(gather(Ir)), title('R直方图');
subplot(1,3,2), imhist(gather(Ig)), title('G直方图');
subplot(1,3,3), imhist(gather(Ib)), title('B直方图');

% GPU二值化 (替代roicolor)
Ib_BW = (Ib >= 20/255) & (Ib <= 100/255);  % GPU逻辑索引

% 通道差值直接在GPU计算
I_rb = Ir - Ib;

% 修复二值化问题：使用显式计算阈值
% 注意：graythresh需要CPU数据，但二值化在GPU执行
T = graythresh(gather(I_rb));  % 在CPU计算阈值
I_rb_BW = I_rb >= T;           % 在GPU执行二值化

% GPU空洞填充
I_rb_BWfill = imfill(I_rb_BW, 'holes');

% 结果显示
figure;
subplot(2,2,1), imshow(gather(Ib_BW)), title('颜色范围选取');
subplot(2,2,2), imshow(gather(I_rb)), title('R-B通道');
subplot(2,2,3), imshow(gather(I_rb_BW)), title('二值图像');
subplot(2,2,4), imshow(gather(I_rb_BWfill)), title('空洞填充');

% 目标提取 (GPU计算)
Obj = I_gpu .* cast(I_rb_BWfill, 'like', I_gpu) * 1.2;

figure;
subplot(121), imshow(gather(I_gpu)), title('原始图像');
subplot(122), imshow(gather(Obj)), title('圆木提取');

% 圆木计数 (GPU加速版本)
Ir_gather = gather(Ir);  % imfindcircles需要CPU数据
[centers, radii] = imfindcircles(Ir_gather, [200 500], ...
    'ObjectPolarity', 'bright', ...
    'Sensitivity', 0.98, ...
    'Method', 'phasecode');  % 使用GPU加速方法

figure, imshow(Ir_gather);
h = viscircles(centers, radii);
num = length(centers);
title(['检测到圆木数量: ', num2str(num)]);
disp(['圆木数量: ', num2str(num)]);