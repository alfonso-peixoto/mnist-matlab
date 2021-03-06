clear all

Images = loadMNISTImages('./train-images.idx3-ubyte');
Images = reshape(Images, 28, 28, []);
Labels = loadMNISTLabels('./train-labels.idx1-ubyte');
Labels(Labels == 0) = 10;    % 0 --> 10

rng(1);

% Learning
%
W1 = 1e-2*randn([9 9 20]);
W5 = (2*rand(100, 2000) - 1) * sqrt(6) / sqrt(360 + 2000);
Wo = (2*rand( 10,  100) - 1) * sqrt(6) / sqrt( 10 +  100);

X = Images(:, :, 1:50000);
D = Labels(1:50000);

for epoch = 1:5
  epoch
  [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D);
end

save('MnistConv.mat');



% Test
%
X = Images(:, :, 50001:60000);
D = Labels(50001:60000);

acc = 0;
N   = length(D);
for k = 1:N
  x = X(:, :, k);                   % Input,           28x28

  y1 = Conv(x, W1);                 % Convolution,  20x20x20
  y2 = ReLU(y1);                    %
  y3 = Pool(y2);                    % Pool,         10x10x20
  y4 = reshape(y3, [], 1);          %                   2000  
  v5 = W5*y4;                       % ReLU,              360
  y5 = ReLU(v5);                    %
  v  = Wo*y5;                       % Softmax,            10
  y  = Softmax(v);                  %

  [~, i] = max(y);
  if i == D(k)
    acc = acc + 1;
  end
end

acc = acc / N;
fprintf('Accuracy is %f\n', acc);

%% Seção de testes com imagens individuais

% Geração aleatória
%k  = randi([50001,60000],1);

%Numero 0; Identificado como 10
%k = 55000;

%Numero 1; identificado como 1
%k = 55015;

%Numero 2; identificado como 2
%k = 57993;

%Numero 3; identificado como 3
%k = 56755;

%Numero 4; identificado como 4
%k = 55338;

%Numero 5; identificado como 5
%k = 52333;

%Numero 6; identificado como 6
%k = 57555;

%Numero 7; identificado como 7
%k = 51000;

%Numero 8; identificado como 8
%k = 55535;

%Numero 9; identificado como 9
%k = 53155;

X = Images;
x = X(:, :, k);
imwrite(x, 'm3.png');

y1 = Conv(x, W1);                 % Convolution,  20x20x20
y2 = ReLU(y1);                    %
y3 = Pool(y2);                    % Pool,         10x10x20
y4 = reshape(y3, [], 1);          %                   2000  
v5 = W5*y4;                       % ReLU,              360
y5 = ReLU(v5);                    %
v  = Wo*y5;                       % Softmax,            10
y  = Softmax(v);

[~, rotulomnist] = max(y);
figure;
display_network(x(:));
title('Imagem')

%% Seção de testes com imagens externas

%j  = im2bw(imread(strcat("imagens/","m0.png")));
%j  = im2bw(imread(strcat("imagens/","m1.png")));
%j  = im2bw(imread(strcat("imagens/","m2.png")));
%j  = im2bw(imread(strcat("imagens/","m3.png")));
%j  = im2bw(imread(strcat("imagens/","m4.png")));
%j  = im2bw(imread(strcat("imagens/","m5.png")));
%j  = im2bw(imread(strcat("imagens/","m6.png")));
%j  = im2bw(imread(strcat("imagens/","m7.png")));
%j  = im2bw(imread(strcat("imagens/","m8.png")));
%j  = im2bw(imread(strcat("imagens/","m9.png")));

%j  = im2bw(imread(strcat("imagens/","0.png")));
%j  = im2bw(imread(strcat("imagens/","1.png")));
%j  = im2bw(imread(strcat("imagens/","2.png"))); %Numero 2
%j  = im2bw(imread(strcat("imagens/","3.png")));
%j  = im2bw(imread(strcat("imagens/","4.png")));
%j  = im2bw(imread(strcat("imagens/","5.png")));
%j  = im2bw(imread(strcat("imagens/","6.png")));
%j  = im2bw(imread(strcat("imagens/","7.png")));
%j  = im2bw(imread(strcat("imagens/","8.png")));
%j  = im2bw(imread(strcat("imagens/","9.png")));
x = im2double(j);

y1 = Conv(x, W1);                 % Convolution,  20x20x20
y2 = ReLU(y1);                    %
y3 = Pool(y2);                    % Pool,         10x10x20
y4 = reshape(y3, [], 1);          %                   2000  
v5 = W5*y4;                       % ReLU,              360
y5 = ReLU(v5);                    %
v  = Wo*y5;                       % Softmax,            10
y  = Softmax(v);

[~, rotulogeral] = max(y);
figure;
display_network(x(:));
title('Imagem')