clear all; clc; close all;

%% 1 Construction of the Signals
%b
Fs = 1000;
Ts = 1/1000;
time = 0:Ts:2;
N = length(time);
FVec = linspace(-Fs/2,Fs/2, N);

x2 = cos(120*pi*time) + cos(500*pi*time);

%b
X = zeros(1,2001);
X(900:1000) = (0:1/100:1);
X(1001:1101) = (1:-1/100:0);

%c
X2 = abs(fftshift(fft(x2,N)))./N;
Y1 = X + X2;

%d
figure(1)
subplot(3,1,1);
plot(FVec,X);
title('|X(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|X(f)|');
subplot(3,1,2);
plot(FVec,X2);
title('|X2(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|X2(f)|');
subplot(3,1,3);
plot(FVec,Y1);
title('|Y1(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|Y1(f)|');

%% 2 Filtering
%a
H1 = zeros(1,N);
H1(900:1101) = 1;

Y2 = Y1.*H1;

%b
figure(2)
subplot(2,1,1);
plot(FVec,H1);
title('|H1(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|H1(f)|');
subplot(2,1,2);
plot(FVec,Y2);
title('|Y2(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|Y2(f)|');

%c
H2 = zeros(1,N);
H2(400:600) = 1;
H2(1400:1600) = 1;

Y3 = Y1.*H2;

%d
figure(3)
subplot(2,1,1);
plot(FVec,H2);
title('|H2(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|H2(f)|');
subplot(2,1,2);
plot(FVec,Y3);
title('|Y3(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|Y3(f)|');


%e
% [A,B,C,D] = butter(10,[225 275]/(Fs/2));
% d = designfilt('bandpassiir','FilterOrder',20,'HalfPowerFrequency1',225,'HalfPowerFrequency2',275,'SampleRate',Fs);

[b,a]=butter(10,[200,300]/(Fs/2),'bandpass');
ybpf=filter(b,a,x2);  

Ybpf = abs(fftshift(fft(ybpf))./N);
%f
figure(4)
subplot(2,1,1);
freqz(b,a,N,Fs);
title('|Hbpf(f)|');
legend('|Hbpf(f)|');
subplot(2,1,2);
plot(FVec,Ybpf);
title('|Ybpf(f)|');
ylabel('Amplitude');
xlabel('Frequency');
legend('|Ybpf(f)|');




