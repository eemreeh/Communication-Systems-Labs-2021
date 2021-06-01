clear all; clc; close all;

%% 9.1 Construction
%a
x = load('gong');

%b
mt = x.y;
mt = mt';
Fs = x.Fs;

%c
t = 0:(1/Fs):(numel(mt)-1)/Fs;

%d
fc = 2000;
c = cos(2*pi*fc*t);

%% 9.2 Modulation
%a
kf = 10000;
Am = 1;
Ac = 1;
dt = 1/Fs;
Xfm = Ac*cos((2*pi*fc*t) + (2*pi*kf*cumsum(mt)*dt));

%b
Xfm0 = awgn(Xfm, 0, 'measured');
Xfm5 = awgn(Xfm, 5, 'measured');
Xfm10 = awgn(Xfm, 10, 'measured');
Xfm20 = awgn(Xfm, 20, 'measured');

%% 9.3 Demodulation and Filtering
%a
Xdemod0 = fmdemod(Xfm0,fc,Fs,kf*Am);
Xdemod5 = fmdemod(Xfm5,fc,Fs,kf*Am);
Xdemod10 = fmdemod(Xfm10,fc,Fs,kf*Am);
Xdemod20 = fmdemod(Xfm20,fc,Fs,kf*Am);

%b
[b, a] = butter(8, 1700/(Fs/2));

Xlp0 = filter(b,a,Xdemod0);
Xlp5 = filter(b,a,Xdemod5);
Xlp10 = filter(b,a,Xdemod10);
Xlp20 = filter(b,a,Xdemod20);

%c
% sound(Xlp0);
% sound(Xlp5);
% sound(Xlp10);
sound(Xlp20);

%d
%comment

%% 9.4 Mean Square Error (MSE) and Comparison
%a
MSE0 = MSE_Emre_Hepsag(mt,Xlp0);
MSE5 = MSE_Emre_Hepsag(mt,Xlp5);
MSE10 = MSE_Emre_Hepsag(mt,Xlp10);
MSE20 = MSE_Emre_Hepsag(mt,Xlp20);

%b
figure
plot([0 5 10 20], [MSE0 MSE5 MSE10 MSE20]);
title("Mean Square Error (MSE) / SNR");
ylabel('MSE');
xlabel('SNR');


%c
%comment


%% 

N = length(t);
FVec = linspace(-Fs/2,Fs/2, N);

Mf = abs(fftshift(fft(mt, N)))/N;

%b
figure
plot(FVec, Mf);
title('|M(f|)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|M(f)|');

