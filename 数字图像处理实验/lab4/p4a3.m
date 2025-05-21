clc;clear;close all;
image = imread('ckt_board_saltpep.tif');
image = im2double(image);
subplot(1,3,1);imshow(image);title('original image');
[x,y] = size(image);
image1 = zeros(size(image));
image2 = zeros(size(image));
for i=2:x-1
    for j = 2:y-1 
        s1 = image(i-1:i+1,j-1:j+1);
        image1(i,j) = mean(s1(:));
        image2(i,j) = median(s1(:));
    end
end
subplot(1,3,2);imshow(image1);title('average filter');
subplot(1,3,3);imshow(image2);title('median filter');
figure;
imshow(image2);title('median filter');