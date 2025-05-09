P = [1.5  1.0 -1.5 -0.5; -2.0 -0.5 -1.0 -1.5];
T = [1 0 0 1];
net = perceptron;

% Отримуємо додатковий вихід tr
[net, tr] = train(net, P, T);

Y = net(P);

% Network Diagram
view(net);

% Графік performance з інформацією tr
plotperform(tr);

% Побудова графіка простору входів для 2D
figure;
plotpv(P, T);        
hold on;
plotpc(net.IW{1}, net.b{1});
