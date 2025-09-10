clc; clear; close all;
I = imread('../实验课数据/校徽拼接/Picture.png');
x = SplitArray(I, 18);
for i=1:18
    imwrite(x{i},['../实验课数据/校徽拼接/',num2str(i),'.png']);
end
function [x] = SplitArray(Array, n)
    row = size(Array, 1);
    column = size(Array, 2);
    x = cell(1, n);
    col_per_part = fix(column / n);
    for j = 1:n
        if j == n
            x{j} = Array(:, (j - 1) * col_per_part + 1:column);
        else
            x{j} = Array(:, (j - 1) * col_per_part + 1:j * col_per_part);
        end
    end
end

% function [x]=SplitArray(Array,n)
% x=cell(n,n);
% row=size(Array,1);
% column=size(Array,2);
% for i=1:n
%     for j=1:n
%         x{i,j}=Array((i-1)*fix(row/n)+1:fix(row/n)*i,(j-1)*fix(column/n)+1:j*fix(column/n),:);
%     end
% end
% end