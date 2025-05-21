clc;clear;close all;
image = im2double(imread('Fig_strawberries.tif'));
image1 = 1 - image;
subplot(1,2,1);
imshow(image);
title('original image');
subplot(1,2,2);
imshow(image1);
title('RGB complement')



