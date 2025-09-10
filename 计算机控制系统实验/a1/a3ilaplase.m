clc; clear; close all;
syms s a w;
f1 = 1 / s;
f1s = ilaplace(f1)
f1tex = latex(f1s);
subplot 511;
text(0.1, 0.5, ['$G_{1}(s) = ' f1tex '$'], 'Interpreter', 'latex', 'FontSize', 18)
axis off

f2 = 1 / (s + a);
f2s = ilaplace(f2)
f2tex = latex(f2s);
subplot 512;
text(0.1, 0.5, ['$G_{2}(s) = ' f2tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f3 = 1 / s ^ 2;
f3s = ilaplace(f3)
f3tex = latex(f3s);
subplot 513;
text(0.1, 0.5, ['$G_{2}(s) = ' f3tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f4 = w / (s ^ 2 + w ^ 2);
f4s = ilaplace(f4)
f4tex = latex(f4s);
subplot 514;
text(0.1, 0.5, ['$G_{2}(s) = ' f4tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f5 = 1 / (s * (s + 2) ^ 2 * (s + 3));
f5s = ilaplace(f5)
f5tex = latex(f5s);
subplot 515;
text(0.1, 0.5, ['$G_{2}(s) = ' f5tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off
