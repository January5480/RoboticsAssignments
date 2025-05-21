% clc;clear;close all;
% image1 = imread("D:\Desktop\dip\lab2\IMAGES\Fig_blurry_moon.tif");
% aver = averageIntensity(image1);
% image2 = thresholdImage(image1,aver);
% imshow(image2)
% % c = 0.0001;r = 0.4;
% % subplot(1,2,1)
% % imshow(image1);
% % title('original');
% % image2 = c*double(image1).^r;
% % factor = 255/(max(image2(:))-min(image2(:)));
% % image2 = uint8((image2-min(image2(:))) * factor);
% % subplot(1,2,2)
% % imshow(image2)
% % title(['c = ',num2str(c),'  r = ',num2str(r)])
% % subplot(1,2,2)
% % image3 = uint8(image2);
% % imshow(image3);
% % K = 0.1:0.1:1;
% % for i=1:6
% %     image2 = K(i)*log10(double(image1)+1);
% %     subplot(2,3,i);
% %     imshow(image2);
% %     title(['c = ' num2str(K(i))]);
% % end

% 读取图像
image = imread("D:\Desktop\dip\lab2\IMAGES\Fig_fractured_spine.tif");
% 将图像转换为双精度格式以便计算
image = double(image);
% 定义对数变换公式的参数 c 的5个值
c_values = [0.03, 1, 2, 5,50];
% 初始化存储结果的图像数组
transformed_images = cell(1, length(c_values));
% 对每个 c 值进行对数变换
for i = 1:length(c_values)
c = c_values(i);
% 应用对数变换公式 s = c * log(1 + r)
transformed_images{i} = c * log10(1 + image);
% transformed_images{i}=mat2gray(transformed_images{i});
end
% 显示原始图像和增强后的图像进行比较
figure;
subplot(2, 3, 1);
imshow(image, []);
title('Original Image');
% 显示每个 c 值对应的增强图像
for i = 1:length(c_values)
subplot(2, 3, i+1);
imshow(transformed_images{i}, []);
title(['Enhanced Image, c = ', num2str(c_values(i))]);
end