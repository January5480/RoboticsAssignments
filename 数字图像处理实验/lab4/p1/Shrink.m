function [ image2 ] = Shrink( image,factor )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
image2_x = size(image,1)/factor;
image2_y = size(image,2)/factor;
image2 = zeros(image2_x,image2_y);
for i = 1:image2_x
    for j = 1:image2_y
        image3 = image((i-1)*factor+1:i*factor,(j-1)*factor+1:j*factor);
        image2(i,j) = mean(mean(image3));
    end
end
end

