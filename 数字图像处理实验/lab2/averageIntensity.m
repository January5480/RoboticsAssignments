function [Image_averIntensity] = averageIntensity(image)
%UNTITLED3 此处提供此函数的摘要
%   此处提供详细说明
A = sum(double(image(:)));%计算总像素的和
B = (size(image,1)*size(image,2));%计算像素的数量
Image_averIntensity = A/B;
end