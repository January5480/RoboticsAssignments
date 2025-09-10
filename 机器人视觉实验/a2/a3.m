clc; clear; close all;
I = imread('../实验课数据/图像批处理/1.jpg');
% subplot 121; imshow(I); title('初始图像');
% 取出三个通道
I_r = I(:,:,1); 
% subplot 221; imshow(I_r); title('r通道');
I_g = I(:,:,2);
% subplot 222; imshow(I_g); title('g通道');
I_b = I(:,:,3);
% subplot 223; imshow(I_b); title('b通道');

h1 = histogram(I_r);
hold on;
h2 = histogram(I_g);
hold on;
h3 = histogram(I_b);
h1.Normalization = 'probability';
h1.BinWidth = 5;
h2.Normalization = 'probability';
h2.BinWidth = 5;
h3.Normalization = 'probability';
h3.BinWidth = 5;
h1(1).FaceAlpha = 0.15;
h2(1).FaceAlpha = 0.15;
h3(1).FaceAlpha = 0.15;
legend('r通道','g通道','b通道');
title('三个通道的灰度分布直方图')
% I_rg = I_r - I_g;
% subplot 224; imshow(I_rb); title('r-b');
% histogram(I_rg(:)); title('I\_rb的灰度分布直方图')
% figure;
% Obj = im2bw(I_rg, 1/255);
% subplot 141; imshow(Obj); title('阈值为1/255');
% sum(Obj(:))
% Obj = im2bw(I_rg, 2/255);
% subplot 142; imshow(Obj); title('阈值为2/255');
% sum(Obj(:))
% Obj = im2bw(I_rg, 3/255);
% subplot 143; imshow(Obj); title('阈值为3/255');
% sum(Obj(:))
% Obj = im2bw(I_rg, 4/255);
% subplot 144; imshow(Obj); title('阈值为4/255');
% sum(Obj(:))