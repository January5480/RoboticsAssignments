% ������֪��ͼ��ɷ�Ϊ�����֣�
% ��һ������245*512�ĺ�ɫ��
% �ڶ�������20*236�ĺ�ɫ+20*40�İ�ɫ+20*236�ĺ�ɫ
% ����������245*512�ĺ�ɫ
image1 = zeros(246,512);                %���ɵ�һ����
image2 = zeros(20,236);                 %���ɵڶ����ֵĺ�ɫ
image3 = ones(20,40);                   %���ɵڶ����ֵİ�ɫ
image4 = [image2 image3 image2];        %ƴ�ӵڶ�����
image5 = [image1;image4;image1];        %ƴ���������֣�image5��Ϊ��Ҫ���ɵ�ͼ��
imshow(image5);                         %չʾͼ��
imwrite(image5,'F:\dip\p1\test.bmp');   %����Ϊtest.bmp
I = imread('F:\dip\p1\test.bmp');       %��ͼ���ȡ������I��
imshow(I)
imwrite(image5,'F:\dip\p1\test.jpg')    %��ͼ�񱣴�Ϊjpg��ʽ
imwrite(image5,'F:\dip\p1\test.tif')    %��ͼ�񱣴�Ϊtif��ʽ
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
num = input('������һ��2���ݴΣ�');
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


