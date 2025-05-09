t1 = 0:1/100:3;                      % перші 3 секунди з 100 Гц
x1 = sin(2*pi*t1);                   % частота ω = 2π

t2 = 3+1/40:1/40:5;                  % наступні 2 сек з 40 Гц
x2 = sin(4*pi*t2);                   % частота ω = 4π

x = [x1 x2];                         % загальна функція
t = [t1 t2];                         % часовий вектор
y = [0 3*x(1:end-1)] + 1;  % додаємо 1, зсуваємо x(t-1)
x_seq = con2seq(x);
y_seq = con2seq(y);

net = timedelaynet(1:2, 1);  % два блоки затримки
[Xs, Xi, Ai, Ts] = preparets(net, x_seq, y_seq);

net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-5;
net = train(net, Xs, Ts, Xi, Ai);

Y = net(Xs, Xi);
perf = perform(net, Ts, Y);
e = gsubtract(Ts, Y);
figure;
plot(cell2mat(e));
xlabel('Час');
ylabel('Помилка');
title('Графік помилки на виході мережі');
max_delays = 5;
errors = zeros(1, max_delays);

for d = 1:max_delays
    net = timedelaynet(1:d, 1);
    [Xs, Xi, Ai, Ts] = preparets(net, x_seq, y_seq);
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 1e-5;
    net = train(net, Xs, Ts, Xi, Ai);
    Y = net(Xs, Xi);
    errors(d) = perform(net, Ts, Y);
end

figure;
plot(1:max_delays, errors, '-o');
xlabel('Кількість блоків затримки');
ylabel('Середньоквадратична помилка');
title('Помилка залежно від кількості блоків затримки');
