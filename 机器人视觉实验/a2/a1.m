clc;clear;close all;
% 指定图像文件夹路径
file_path = '..\实验课数据\图像批处理\';
% 获取该文件夹中所有jpg格式的图像
img_path_list = dir(strcat(file_path,'*.jpg'));
img_num = length(img_path_list);
if img_num > 0
    for j = 1:img_num
        img_name = img_path_list(j).name; %逐一读取图像名字
        image = imread(strcat(file_path, img_name)); %拼接路径
        subplot(2,3,j);
        imshow(image);
        title(['图像', num2str(j)]);
    end
end