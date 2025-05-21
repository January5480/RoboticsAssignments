clc;clear;close all;
image1 = imread('ckt-board-orig.tif');
image1 = im2double(image1);
image2 = imnoise(image1,'salt & pepper',0.1);
image3 = imnoise(image2,'gaussian',0,0.01);
% imshow(image3);
% title('impulse noise p_a=p_b=0.1 and gaussian noise m=0,var=0.01');
[x,y] = size(image2);
image4 = zeros(size(image1));   % Arithmetic Mean Filter, 
image5 = ones(size(image1));   % Geometric Mean Filter
image6 = zeros(size(image1));   % Median Filter 
image7 = zeros(size(image1));   % Alpha-trimmed mean filter
alpha1 = 6;
for i=3:x-2
    for j = 3:y-2 
        s1 = image2(i-2:i+2,j-2:j+2);
        image4(i,j) = mean(s1(:));
        image5(i,j) = prod(s1(:)).^(1/25);
        image6(i,j) = median(s1(:));
        s1_sorted = sort(s1);
        image7(i,j) = mean(s1_sorted(1+alpha1:25-alpha1));
    end
end
% figure;
% imshow(image4)
% title('5*5 Arithmetic Mean Filter')
% figure;
% imshow(image5)
% title('5*5 Geometric Mean Filter')
figure;
imshow(image6)
title('5*5 Median Filter ')
figure;
imshow(image7)
title(['5*5 Alpha-trimmed mean filter where alpha = ',num2str(alpha1)])
image8 = image6-image7;
image9 = 1 - (image6-image7);
figure;
imshow(image8);
title(['difference between two Filter where alpha=',num2str(alpha1)])
figure;
h1 = histogram(image6(:));
h1.FaceAlpha = 0.3; %调整透明度
h1.Normalization = 'probability';
hold on;
h2 = histogram(image7(:));
h2.FaceAlpha = 0.3; %调整透明度
h2.Normalization = 'probability';
legend('Median Filter','Alpha-trimmed mean filter')
title('histogram difference between two Filters');
figure;
imshow(image9);
title(['difference between two Filter where alpha=',num2str(alpha1)])
