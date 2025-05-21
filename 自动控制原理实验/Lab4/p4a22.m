clc;clear;close all;
syms a d
eqn = 2*d^2+(a+3)*d+2*a == 0;
s = solve(eqn,d)
eqn1 = s(1)>a;
eqn2 = s(2)<-1;
solve('- a/4 - ((a - 1)*(a - 9))^(1/2)/4 - 3/4<-1','a')