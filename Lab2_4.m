P = [0 1 0 1; 0 0 1 1];   % вхідні пари
T = [0 1 1 0];            % цільові значення XOR

net = feedforwardnet(3, 'trainlm');  % 3 нейрони, метод trainlm
net.trainParam.epochs = 200;
net.trainParam.goal = 1e-3;

net = train(net, P, T);   % навчання
Y = net(P)                % тестування

