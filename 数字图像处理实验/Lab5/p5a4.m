clc;clear;close all;
image1 = imread('top_ left_flower.tif');
image1 = im2double(image1);
r1 = image1(:,:,1);
r2 = image1(:,:,2);
r3 = image1(:,:,3);
image2 = (r1+r2+r3)/3;
% subplot(1,2,1);
% imshow(image1);
% title('colorful image');
subplot(1,2,1);
imshow(image2);
title('gray image');
subplot(1,2,2);
r1_pro = 0.05;
r2_pro = 0.9;
r3_pro = 0.05;
image3 = r1_pro*r1 + r2_pro*r2 + r3_pro*r3;
imshow(image3)
title(['Adjust the proportion ',num2str(r1_pro),'+',num2str(r2_pro),'+',num2str(r3_pro)]);
figure;
image4 = image2 - image3;
imshow(image4);
image5 = 1 - image4;
title('difference between two image')
figure;
imshow(image5);
title('negative difference between two image')