clc; clear;
zero=[-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 1 1 1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1];
one=[-1 -1 1 -1 -1;-1 1 1 -1 -1;-1 -1 1 -1 -1;-1 -1 1 -1 -1;-1 1 1 1 -1];
two=[-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1;-1 -1 1 1 1;-1 -1 -1 -1 -1];
three=[-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1];
four=[-1 1 -1 1 -1;-1 1 -1 1 -1;-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 1 1 1 -1];
five=[-1 -1 -1 -1 -1;-1 -1 1 1 1;-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1];
six=[-1 -1 -1 -1 -1;-1 -1 1 1 1;-1 -1 -1 -1 -1;-1 1 -1 1 -1;-1 -1 -1 -1 -1];
seven=[-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 1 1 1 -1;-1 1 1 1 -1;-1 1 1 1 -1];
eight=[-1 -1 -1 -1 -1;-1 1 -1 1 -1;-1 -1 -1 -1 -1;-1 1 -1 1 -1;-1 -1 -1 -1 -1];
nine=[-1 -1 -1 -1 -1;-1 1 -1 1 -1;-1 -1 -1 -1 -1;-1 1 1 1 -1;-1 -1 -1 -1 -1];

figure(1);
subplot(2,5,1); imagesc(zero); title('Stored 0');
subplot(2,5,2); imagesc(one); title('Stored 1');
subplot(2,5,3); imagesc(two); title('Stored 2');
subplot(2,5,4); imagesc(three); title('Stored 3');
subplot(2,5,5); imagesc(four); title('Stored 4');
subplot(2,5,6); imagesc(five); title('Stored 5');
subplot(2,5,7); imagesc(six); title('Stored 6');
subplot(2,5,8); imagesc(seven); title('Stored 7');
subplot(2,5,9); imagesc(eight); title('Stored 8');
subplot(2,5,10); imagesc(nine); title('Stored 9');

V = [zero(:) one(:) two(:) three(:) four(:) five(:) six(:) seven(:) eight(:) nine(:)];
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