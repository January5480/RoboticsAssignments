clc;clear;close all;
image1 = imread('Saved Pictures/e75cf81bc51138808609399b4d5120c.jpg');
for i = 1:4
    subplot(2,2,i);
    subimage(image1)
end
figure;
for i = 1:4
    subplot(2,2,i);
    imshow(image1)
end
