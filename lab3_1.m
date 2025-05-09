clc; clear;
A1=[1 -1 -1 -1 1;-1 1 1 1 -1;-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 1 1 1 -1];
B1=[-1 -1 -1 -1 1;-1 1 1 1 -1;-1 -1 -1 -1 1;-1 1 1 1 -1;-1 -1 -1 -1 1];
C1=[-1 -1 -1 -1 -1;-1 1 1 1 1;-1 1 1 1 1;-1 1 1 1 1;-1 -1 -1 -1 -1];
D1=[-1 -1 -1 1 1;-1 1 1 -1 1;-1 1 1 -1 1;-1 1 1 -1 1;-1 -1 -1 1 1];

figure(1);
subplot(221); imagesc(A1); title('Stored A');
subplot(222); imagesc(B1); title('Stored B');
subplot(223); imagesc(C1); title('Stored C');
subplot(224); imagesc(D1); title('Stored D');

V = [A1(:) B1(:) C1(:) D1(:)];
alpha = 0.8;
iter = 10;

W = V*V';
W = W - diag(diag(W));

x = sign(2*rand(5,5)-1);
x = reshape(x,25,1);

for k = 1:iter
    figure(2);
    subplot(2,5,k);
    imagesc(reshape(x,5,5));
    xtemp = alpha*W*x;
    for j = 1:25
        if xtemp(j)>0
            x(j) = 1;
        else
            x(j) = -1;
        end
    end
end