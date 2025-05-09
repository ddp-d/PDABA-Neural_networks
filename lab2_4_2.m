% Створення псевдобукв (35 ознак для кожної з 26 літер)
inputs = randi([0 1], 35, 26);  % випадкові 0/1 як вхід

% Цільові вектори — one-hot для 26 літер
targets = eye(26);

% Створення та навчання мережі
net = feedforwardnet(50, 'trainlm');
net.trainParam.epochs = 500;
net = train(net, inputs, targets);

% Тестування без шуму
Y = net(inputs);

% Аналіз стійкості до шуму
noise_levels = 0:0.05:0.5;
errors = zeros(size(noise_levels));

for i = 1:length(noise_levels)
    noise_std = noise_levels(i);
    total_error = 0;

    for letter = 1:26
        for j = 1:10
            noise = noise_std * randn(35, 1);
            noisy_input = inputs(:, letter) + noise;
            output = net(noisy_input);
            target = targets(:, letter);
            total_error = total_error + norm(output - target);
        end
    end

    errors(i) = total_error / (26*10);  % середня помилка
end

plot(noise_levels, errors, '-o');
xlabel('Рівень шуму');
ylabel('Середня помилка');
title('Помилка при розпізнаванні символів (з випадковими векторами)');
