clc;clear;close all;
image = imread('Fig0637(a)(caster_stand_original).tif');
image1 = myRGB2HSI(image);
H = image1(:,:,1);
S = image1(:,:,2);
I = image1(:,:,3);
S = S + 0.2;
subplot(2,2,1), imshow(image), title('original image',FontName='Times New Roman');
subplot(2,2,2), imhist(I(:)), title('Intensity histogram',FontName='Times New Roman');
[row,col] = size(I);
R = round(I*255);
% figure;
% imshow(R)
PMF = zeros(1, 256); 
for i = 1:row
    for j = 1:col
        PMF(R(i,j) + 1) = PMF(R(i,j) + 1) + 1; 
    end
end
PMF = PMF / (row * col);
CDF = zeros(1,256);
CDF(1) = PMF(1);
for i = 2:256
    CDF(i) = CDF(i - 1) + PMF(i);
end
Sk = zeros(1,256);
for i = 1:256
    Sk(i) = CDF(i) * 255;
end
Sk = round(Sk);
for i = 1:row
    for j = 1:col
        R(i,j) = Sk(R(i,j) + 1);
    end
end
R = R/255;

% figure;
image2 = ones(size(image));
image2(:,:,1) = H;
image2(:,:,2) = S;
image2(:,:,3) = R;
image3 = myHSI2RGB(image2);
% imshow(image3);
% title('I Histogram Equalization + increase S',FontName='Times New Roman')
% image4 = image3 - image;
% figure;
% imshow(image4)
% title('diffrerence after Histogram Equalization + increase S',FontName='Times New Roman')
% figure;
% II = image4(:,:,3);
% histogram(II);
% title('diffrerence after Histogram Equalization',FontName='Times New Roman')
subplot(2,2,3), imshow(image3), title('after Histogram Equalization',FontName='Times New Roman');
subplot(2,2,4), imhist(R(:)), title('intensity Histogram Equalization',FontName='Times New Roman');

figure;
h1 = histogram(I);
hold on;
h2 = histogram(R);
h1.FaceAlpha = 0.2;
h2.FaceAlpha = 0.2;
legend('original intensity','intensity Histogram Equalization');
title('intensity difference',FontName='Times New Roman')
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
% HSI = im2double(HSI);
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


