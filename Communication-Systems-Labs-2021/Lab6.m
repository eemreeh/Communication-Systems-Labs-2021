clear all; clc; close all;

%% 2.1 Modulation
%a
Fs = 2000;
Ts = 1/Fs;
time = 0:Ts:0.2;

%b
Ac = 1;
fc = 200;

ct = Ac*cos(2*pi*fc*time);

%c
Am = 2;
fm = 50;

mt = Am*cos(2*pi*fm*time);

%d
kf = [5 25 50];
dt = Ts;

s1t = Ac*cos((2*pi*fc*time) + (2*pi*kf(1)*cumsum(mt,2)*dt));
s2t = Ac*cos((2*pi*fc*time) + (2*pi*kf(2)*cumsum(mt,2)*dt));
s3t = Ac*cos((2*pi*fc*time) + (2*pi*kf(3)*cumsum(mt,2)*dt));

%e
figure(1)
subplot(411);
plot(time, mt);
title('m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');
subplot(412);
plot(time, s1t);
title('s1(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s1(t)');
subplot(413);
plot(time, s2t);
title('s2(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s2(t)');
subplot(414);
plot(time, s3t);
title('s3(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s3(t)');

%f
%comment and compare

%% 2.2 Signals in Frequency Domain
%a
N = length(time);
FVec = linspace(-Fs/2,Fs/2, N);

Mf = abs(fftshift(fft(mt, N)))/N;
Cf = abs(fftshift(fft(ct, N)))/N;
S1f = abs(fftshift(fft(s1t, N)))/N;
S2f = abs(fftshift(fft(s2t, N)))/N;
S3f = abs(fftshift(fft(s3t, N)))/N;

%b
figure(2)
subplot(211);
plot(FVec, Mf);
title('|M(f|)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|M(f)|');
subplot(212);
plot(FVec, Cf);
title('|C(f)|');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|C(f)|');

%c
figure(3)
subplot(311);
plot(FVec, S1f);
title('|S1(f)|');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|S1(f)|');
subplot(312);
plot(FVec, S2f);
title('|S2(f)|');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|S2(f)|');
subplot(313);
plot(FVec, S3f);
title('|S3(f)|');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('|S3(f)|');

%d
%comment

%% 2.3 Demodulation
%a
demods1 = Am*fmdemod(s1t,fc,Fs,Am*kf(1));
demods2 = Am*fmdemod(s2t,fc,Fs,Am*kf(2));
demods3 = Am*fmdemod(s3t,fc,Fs,Am*kf(3));

%b
figure(4)
subplot(311)
plot(time,demods1);
hold on;
plot(time, mt);
title('Demodulated s1(t) and m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s1(t)','m(t)');
subplot(312)
plot(time,demods2);
hold on;
plot(time, mt);
title('Demodulated s2(t) and m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s2(t)','m(t)');
subplot(313)
plot(time,demods3);
hold on;
plot(time, mt);
title('Demodulated s3(t) and m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s3(t)','m(t)');

%c
%comment 





