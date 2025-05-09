% Вхідні дані
P = [0.5 -0.4 -0.8 -1.0 -0.5  1.3  1.0  1.5  0.4 -0.2;
     3.0  2.5 -0.3  0.4  0.1 -0.4  0.2 -0.3 -1.5 -1.8];
T = [1 1 1 1 1 0 0 0 0 0;
     0 0 1 1 1 0 0 0 1 1];

% Створення мережі
net = patternnet(10);
net.trainParam.epochs = 200;
[net, tr] = train(net, P, T);

% Network Diagram і Performance
view(net);
plotperform(tr);

% Класифікація
Y = net(P);

% Графік результатів
figure;
classes = vec2ind(T); % Отримуємо номер класу
h = gscatter(P(1,:), P(2,:), classes);
hold on;

% Візуалізація меж класифікації
[x, y] = meshgrid(-2:0.1:2, -2:0.1:4);
grid_points = [x(:)'; y(:)'];
z = net(grid_points);
[~, z_idx] = max(z);
z_idx = reshape(z_idx, size(x));

contour(x, y, z_idx, 'LineWidth', 1.5, 'LineColor', 'k');

% Коректна побудова легенди
legend_entries = unique(classes);
legend_labels = arrayfun(@(x) sprintf('Клас %d', x), legend_entries, 'UniformOutput', false);
legend_labels{end+1} = 'Роздільна межа';
legend([h; plot(NaN,NaN,'k','LineWidth',1.5)], legend_labels, 'Location', 'best');

title('Класифікація на 4 класи (виправлена)');
xlabel('x'); ylabel('y');
