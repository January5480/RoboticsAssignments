clc;clear;close all;
% a = [1,10,5,9,0,-5];
% for i = 1:6
%     figure;
%     a1 = a(i);
%     sys1 = tf([1,1],[1,a1,0,0]);
%     rlocus(sys1);
%     grid on;
%     title(sprintf('a=%d',a1))
%     set(gca,'linewidth',2);
%
% end
figure;
a1 = 1;
sys1 = tf([1,1],[1,a1,0,0]);
rlocus(sys1);
grid on;
title(sprintf('a=%d',a1))
set(gca,'linewidth',2);