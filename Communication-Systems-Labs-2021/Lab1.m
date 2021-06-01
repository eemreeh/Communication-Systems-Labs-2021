clear all; clc; close all;

%% 2.1 Signals in Time Domain
%a
Fs = 500;
T = 1/500;
time = 0:T:4;

xt1(1:length(0:T:1)) = 0;
xt2(1:length((1+T):T:2)) = 1;
xt3(1:length((2+T):T:3)) = (-2);
xt4(1:length((3+T):T:4)) = 0;

x = [xt1 xt2 xt3 xt4];

%b
figure
plot(time, x);
title('x(t)');
ylabel('Amplitude');
xlabel('Time (Second)');
legend('x(t)');

%c
x2 = cos(2*pi*50*time);
y1 = x.*x2;

%d
figure
plot(time, y1);
title('y1(t)');
ylabel('Amplitude');
xlabel('Time (Second)');
legend('y1(t)');

%% 2.2 Signals in Frequency Domain
%a
N = length(x);
X = fft(x, N);
Y1 = fft(y1, N);

FVec = linspace(-Fs/2,Fs/2, N);

figure
subplot(211);
plot(FVec,fftshift(abs(X))./N);
title('X(f)');
ylabel('Amplitude');
xlabel('Frequency');
legend('X(f)');
subplot(212);
plot(FVec,fftshift(abs(Y1))./N);
title('Y1(f)');
ylabel('Amplitude');
xlabel('Frequency');
legend('Y1(f)');

%b
time2 = 0:T:8;
FVec2 = linspace(-Fs/2,Fs/2, 2*N-1);

Xn = fft(x, 2*N-1);
X2 = fft(x2, 2*N-1);
Y2 = Xn.*X2;

figure
plot(FVec2, fftshift(abs(Y2))./(2*N-1));
title('Y2(f)');
ylabel('Amplitude');
xlabel('Frequency');
legend('Y2(f)');

%c
y2ifft = ifft(Y2,2*N-1);

figure
plot(time2,y2ifft);
title('y2(t) inverse FFT');
ylabel('Amplitude');
xlabel('Time (Second)');
legend('y2(t)');

%d
y2conv = conv(x,x2);

figure
plot(time2,y2conv);
title('y2(t) Convolution');
ylabel('Amplitude');
xlabel('Time (Second)');
legend('y2(t)');


figure
plot(y2ifft,y2conv);
title('y2(t)ifft/y2(t) Convolution');
ylabel('y2(t) Convolution');
xlabel('y2(t)ifft');













