clear all; clc; close all;

%% 2.1 Angle Modulation (FM & PM)
%a
Fs = 2000;
Ts = 1/Fs;
time = 0:Ts:0.5;
phase = pi/2;
Am = 1;
mt = Am*sawtooth(2*pi*10*time+phase,1/2);

%b
fc = 100;
kf = 80;
ct = cos(2*pi*fc*time);
Ac = 1;
dt = Ts;

sfmt = Ac*cos(2*pi*fc*time + 2*pi*kf*cumsum(mt,2)*dt);

%c
fc = 100;
kp = 2*pi;

spmt = cos(2*pi*fc*time + kp*mt);

%d
figure(1);
subplot(311);
plot(time,mt);
title('m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');
subplot(312);
plot(time,sfmt);
title('sfm(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('sfm(t)');
subplot(313);
plot(time,spmt);
title('spm(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('spm(t)');

%e
%comment 

%f
kp2 = 3*pi;
kp3 = 4*pi;

spm2t = cos(2*pi*fc*time + kp2*mt); 
spm3t = cos(2*pi*fc*time + kp3*mt);

figure(2)
subplot(311);
plot(time,spmt);
title('spm(t), kp = 2*pi');
ylabel('Amplitude');
xlabel('Time (s)');
legend('spm(t)');
subplot(312);
plot(time,spm2t);
title('spm2(t), kp2 = 3*pi');
ylabel('Amplitude');
xlabel('Time (s)');
legend('spm2(t)');
subplot(313);
plot(time,spm3t);
title('spm3(t), kp3 = 4*pi');
ylabel('Amplitude');
xlabel('Time (s)');
legend('spm3(t)');

%g
%comment

%% 2.2 Demodulation of PM Signal
%a
%b
N = length(time);
xpmt = hilbert(spmt,N);

%c
FVec = linspace(-Fs/2,Fs/2, N);
Mf = abs(fftshift(fft(mt,N)))/N;
SPMf = abs(fftshift(fft(spmt,N)))/N;
XPMf = fftshift(fft(xpmt,N))/N;

figure(3)
subplot(311);
plot(FVec,Mf);
title('Frequency response of m(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('M(f)');
axis([-400 400 -inf inf]);
subplot(312);
plot(FVec,SPMf);
title('Frequency response of spm(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('Spm(f)');
axis([-400 400 -inf inf]);
subplot(313);
plot(FVec,abs(XPMf));
title('Frequency response of xpm(t)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('Xpm(f)');
axis([-400 400 -inf inf]);

%d
thetait = unwrap(angle(xpmt));
xhatt = (thetait - 2*pi*fc*time)/kp;

%e
xpm3t = hilbert(spm3t,N);
thetai3t = unwrap(angle(xpm3t));
xhat3t = (thetai3t - 2*pi*fc*time)/kp3;

%f
figure(4)
plot(time,mt);
hold on;
plot(time,xhatt);
hold on;
plot(time,xhat3t);
title('Message Dignals and Demodulated Signals');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)','mhat(t)','mhat3(t)');

%g
%comment







