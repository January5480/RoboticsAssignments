clc;clear;close all;
image = im2double(imread("Fig_strawberries.tif"));
subplot(1,3,1);
imshow(image);
title('original image');
[x,y,z] = size(image);
W = 0.2549;
R = 0.1765;
a = [0.6863, 0.1608, 0.1922]';
image1 = zeros(size(image));
image2 = zeros(size(image));
for i = 1:x
    for j = 1:y
        b = image(i,j,:);
        c = b(:);
        %         if all(abs(c - a) < W/2)
        d = abs(c - a) < W/2;
        if sum(d(:)) == 0
            image1(i,j,1) = image(i,j,1);
            image1(i,j,2) = image(i,j,2);
            image1(i,j,3) = image(i,j,3);
        else
            image1(i,j,1) = 0.5;
            image1(i,j,2) = 0.5;
            image1(i,j,3) = 0.5;
        end
    end
end
subplot(1,3,2);
imshow(image1);
title('cube slicing');
% for i = 1:x
%     for j = 1:y
%         b = image(i,j,:);
%         c = b(:);
%         if dist(c',a) < R
%             image2(i,j,1) = image(i,j,1);
%             image2(i,j,2) = image(i,j,2);
%             image2(i,j,3) = image(i,j,3);
%         else
%             image2(i,j,1) = 0.5;
%             image2(i,j,2) = 0.5;
%             image2(i,j,3) = 0.5;
%         end
%     end
% end
% subplot(1,3,3);
% imshow(image2);
% title('sphere slicing');