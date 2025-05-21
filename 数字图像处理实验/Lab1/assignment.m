% 分析可知，图像可分为三部分，
% 第一部分是245*512的黑色，
% 第二部分是20*236的黑色+20*40的白色+20*236的黑色
% 第三部分是245*512的黑色
image1 = zeros(246,512);                %生成第一部分
image2 = zeros(20,236);                 %生成第二部分的黑色
image3 = ones(20,40);                   %生成第二部分的白色
image4 = [image2 image3 image2];        %拼接第二部分
image5 = [image1;image4;image1];        %拼接三个部分，image5即为需要生成的图像
imshow(image5);                         %展示图像
imwrite(image5,'F:\dip\p1\test.bmp');   %保存为test.bmp
I = imread('F:\dip\p1\test.bmp');       %将图像读取到变量I中
imshow(I)
imwrite(image5,'F:\dip\p1\test.jpg')    %将图像保存为jpg格式
imwrite(image5,'F:\dip\p1\test.tif')    %将图像保存为tif格式
image6 = 1 - image5;
% imshow(image6)
image7 = imread('F:\dip\p1\Fig_blurry_moon.tif');
image8 = 255 - image7;
% imshow(image8)
image9 = imread('F:\dip\p1\Fig_rose.tif');
image10 = Shrink(image9,16);
image11 = image10/255;
% imshow(image11)
image12 = Zoom(image11,16);
% imshow(image12);
num = input('请输入一个2的幂次：');
image13 = imread('F:\dip\p1\Fig_ctskull-256.tif');
image14 = trans_greyIntensity(image13 ,num);
% image15 = trans_greyIntensity(image13 ,64);
% image16 = trans_greyIntensity(image13 ,32);
% image17 = trans_greyIntensity(image13 ,16);
% image18 = trans_greyIntensity(image13 ,8);
% image19 = trans_greyIntensity(image13 ,4);
% image20 = trans_greyIntensity(image13 ,2);
% figure;
% subplot(2,4,1);
% imshow(image13),title('L=256');
% subplot(2,4,2);
% imshow(image14),title('L=128');
% subplot(2,4,3);
% imshow(image15),title('L=64');
% subplot(2,4,4);
% imshow(image16),title('L=32');
% subplot(2,4,5);
% imshow(image17),title('L=16');
% subplot(2,4,6);
% imshow(image18),title('L=8');
% subplot(2,4,7);
% imshow(image19),title('L=4');
% subplot(2,4,8);
% imshow(image20),title('L=2');
% 
% 
% 
% 
% 
% 


