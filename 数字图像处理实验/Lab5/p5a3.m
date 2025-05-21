clc;clear;close all;
image1 = imread('ckt-board-orig.tif');
image1 = im2double(image1);
image2 = imnoise(image1,'salt & pepper',0.25);
imshow(image2);
title('impulse noise where P_a = P_b = 0.25');
[x,y] = size(image2);
image3 = zeros(x,y);
% 3*3的窗口
for i=4:x-3
    for j = 4:y-3
        s1 = image2(i-1:i+1,j-1:j+1);
        % 中值的最大值:0.9765，最小值:0
        med = median(s1(:));
        if med>0&&med<0.9765
            if image2(i,j)>0&&image2(i,j)<0.9765
                image3(i,j) = image2(i,j);
            else
                image3(i,j) = med;
            end
            continue;
        end
        %是噪音，扩大窗口
        image3(i,j) = expand_windows(image2,i,j,3);
    end
end
figure;
imshow(image3);
title('adaptive median filter with maximum size=7*7');

function image_i_j = expand_windows(image2,i,j,w)
flag = 0;
w = w + 2;
s2 = image2(i-(w-1)/2:i+(w-1)/2,j-(w-1)/2:j+(w-1)/2);
med = median(s2(:));
if med>0&&med<0.9765    
    if image2(i,j)>0&&image2(i,j)<0.9765
        image_i_j = image2(i,j);
    else
        image_i_j = med;
    end
else
    w = w + 2;
    s2 = image2(i-(w-1)/2:i+(w-1)/2,j-(w-1)/2:j+(w-1)/2);
    med = median(s2(:));
    if med>0&&med<0.97
        flag = 1;
        if image2(i,j)>0&&image2(i,j)<0.97
            image_i_j = image2(i,j);
        else
            image_i_j = med;
        end        
    end
    if ~flag
        image_i_j = image2(i,j);
    end
end
end