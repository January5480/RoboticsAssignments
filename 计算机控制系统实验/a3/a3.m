clc;clear;close all;
k = 10; z = []; p = [-1, -3, -5]; Go = zpk(z, p, k);
G = tf(Go)
for Km = 0:0.1:10000
    Gc = Km;syso = feedback(Gc * G, 1);
    p = roots(syso.den{1});
    pr = real(p);prm = max(pr);
    pro = find(prm >= -0.001);
    n = length(pro);
    if n >= 1
        break
    end
end
step(syso, 0:0.001:3);
h = findobj(gcf, 'Type', 'line');
set(h, 'LineWidth', 2);
set(h, 'Color', 'b');
set(gca, 'LineWidth', 1.5);
grid on;

Km