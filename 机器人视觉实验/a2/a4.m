clc;clear;close all;
file_path = '../实验课数据/图像批处理/';
img_path = dir(strcat(file_path,'*.jpg'));
n = length(img_path);
I = cell(1, n);
for i = 1:n
    imageName = img_path(i).name;
    I{i} = imread(strcat(file_path, imageName));
    subplot(2,n,i);imshow(I{i});title(['原始图', num2str(i)]);
    I_r = I{i}(:,:,1);
    I_g = I{i}(:,:,2);
    I_b = I{i}(:,:,3);
    I_rb = I_r - I_b;
    Obj = im2bw(I_rb, 5/255);
    subplot(2,n,i+n);imshow(Obj);title(['分割后图', num2str(i)]);
end