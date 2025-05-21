function [image2] = thresholdImage(image,ave)
%生成与image大小相等的零矩阵
image2 = ones(size(image,1),size(image,2)); 
%大于阈值的置1
image2(image < ave)= 0; 
end