clc; clear; close all;
T1 = [0.01 0.03 0.05 0.07 0.1];
for i = 1:5

    T = T1(i);
    t = 0 : T : 0.5;
    f = 5 * exp(-10 * t);
    figure;
    subplot(2,1,1);
    plot(t,f,'r');
    grid;
    xlabel('t','FontName','Times new roman','FontSize',12,'FontWeight','bold');
    ylabel('f','FontName','Times new roman','FontSize',12,'FontWeight','bold');
    title('Original figure','FontName','Times new roman','FontSize',12,'FontWeight','bold');
    set(gca().Children, 'linewidth', 1);
    set(gca, 'linewidth', 1);
    subplot(2,1,2);
    stem(t,f,'k');
    grid;
    xlabel('t','FontName','Times new roman','FontSize',12,'FontWeight','bold');
    ylabel('f','FontName','Times new roman','FontSize',12,'FontWeight','bold');
    title(['sample figure, T = ',{T}],'FontName','Times new roman','FontSize',12,'FontWeight','bold');
    set(gca().Children, 'linewidth', 1);
    set(gca, 'linewidth', 1);
end

