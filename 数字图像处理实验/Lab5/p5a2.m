clc;clear;close all;
image1 = imread('ckt-board-orig.tif');
image1 = im2double(image1);
image2 = imnoise(image1,'salt & pepper',0.1);
subplot(1,2,1);
imshow(image2);
title('impulse noise p_a=p_b=0.1')
[x,y] = size(image2);
image3 = zeros(size(image1));
for i=3:x-2
    for j = 3:y-2 
        s1 = image2(i-2:i+2,j-2:j+2);        
        image3(i,j) = median(s1(:));
    end
end
subplot(1,2,2);
imshow(image3)
title('5*5 average filter')
image3 = imnoise(image2,'gaussian',0,0.01);
imshow(image3)
title('impulse + gaussian noise')
