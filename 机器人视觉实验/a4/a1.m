close all;
clear all;
clc;
% 获取文件列表
file_list= dir('../实验课数据/碎纸片拼接/*.bmp');
% file_list= dir('../实验课数据/校徽拼接/*.png');
if size(file_list,1)>0
    image_list = {file_list.name};
else
    error('no image')
end
file_num=size(image_list,2);
score=zeros(1,file_num);
feature=cell(1,file_num);
% 计算碎片特征
for ind=1:file_num
    filename=cell2mat(image_list(ind));
    filename = ['../实验课数据/碎纸片拼接/'  filename];
%     filename = ['../实验课数据/校徽拼接/'  filename];
    a=imread(filename);
    [row,col,len]=size(a);
    a_d=double(a);
    f =a_d(:,1)';
    tmp1=f.*f;
    tmp2=sqrt( sum(tmp1) );
    f =f/tmp2;
    one.left=f;
    one.left_std=std(f);
    f =a_d(:,end)';
    tmp1=f.*f;
    tmp2=sqrt( sum(tmp1) );
    f =f/tmp2;
    one.right=f;
    one.right_std=std(f);
    feature{ind}=one;
end
% 计算碎块的相似性矩阵
score_left=zeros(file_num,file_num);
score_right=zeros(file_num,file_num);
std_thr=0.001;
for y=1:file_num % compare
    for x=1:file_num
        if y==x
            continue;
        end
        score_left(y,x)=feature{y}.left*feature{x}.right';
        score_right(y,x)=feature{y}.right*feature{x}.left';
        if feature{y}.left_std<std_thr
            score_left(y,x)=0;
        end
        if feature{y}.right_std<std_thr
            score_right(y,x)=0;
        end
    end
end
%% 计算块间相似性
order=[1];
order_left=2:file_num; % order%第一个保证前后都有对象
while 1
    order
    if isempty(order_left)
        break;
    end
    left=order(1);right=order(end);
    score=score_left(left,:);
    [c,i]=max(score);
    if c(1)>0.95 && any(order_left==i(1))
        order=[i order];
        order_left(order_left==i(1))=[];
    end
    score=score_right(right,:);
    [c,i]=max(score);
    if c(1)>0.95 && any(order_left==i(1))
        order=[order i];
        order_left(order_left==i(1))=[];
    end
end
%% 拼接
b=[];
for ind=1:file_num % 拼接
    filename=cell2mat(image_list(order(ind)));
    filename = ['../实验课数据/碎纸片拼接/'  filename];
%     filename = ['../实验课数据/校徽拼接/'  filename];
    a=imread(filename);
    [row,col,len]=size(a);
    b=[b a];
end
subplot 121;
imshow(b)
title('拼接后的图像')

%% 原图像
order=(1:19);
b = [];
for ind=1:file_num % 拼接
    filename=cell2mat(image_list(order(ind)));
    filename = ['../实验课数据/碎纸片拼接/'  filename];
%     filename = ['../实验课数据/校徽拼接/'  filename];
    a=imread(filename);
    [row,col,len]=size(a);
    b=[b a];
end
subplot 122;
imshow(b)
title('碎图像')