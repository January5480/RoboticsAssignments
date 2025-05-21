function [image1] = FlipImage(image,flag)
% flag 为1表示水平翻转，flag为0表示垂直翻转
if flag
    image1 = flip(image,2);
else
    image1 = flipud(image);
end
end