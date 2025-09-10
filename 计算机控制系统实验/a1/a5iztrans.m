clc; clear; close all;
syms z a T;
f1 = z / (z - 1);
f1z = iztrans(f1)
f1tex = latex(f1z);
subplot 511;
text(0.1, 0.5, ['$G_{1} = ' f1tex '$'], 'Interpreter', 'latex', 'FontSize', 18)
axis off

f2 = z / (z - exp(-a * T));
f2z = iztrans(f2)
f2tex = latex(f2z);
subplot 512;
text(0.1, 0.5, ['$G_{2} = ' f2tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f3 = T * z / (z - 1) ^ 2;
f3z = iztrans(f3)
f3tex = latex(f3z);
subplot 513;
text(0.1, 0.5, ['$G_{3} = ' f3tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f4 = z / (z - a);
f4z = iztrans(f4)
f4tex = latex(f4z);
subplot 514;
% text(0.1, 0.5, ['$G_{4}(s) = ' f4tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off

f5 = z /((z + 2)^2*(z + 3));
f5z = iztrans(f5)
f5tex = latex(f5z);
subplot 515;
text(0.1, 0.5, ['$G_{5} = ' f5tex '$'], 'Interpreter', 'latex', 'FontSize', 16)
axis off