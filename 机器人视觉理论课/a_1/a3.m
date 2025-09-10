clc;clear;close all;
image1 = imread('Saved Pictures/e75cf81bc51138808609399b4d5120c.jpg');
image2 = imread('Saved Pictures\OIP.jpg');
image3 = imread('Saved Pictures\OIP (1).jpg');
s = [size(image3,1),size(image3,2)];
image2 = imresize(image2,s);
image1 = imresize(image1,s);
Picture_save = {0};
filename = 'myGIF.gif';
array = [{image1},{image2},{image3}];
for idx = 1:3
    figure(idx);
    imshow(array{idx});
    Picture_save{idx} = frame2im(getframe(idx));
    close all;
end
for idx = 1:3
    [A,map] = rgb2ind(Picture_save{idx},256);
    if idx ==1
        imwrite(A,map,filename,'gif','LoopCount',Inf, 'DelayTime',0.5);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.5);
    end
end