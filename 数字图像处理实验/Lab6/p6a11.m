r = 8;
colorPalette = lines(r);

% 可视化调色板
figure;
hold on;
for i = 1:r
    fill([i-1, i, i, i-1], [0, 0, 1, 1], colorPalette(i, :), 'EdgeColor', 'none');
end
xlim([0, r]);
ylim([0, 1]);
title('Lines Color Palette (Easily Distinguishable)');
grid on;