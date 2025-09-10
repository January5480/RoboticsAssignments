clc;clear; close all;
% 批量读取图像的一种简单方法：用元胞数组
file_path = '..\实验课数据\图像批处理\';
img_path_list = dir(strcat(file_path,'*.jpg'));
n = length(img_path_list);
I = cell(1, n);
for i = 1 : n
    imageName = img_path_list(i).name;
    I{i} = imread(strcat(file_path,imageName));
    subplot(2,3,i);
    imshow(I{i});
    title(['图像',num2str(i)]);
end
