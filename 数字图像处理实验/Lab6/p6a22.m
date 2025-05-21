clc;clear;close all;
image = imread('Fig_strawberries.tif');
% imshow(image);
figure;
subplot(1,2,1);
imshow(image);
title('original image')
image1 = myRGB2HSI(image);
image6 = myHSI2RGB(image1);
subplot(1,2,2);
imshow(image6);
title('transformed image')
image2 = zeros(size(image1));

[x,y] = size(image1(:,:,1));
for i = 1:x
    for j = 1:y
        image2(i,j,3) = 1 -  image1(i,j,3);
        image2(i,j,2) = image1(i,j,2);
        if image1(i,j,1)<0.5
            image2(i,j,1) = image1(i,j,1) + 0.5;
        else
            image2(i,j,1) = image1(i,j,1) - 0.5;
        end
    end
end
a = image1(:,:,2);
disp(max(a(:)));
disp(min(a(:)));
figure;
h1 = histogram(a,100);
h1.FaceAlpha = 0.2;
b = image2(:,:,2);
disp(max(b(:)));
disp(min(a(:)));
hold on;
h2 = histogram(b,100);
h2.FaceAlpha = 0.2;
legend('original S','S');
title('S histogram comparison')
image3 = myHSI2RGB(image2);
figure;
subplot(1,2,1);
imshow(image);
title('original image');
subplot(1,2,2);
imshow(image3);
title('HSI complement')


function HSI = myRGB2HSI(RGB)
%   从RGB颜色空间向HSI颜色空间的转换
%   RGB(uint8):输入的RGB彩色图像
%   HSI(double):转换后的HSI彩色图像
img1_double = im2double(RGB);   % 转成double并作归一化处理
[r, c, k] = size(img1_double);
H = zeros(r, c);
S = zeros(r, c);
I = zeros(r, c);

for i = 1 : r
    for j = 1 : c
        % 分别获取R,G,B分量
        R = img1_double(i,j,1);
        G = img1_double(i,j,2);
        B = img1_double(i,j,3);
        fenzi = 0.5 * ( (R-G)+(R-B) );
        fenmu = sqrt( (R-G)^2 + (R-B)*(G-B) );
        % 易错点：分母需加上eps防止为0
        xita = acos( fenzi/(fenmu+eps) );
        if ( B<=G )
            HSI(i,j,1) = xita;
        else
            HSI(i,j,1) = 2*pi-xita;
        end
        HSI(i,j,1) = HSI(i,j,1) / (2*pi);  % H分量需要除以2*pi进行归一化
        min_value = min(min(R,G),B);
        % 易错点：分母需加上eps防止为0
        HSI(i,j,2) = 1 - ( 3/(R+G+B+eps) ) * min_value;
        HSI(i,j,3) = (R+G+B)/3;
    end
end
end


function RGB = myHSI2RGB(HSI)
% 从HSI颜色空间向RGB颜色空间的转换
% HSI(double):输入的HSI彩色图像
% RGB(uint8): 转换后的RGB彩色图像
HSI = im2double(HSI);
[r,c,k] = size(HSI);
RGB = zeros(r,c,k);
for i = 1 : r
    for j = 1 : c
        H = HSI(i,j,1)*2*pi;
        S = HSI(i,j,2);
        I = HSI(i,j,3);
        if ( H>=0 && H<2/3*pi)
            expression = S*cos( H )/(cos( pi/3-H ) + eps);
            RGB(i,j,1) = I * ( 1+expression );
            RGB(i,j,3) = I * (1-S);
            RGB(i,j,2) = 3*I - ( RGB(i,j,1)+RGB(i,j,3) );
        elseif ( H>=2/3*pi && H<4/3*pi)
            H = H-2*pi/3;
            RGB(i,j,1) = I * (1-S);
            expression = S*cos( H )/(cos( pi/3-H ) + eps);
            RGB(i,j,2) = I * ( 1+ expression );
            RGB(i,j,3) = 3*I - ( RGB(i,j,1)+RGB(i,j,2) );
        elseif (H>=4/3*pi && H<=2*pi)
            H = H-4*pi/3;
            RGB(i,j,2) = I * (1-S);
            expression = S*cos( H )/(cos( pi/3-H ) + eps);
            RGB(i,j,3) = I * ( 1+ expression );
            RGB(i,j,1) = 3*I - ( RGB(i,j,2)+RGB(i,j,3) );
        end
    end
end
RGB = RGB * 255;
RGB = uint8(RGB);
end

