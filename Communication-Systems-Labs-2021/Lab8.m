clear all; clc; close all;

%% 9.1 Construction
%a
Img = imread('cameraman.tif');
M = im2double(Img);

%b
Fs = size(M,1)*size(M,2);

%c
ImgVec = reshape(M,1,[]);
t = 0:(1/Fs):(numel(ImgVec)-1)/Fs;

%d
Fc = 20000;
c = cos(2*pi*Fc*t);

FVec = linspace(-Fs/2,Fs/2, 65536);

%% 9.2 Modulation
%a
x_dsbsc = c.*ImgVec;

SNR = [0 5 10 20 30];

x_dsbsc0 = awgn(x_dsbsc,SNR(1));
x_dsbsc5 = awgn(x_dsbsc,SNR(2));
x_dsbsc10 = awgn(x_dsbsc,SNR(3));
x_dsbsc20 = awgn(x_dsbsc,SNR(4));
x_dsbsc30 = awgn(x_dsbsc,SNR(5));

%% 9.3 Demodulation and Filtering
%a
demod0 = x_dsbsc0.*c*2;
demod5 = x_dsbsc5.*c*2;
demod10 = x_dsbsc10.*c*2;
demod20 = x_dsbsc20.*c*2;
demod30 = x_dsbsc30.*c*2;

[b, a] = butter(2, 13500/(Fs/2));

filtered0 = filter(b,a,demod0);
filtered5 = filter(b,a,demod5);
filtered10 = filter(b,a,demod10);
filtered20 = filter(b,a,demod20);
filtered30 = filter(b,a,demod30);

%b
reshaped0 = reshape(filtered0,256,256);
reshaped5 = reshape(filtered5,256,256);
reshaped10 = reshape(filtered10,256,256);
reshaped20 = reshape(filtered20,256,256);
reshaped30 = reshape(filtered30,256,256);

%c
%comment

%% 9.4 Plots
figure
subplot(321);
imshow(M);
title("Original");
subplot(322);
imshow(reshaped0);
title("SNR 0");
subplot(323);
imshow(reshaped5);
title("SNR 5");
subplot(324);
imshow(reshaped10);
title("SNR 10");
subplot(325);
imshow(reshaped20);
title("SNR 20");
subplot(326);
imshow(reshaped30);
title("SNR 30");

%% 9.5 Mean Square Error (MSE) and comparison
%a
MSE0 = MSE_Emre_Hepsag(M,reshaped0);
MSE5 = MSE_Emre_Hepsag(M,reshaped5);
MSE10 = MSE_Emre_Hepsag(M,reshaped10);
MSE20 = MSE_Emre_Hepsag(M,reshaped20);
MSE30 = MSE_Emre_Hepsag(M,reshaped30);

%b
MSEmx = [MSE0 MSE5 MSE10 MSE20 MSE30];

figure
plot(SNR, MSEmx);
title("Mean Square Error (MSE) / SNR");
ylabel('MSE');
xlabel('SNR');
%c
%comment
