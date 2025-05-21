clc;clear;close all;
image1 = imread('ckt-board-orig.tif');
image1 = im2double(image1);
subplot(1,2,1);
imshow(image1);
title('original image');
image2 = imnoise(image1,'gaussian',0,0.01);
subplot(1,2,2);
imshow(image2)
title('gaussian noise image');
image3 = imnoise(image1,'salt & pepper',0.1);
figure;
subplot(1,2,1);
imshow(image1);
title('original image')
subplot(1,2,2);
imshow(image3)
title('impulse noise image');
