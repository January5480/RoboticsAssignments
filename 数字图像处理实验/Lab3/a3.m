clc;clear;close all;

% R = imread("D:\Desktop\dip\Lab3\IMAGES\darkPollen.jpg");
% R = imread("D:\Desktop\dip\Lab3\IMAGES\lightPollen.jpg");
R = imread("D:\Desktop\dip\Lab3\IMAGES\lowContrastPollen.jpg");
% R = imread("D:\Desktop\dip\Lab3\IMAGES\pollen.jpg");
[row, col] = size(R);
subplot(2,2,1), imshow(R), title('original image');
subplot(2,2,2), imhist(R(:)), title('original histogram');
R1 = R;
PMF = zeros(1, 256); 
for i = 1:row
    for j = 1:col
        PMF(R(i,j) + 1) = PMF(R(i,j) + 1) + 1; 
    end
end
PMF = PMF / (row * col);
CDF = zeros(1,256);
CDF(1) = PMF(1);
for i = 2:256
    CDF(i) = CDF(i - 1) + PMF(i);
end
Sk = zeros(1,256);
for i = 1:256
    Sk(i) = CDF(i) * 255;
end
Sk = round(Sk);
for i = 1:row
    for j = 1:col
        R(i,j) = Sk(R(i,j) + 1);
    end
end
subplot(2,2,3), imshow(R), title('Histogram Equalization');
subplot(2,2,4), imhist(R(:)), title('Histogram Equalization');
figure;
h1 = histogram(R1(:));
h1.FaceAlpha = 0.3;
hold on;
h2 = histogram(R(:));
h2.FaceAlpha = 0.3;
title('lowContrastPollen.jpg')
legend('original image','after Histogram Equalization')
