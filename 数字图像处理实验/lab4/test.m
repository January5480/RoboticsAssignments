
syms s; %创建变量x
p = s*(s+2)*(s+3)*(s+4)*(s+5); %定义多项式p
a = sym2poly(p)%求多项式p的系数