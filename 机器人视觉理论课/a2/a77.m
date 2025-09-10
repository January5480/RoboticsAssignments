clc;clear;close all;
% 读取图像
img = imread('rice.png'); % 请替换为你自己的图像路径
% img_gray = rgb2gray(img); % 如果是彩色图像，转换为灰度图像

% 显示原始图像
figure;
subplot(1,4,1);
imshow(img);
title('Original Image');

% 进行傅里叶变换
F = fft2(double(img));  % 对图像进行傅里叶变换
F_shifted = fftshift(F);      % 将零频移到图像中心

% 显示傅里叶变换的幅度谱
magnitude_spectrum = log(1 + abs(F_shifted)); % 计算幅度谱
subplot(1,4,2);
imshow(magnitude_spectrum, []);
title('Magnitude Spectrum');

% 创建一个低通滤波器，滤掉高频部分
[rows, cols] = size(F_shifted);
center_x = round(rows / 2);
center_y = round(cols / 2);
radius = 30; % 控制低通滤波器的半径

% 创建一个滤波器，保留中心部分，去除高频部分
filter = zeros(rows, cols);
for i = 1:rows
    for j = 1:cols
        if (i - center_x)^2 + (j - center_y)^2 <= radius^2
            filter(i,j) = 1;
        end
    end
end

% 应用滤波器
F_filtered = F_shifted .* filter;

% 显示滤波后的傅里叶变换的幅度谱
magnitude_spectrum_filtered = log(1 + abs(F_filtered));
subplot(1,4,3);
imshow(magnitude_spectrum_filtered, []);
title('Filtered Magnitude Spectrum');

% 进行反傅里叶变换
F_iff = ifftshift(F_filtered);  % 将频谱恢复到原始位置
img_filtered = real(ifft2(F_iff)); % 对滤波后的频谱进行反傅里叶变换

% 显示滤波后的图像
% figure;
subplot(1,4,4);
imshow(uint8(img_filtered));
title('Filtered Image');
