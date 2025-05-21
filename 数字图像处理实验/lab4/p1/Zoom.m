function [ image2 ] = Zoom( image,factor)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
f = ones(factor,factor);
image2 = kron(image,f);
end

