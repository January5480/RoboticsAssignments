clc;clear;close all;
image = imread("Fig_blurry_moon.tif");
image = im2double(image);
imshow(image);title('original image');
[x,y] = size(image);
image1 = ones(size(image));
image2 = ones(size(image));
f1 = [0,-1,0;-1,5,-1;0,-1,0];
f2 = [-1,-1,-1;-1,9,-1;-1,-1,-1];
for i=2:x-1
    for j = 2:y-1
        s1 = image(i-1:i+1,j-1:j+1).* f1;
        image1(i,j) = sum(s1(:));         
    end
end
figure;
imshow(image1);title('f1 image');
for i=2:x-1
    for j = 2:y-1
        s1 = image(i-1:i+1,j-1:j+1).* f2;
        image2(i,j) = sum(s1(:));         
    end
end
figure;
imshow(image2);title('f2 image');