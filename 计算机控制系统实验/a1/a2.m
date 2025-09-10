clc;clear;close all;
w = -50 : 1 : 50;
F = 5 ./ sqrt(100 + w .^2);
plot(w,F, 'Color', 'b', 'LineWidth',2);
xlabel('$\omega (rad/s)$', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$F$', 'Interpreter', 'latex', 'FontSize', 12);
title('$$F = \frac{5}{\sqrt{100 + \omega^2}}$$', 'Interpreter', 'latex', 'FontSize', 14);
grid;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
xlim([-50, 50]);ylim([0, 0.5]);
set(gca, 'FontSize', 10);


wss = [100 150 200 250];
  
for i = 1:4
    figure;
%     subplot(2,2,i)
    w = -400:20:400;
    ws = wss(i);
    Ts = 2 * pi / ws;
    F0 = 5 / Ts * (1./sqrt(100 + (w) .^ 2));
    F1 = 5 / Ts * (1./sqrt(100 + (w - ws) .^ 2));
    F2 = 5 / Ts * (1./sqrt(100 + (w + ws) .^ 2));
    plot(w, F0, w, F1, w, F2, 'LineStyle','-','LineWidth',2);
    grid;
    set(gca, 'GridLineStyle', '--','GridAlpha', 0.7);
    xlabel('$\omega(rad/s)$', 'Interpreter','latex','FontSize',12);
    ylabel('$F$','Interpreter','latex','FontSize',12);
    legend({'原图像','前移ws','后移ws'});
    title(['幅频曲线,ws = ',{ws}]);
end