clc;clear;close all;
image1 = imread('pout.tif');
image1 = im2double(image1);
a = 1;b = 0;
image2 = image1*a + b;
a = 1;b = 30;
image3 = image1*a + b/255;
a = 1;b = -70;
image4 = image1*a + b/255;
a = 1.5;b = 0;
image5 = image1*a + b;
a = 0.7;b = 0;
image6 = image1*a + b;
subplot(2,3,1);
imshow(image1);
title('original image');
subplot(2,3,2);
imshow(image2);
title('a = 1,b = 0');
subplot(2,3,3);
imshow(image3);
title('a = 1,b = 30')
subplot(2,3,4);
imshow(image4);
title('a = 1,b = -70')
subplot(2,3,5);
imshow(image5);
title('a = 1.5,b = 0')
subplot(2,3,6);
imshow(image6);
title('a = 0.7,b = 0')