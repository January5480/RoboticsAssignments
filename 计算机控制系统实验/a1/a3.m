clc; clear; close all;
syms a w t;
f1 = exp(-a * t);
f1s = laplace(f1)
f1tex = latex(f1s);
subplot 511;
text(0.1, 0.5, ['$G_{1}(s) = ' f1tex '$'], 'Interpreter', 'latex', 'FontSize', 18)
axis off

f2 = t;
f2s = laplace(f2)
f2tex = latex(f2s);
subplot 512;
text(0.1, 0.5, ['$G_{2}(s) = ' f2tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f3 = t * exp(-a * t);
f3s = laplace(f3)
f3tex = latex(f3s);
subplot 513;
text(0.1, 0.5, ['$G_{2}(s) = ' f3tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f4 = sin(w * t);
f4s = laplace(f4)
f4tex = latex(f4s);
subplot 514;
text(0.1, 0.5, ['$G_{2}(s) = ' f4tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f5 = exp(-a * t) * cos(w * t);
% symdisp(f5);
f5s = laplace(f5)
f5tex = latex(f5s);
subplot 515;
text(0.1, 0.5, ['$G_{2}(s) = ' f5tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off
% symdisp(f6);

function h=symdisp(s)
%//SYMDISP Display a symbolic expression in human readable form.
%// symdisplay(S) displays the symbolic expression S in a small figure window,
%// using standard mathematical notation.
%// 
%// Examples:
%//   syms x t positive
%//   f=taylor(cos(x));
%//   symdisp(f)
%//   f=int(exp(-t)*t^(x-1),t,0,inf);
%//   symdisp(f)
%//
%// Required toolbox: Symbolic Math
%//
%// See also SYMBOLIC PRETTY.
if ~isa(s,'sym')
    s=sym(s);
    %error('输入参数必须是sym类型,请使用 sym() 将你的结果转化为sym类型.')
end
S=['$',latex(s),'$'];
S=strrep(S,'&','& \quad');
S=strrep(S,'{\it','\mathrm{');
h=msgbox(S,'字符的数学展示形式');
h1=get(h,'children');
h2=h1(1);
h3=get(h2,'children');
if isempty(h3)
    h2=h1(2); h3=get(h2,'children');
end
set(h3,'visible','off')
set(h3,'interpreter','latex')
set(h3,'string',S)
set(h3,'fontsize',20)
w=get(h3,'extent');
W=get(h,'position');
W(3)=max(w(3)+10,125);
W(4)=w(4)+40;
set(h,'position',W)
h4=h1(2);
if ~strcmp(get(h4,'tag'),'OKButton'), h4=h1(1); end
o=get(h4,'position');
o(1)=(W(3)-o(3))/2;
set(h4,'position',o)
set(h3,'visible','on')
set(h,'color','w');
end

