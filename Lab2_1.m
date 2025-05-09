X = [5 4 3 2];
T = [10 20 30 40];

X = con2seq(X);
T = con2seq(T);

max_delays = 3;
errors = zeros(1, max_delays);

for d = 1:max_delays
    delays = 1:d;
    net = timedelaynet(delays, 1);
    [Xs, Xi, Ai, Ts] = preparets(net, X, T);

    net.trainParam.epochs = 1000;
    net.trainParam.goal = 0.001;
    net = train(net, Xs, Ts, Xi, Ai);
    Y = net(Xs, Xi);
    errors(d) = perform(net, Ts, Y);
end

figure;
plot(1:max_delays, errors, '-o');
xlabel('Кількість блоків затримки');
ylabel('Середньоквадратична помилка');
title('Помилка в залежності від кількості блоків (timedelaynet)');
