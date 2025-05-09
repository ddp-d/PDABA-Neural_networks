% Вхідні дані
P = [-2.0  2.0 -2.0  2.0 -2.0  2.0 -2.0  2.0;
     -2.0 -2.0  2.0  2.0 -2.0 -2.0  2.0  2.0;
     -2.0 -2.0 -2.0 -2.0  2.0  2.0  2.0  2.0];
T = [1 1 1 1 0 0 0 0];

% Створення та навчання мережі
net = patternnet(10);
net.trainParam.epochs = 200;
[net, tr] = train(net, P, T);

% Network Diagram та графік Performance
view(net);
plotperform(tr);

% Перевірка результатів класифікації
Y = net(P);

% Візуалізація точок у 3D-просторі
figure;
scatter3(P(1,:), P(2,:), P(3,:), 100, T, 'filled');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Точки вхідних даних у 3D-просторі');

% Коректна побудова межі прийняття рішень (через contour3)
[x, y, z] = meshgrid(-3:0.5:3, -3:0.5:3, -3:0.5:3);
grid_points = [x(:)'; y(:)'; z(:)'];
Z_pred = net(grid_points);
Z_pred = reshape(Z_pred, size(x));

figure;
isosurface(x, y, z, Z_pred, 0.5);
hold on;
scatter3(P(1,:), P(2,:), P(3,:), 100, T, 'filled');
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Ізоповерхня межі розподілу класів');
