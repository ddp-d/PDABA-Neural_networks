% Генерація даних
[X1, X2] = meshgrid(-5:0.5:5, -5:0.5:5);
P = [X1(:)'; X2(:)'];

% Реальні класи
T = double(X2(:) > -X1(:) - 1 & X2(:) > X1(:) - 1 & X2(:) < 3);

% Перетворення в one-hot encoding
T_onehot = full(ind2vec(T'+1));

% Створення та навчання нейронної мережі
net = patternnet(10);
net.trainFcn = 'trainscg';
net.trainParam.epochs = 300;
[net, tr] = train(net, P, T_onehot);

% Перевірка результатів
Y = net(P);
predicted_classes = vec2ind(Y)-1;

% Візуалізація Network Diagram та Performance
figure;
view(net);

figure;
plotperform(tr);

% Візуалізація класифікації (реальні vs прогнозовані)
figure;
hold on;

% Реальні класи (порожні маркери)
gscatter(P(1,:), P(2,:), T, 'kb', 'ox', 8, 'off');

% Прогнозовані класи (заповнені маркери)
scatter(P(1,predicted_classes==0), P(2,predicted_classes==0), 20, 'r', 'filled', 'Marker', '^');
scatter(P(1,predicted_classes==1), P(2,predicted_classes==1), 20, 'g', 'filled', 'Marker', 's');

xlabel('X(1)');
ylabel('X(2)');
title('Класифікація після навчання нейромережі');

legend('Клас 0 (реальний)', 'Клас 1 (реальний)', 'Клас 0 (прогноз)', 'Клас 1 (прогноз)');
hold off;