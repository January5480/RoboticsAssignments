function [ image2 ] = Zoom( image,factor)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
f = ones(factor,factor);
image2 = kron(image,f);
end

