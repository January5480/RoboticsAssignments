clc;clear;close all;
image = imread("D:\Desktop\dip\Lab3\IMAGES\woman.tif");
subplot(1,3,1);
imshow(image);
title('original image');
subplot(1,3,2);
imshow(FlipImage(image,0))
title('flip vertically')
subplot(1,3,3);
imshow(FlipImage(image,1))
title('flip horizontally')