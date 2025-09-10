clc;clear;close all;
image = imread('rice.png');
subplot(1,2,1);imshow(image);title('原始图像');
O = graythresh(image);
BW1 = im2bw(image,O);
subplot(1,2,2);imshow(BW1);title('分割后图像');