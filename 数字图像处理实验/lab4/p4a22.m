clc;clear;close all;
image = imread("embedded_square_noisy.tif");
subplot(2,2,1);imshow(image);title('original image');
subplot(2,2,2), imhist(image(:)), title('original histogram');
image1 = image;
kk = 1:3:512; %按照实验要求，每三个像素移动一次
size(kk,2)
for ii = 1:size(kk,2)-1
    disp(ii)
    for jj = 1:size(kk,2)-1
        R = image(kk(ii):kk(ii)+2,kk(jj):kk(jj)+2);
        [row, col] = size(R);        
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
        %按照实验要求，直接替换掉之前的
        image1(kk(ii):kk(ii)+2,kk(jj):kk(jj)+2) = R;
    end
end
subplot(2,2,3);imshow(image1);title('Local histogram')
subplot(2,2,4), imhist(image1(:)), title('Local histogram');
figure;
imshow(image1)
title('Local histogram')
