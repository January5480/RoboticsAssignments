clc; clear; close all;
syms a k T;
f1 = exp(-a * k * T);
f1z = ztrans(f1)
f1tex = latex(f1z);
subplot 511;
text(0.1, 0.5, ['$G_{1}(s) = ' f1tex '$'], 'Interpreter', 'latex', 'FontSize', 18)
axis off

f2 = k * T;
f2z = ztrans(f2)
f2tex = latex(f2z);
subplot 512;
text(0.1, 0.5, ['$G_{2}(s) = ' f2tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f3 = k * T * exp(-a * k * T);
f3z = ztrans(f3)
f3tex = latex(f3z);
subplot 513;
text(0.1, 0.5, ['$G_{2}(s) = ' f3tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f4 = sin(a * k * T);
f4z = ztrans(f4)
f4tex = latex(f4z);
subplot 514;
text(0.1, 0.5, ['$G_{2}(s) = ' f4tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f5 = a * k;
f5z = ztrans(f5)
f5tex = latex(f5z);
subplot 515;
text(0.1, 0.5, ['$G_{2}(s) = ' f5tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off