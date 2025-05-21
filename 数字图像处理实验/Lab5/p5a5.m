clc;clear;close all;
image1 = imread('Fig_strawberries.tif');
image1 = im2double(image1);
figure;
subplot(1,2,1);
imshow(image1)
title('original image');
image2 = 0.7*image1;
subplot(1,2,2);
imshow(image2)
title('RGB suppress');
image3 = 0.7*image1 + 0.3;
% image3 = (1 - image1)*0.7;
% image3 = 1 - image3;
figure;
subplot(1,2,1);
image4 = 1 - image1;
imshow(image1)
title('original image');
subplot(1,2,2);
imshow(image3);
title('CMY suppress');