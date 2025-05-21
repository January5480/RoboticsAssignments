clc;clear;close all;
image1 = imread("D:\Desktop\dip\Lab3\IMAGES\darkPollen.jpg");
image2 = imread("D:\Desktop\dip\Lab3\IMAGES\lightPollen.jpg");
image3 = imread("D:\Desktop\dip\Lab3\IMAGES\lowContrastPollen.jpg");
image4 = imread("D:\Desktop\dip\Lab3\IMAGES\pollen.jpg");
subplot(2,2,1);
h1 = generateHistogram(image1);
title('original darkPollen');
subplot(2,2,2);
h2 = generateHistogram(image2);
title('original lightPollen');
subplot(2,2,3);
h3 = generateHistogram(image3);
title('original lowContrastPollen');
subplot(2,2,4);
h4 = generateHistogram(image4);
title('original pollen');
figure;
imhist(image4)
