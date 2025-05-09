% Вхідні дані
P = [3 2 5 4 1 6 8 7 9 6;
     120 160 180 190 100 210 250 230 300 280];

% One-hot encoding для міток класів
T_classes = [0 0 0 0 0 1 1 1 1 1];
T = full(ind2vec(T_classes + 1));

% Створення мережі (trainscg підтримує crossentropy)
net = patternnet(10);  
net.trainFcn = 'trainscg';
net.trainParam.epochs = 200;

% Нормалізація
[P_norm, ps] = mapminmax(P);

% Навчання
[net, tr] = train(net, P_norm, T);

% Перевірка результатів
Y = net(P_norm);
classes_predicted = vec2ind(Y) - 1;

% Візуалізація
view(net);
plotperform(tr);

figure;
gscatter(P(1,:), P(2,:), T_classes, 'rb', 'o^');
xlabel('Кількість героїв');
ylabel('Кількість сторінок');
title('Графік розділення повістей та романів (виправлений)');

[x, y] = meshgrid(0:0.1:10, 50:5:350);
grid_points = [x(:)'; y(:)'];
grid_points_norm = mapminmax('apply', grid_points, ps);
Z = net(grid_points_norm);
[~, Z_class] = max(Z);
Z_class = reshape(Z_class, size(x));

hold on;
contour(x, y, Z_class-1, [0.5 0.5], 'k', 'LineWidth', 2);
legend('Повість', 'Роман', 'Роздільна межа');
