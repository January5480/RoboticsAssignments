clc;clear;close all;
image = imread('Fig_test_pattern_blurring_orig.tif');
image = im2double(image);
subplot(2,3,1);
imshow(image)
title('original image');
w = [3,5,9,15,35]; %定义w为每个fliter的维数
x = size(image,1);
y = size(image,2);
for k = 1:5
    subplot(2,3,k+1);   
    stp = (w(k)+1)/2; %定义stp为每次w的步长
    f1 = ones(w(k),w(k));
    for i=stp:x-stp+1        
        for j = stp:y-stp+1           
            s1 = image(i-stp+1:i+stp-1,j-stp+1:j+stp-1).* f1;
            image(i,j) = sum(s1(:))/(w(k)*w(k));
        end
    end
    imshow(image)
    title(sprintf('make size:%d*%d',w(k),w(k)))
end

