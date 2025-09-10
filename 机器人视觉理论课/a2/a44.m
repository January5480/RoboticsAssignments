clc;clear;close all;
A = imread('rice.png');
subplot(1,2,1);imshow(A);
title('原始图像');
T = mean2(A);
done = false;
i = 0;
while ~done
    r1 = find(A <= T);
    r2 = find(A > T);
    Tnew = (mean(A(r1) + mean(A(r2))))/2;
    done = abs(Tnew - T) < 1;
    T = Tnew;
    i = i + 1;
end
A(r1) = 0;
A(r2) = 1;
subplot(1,2,2);imshow(A,[]);
title('迭代处理后的图像');