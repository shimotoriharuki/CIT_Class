f1 = [195.8, 115.2, 108.4, 203.9, 200.9];
f2 = [294.9, 230.2, 217.8, 305.7, 301.5];
f3 = [392.8, 345.5, 326.2, 407.7, 402.3];
size = 100;

scatter(f1(1, 1), f2(1, 1), size,  'filled');

hold on
scatter(f1(1, 2), f2(1, 2), size,  'filled');
hold off

hold on
scatter(f1(1, 3), f2(1, 3), size, 'filled');
hold off

hold on
scatter(f1(1, 4), f2(1, 4), size, 'filled');
hold off

hold on
scatter(f1(1, 5), f2(1, 5), size, 'filled');
hold off



legend("‚ ", "‚¢", "‚¤", "‚¦", "‚¨")
xlabel("F1[Hz]")
ylabel("F2[Hz]")