%生成并绘制数据(同上面示例)
x= 1:0.01:10;
y= sin(x);
plot(x, y)
title('sin Function');
xlabel('x');
ylabel('y');

saveas(gca, 'res', 'svg')