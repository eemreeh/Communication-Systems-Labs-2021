clear all; clc; close all;

%% 3.1
%a
tend = 0.1;
Fs = 10000;
Ts = 1/Fs;
time = 0:Ts:tend;

%b
Am = 1;
Ac = 1;
fm = 100;
fc = 1000;

c = Ac*cos(2*pi*fc*time); 
m = Am*cos(2*pi*fm*time);

%c 
%d
ka05 = 0.5;
ka1 = 1;
ka2 = 2;

s05 = (m*ka05 + 1).*c; 
s1 = (m*ka1 + 1).*c; 
s2 = (m*ka2 + 1).*c; 

figure(1)
subplot(311);
plot(time,s05);
title('s(t) with modulation factor 0.5');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s(t)');
subplot(312);
plot(time,s1);
title('s(t) with modulation factor 1');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s(t)');
subplot(313);
plot(time,s2);
title('s(t) with modulation factor 2');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s(t)');

%e
%modulation foctor determines the modulation percentage. If we have a
%modulation factor over 100%, we would observe over modulation or phase
%reversal which we do not want.

%f
N = length(time);
FVec = linspace(-Fs/2,Fs/2, N);
M = fftshift(abs(fft(m,N)/N));
C = fftshift(abs(fft(c,N)/N));
S05 = fftshift(abs(fft(s05,N)/N));

figure(2)
subplot(311);
plot(FVec,M);
title('Frequency response of m(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('M(f)');
subplot(312);
plot(FVec,C);
title('Frequency response of c(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('C(f)');
subplot(313);
plot(FVec,S05);
title('Frequency response of s(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('S(f)');

%% 3.3
%a
s09 = (m*(0.9) + 1).*c; 
s2 = (m*2 + 1).*c; 

fcutoff = 750;

[b,a] = butter(4,fcutoff/(Fs/2));

demod09 = sqrt(filter(b,a,((s09).^2))); 
demod2 = sqrt(filter(b,a,((s2).^2)));

% plot(FVec,abs(fftshift(fft((s09).^2,N)/N)))
%b
%Higher orders are more costly. Thus, we need to choose lowest order that 
%works properly which is 4 in this case. To obtain the message signal, 
%we need to have a low pass filter with the cutoff frequency higher than
%2*fm and lowen than 2*fc. That's why, I have chosen 750Hz cutoff frequency. 

%c
figure(3);
subplot(211);
plot(time,abs(demod09));
title('m(t) with modulation factor 0.9');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');
subplot(212);
plot(time,abs(demod2));
title('m(t) with modulation factor 2');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');

%d
%In the first graph, we obtain the original signal without loss. 
%However, in the secon graph, we see a distorded signal because of
%overmodulation or phase reversal.


