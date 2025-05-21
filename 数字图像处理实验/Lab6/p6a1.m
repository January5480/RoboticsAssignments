clc;clear;close all;
image1 = im2double(imread('picker_phantom.tif'));
image2 = im2double(imread('weld-original.tif'));
image3 = im2double(imread('tropical_rain_grayscale.tif'));

intensity_slicing(image1,8)
intensity_slicing(image2,3)
intensity_slicing(image3,20)

function intensity_slicing(image1,r)
sp1 = (max(image1(:)) - min(image1(:)))/r;
range1 = zeros(r,2);
for i = 1:r
    range1(i,1) = sp1*(i-1);
    range1(i,2) = sp1*i;
end
colorPalette1 = lines(r); %可以生成r个颜色

numColors = 64; % 比需要的数量多一些
colorPaletteFull = lines(numColors);
% 等距采样 8 个颜色
% r = 8;
indices = round(linspace(1, numColors, r));
colorPalette2 = colorPaletteFull(indices, :);

% r = 8;
linesColors = lines(r);
parulaColors = parula(r);
% 平均两种调色板
colorPalette3 = (linesColors + parulaColors) / 2;

[x1,y1] = size(image1);
image11 = zeros(x1,y1,3);	
image22 = zeros(x1,y1,3);
image33 = zeros(x1,y1,3);
% imshow(image11)
for i = 1:x1
    for j = 1:y1
        for k = 1:r
            if image1(i,j)>range1(k,1)&&image1(i,j)<range1(k,2)
                image11(i,j,:) = colorPalette1(k,:,:);
                image22(i,j,:) = colorPalette2(k,:,:);
                image33(i,j,:) = colorPalette3(k,:,:);
                break;
            end
        end
    end
end
figure;
subplot(2,2,1);
imshow(image1);
title('original image');
subplot(2,2,2);
imshow(image11)
title('intensity slicing1');
subplot(2,2,3);
imshow(image22)
title('intensity slicing2');
subplot(2,2,4);
imshow(image33)
title('intensity slicing3');
end