clc;clear;close all;
img = imread('焊缝3.jpg');
subplot(221)
imshow(img); title('原图像');
img_r=img(:,:,1);
img_g=img(:,:,2);
img_b=img(:,:,3);
img_br=img_b-img_r;
img_br_bin=imbinarize(img_br,1/255);
subplot(222);
imshow(img_br_bin);title('二值化后图像');
img_br_bin_bwar = bwareaopen(img_br_bin, 5000);% 去除面积小于5000对象
subplot(223);
imshow(img_br_bin_bwar);title('从对象中移除小对象');
se = strel('disk', 400, 4);
img_br_bin_bwar_close = imclose(img_br_bin_bwar, se);
subplot(224);
imshow(img_br_bin_bwar_close);title('腐蚀与膨胀结果');
im4 = bwfill(img_br_bin_bwar_close, 'holes');
subplot(224);
imshow(im4); title('填充空白区域');
im1 = uint8(img_br_bin_bwar_close) .* img;
figure;
subplot(221);
imshow(img); title('原图像');
subplot(222);
imshow(im1);title('焊缝提取结果图');



