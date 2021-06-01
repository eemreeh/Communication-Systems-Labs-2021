clear all; clc; close all;

%% 2.1 DSB-SC Modulation
%a
t = 0.08;
fm = 100;
fc = 1000;
Fs = 100000;
Ts = 1/Fs;
time = 0:Ts:t;
Ac1 = 1;

m = cos(2*pi*fm*time);
c = Ac1*cos(2*pi*fc*time);

%b
s = m.*c;

%c
figure(1)
subplot(311);
plot(time,m);
title('m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');
subplot(312);
plot(time,c);
title('c(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('c(t)');
subplot(313);
plot(time,s);
title('s(t) modulated signal');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s(t)');

%d
N = length(time);
FVec = linspace(-Fs/2,Fs/2, N);
S = abs(fftshift(fft(s,N)))/N;
M = abs(fftshift(fft(m,N)))/N;

figure(2)
subplot(211);
plot(FVec,M);
title('M(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('M(f)');
subplot(212);
plot(FVec,S);
title('S(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('S(f)');

%In the obtain signal, we see 4 impulses with 1/4 amplitude at
%-1100,-900,900 and 1100. That represents the fourier transform of
%modulates signal.
%s(t) = m(t)*Ac*cos(2pi1000t) = cos(2pi100t)*Ac*cos(2pi1000t)
%S(f) = 1/4[?(-1000-100)+?(-1000+100)+?(1000-100)+?(1000+100)] 

%% 2.2 DSB-SC Demodulation
%a
phase = 0;
Ac2 = 2;
LocalO = Ac2*cos(2*pi*fc*time+phase);
v = s.*LocalO;

%b
V = abs(fftshift(fft(v,N)))/N;

figure(3)
plot(FVec,V);
title('V(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('V(f)');

%We see 6 impulses which are at -2100,-1900,-100, 100, 1900 and 2100.
%Because v(t) = ((Ac*Ac')/2)* m(t)*[cos(?)+cos(2?2000t)]
%V(f) = (Ac*Ac')/4*[?(-100)+?(100)+1/2(?(-2100)+?(-1900)+?(1900)+?(2100))]        
%Ac = 1, Ac' = 2, thats why we see 1/2 amplitude at -100 and 100, 1/4 at
%-2100, -1900, 1900 and 2100.

%c
fcutoff = 500;

[b,a] = butter(4,fcutoff/(Fs/2));
vo = filter(b,a,v);

% freqz(b,a,N,Fs);
% ax=get(gcf,'Children');
% li=get(ax(1),'Children'); 
% r=get(ax(1),'YLabel'); 
% set(r,'String','Magnitude') 
% ydata=get(li,'Ydata'); 
% y=10.^(ydata/20); 
% set(li,'Ydata',y); 

%We want to eliminate the signal which is greater that 1900Hz and keep the
%signal which is less than 100Hz. Thus, our cutoff frequency of the filter
%is supposed to be between 100Hz and 1900Hz. Also, to obtain the least
%costly efficient filter design, we need to choose least order that we
%can. That is why, the order of my filter is 4 and cutoff is 500.

%d
VO = abs(fftshift(fft(vo,N)))/N;

title('V(f)');

figure(4)
subplot(211);
plot(FVec,VO);
title('VO(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('VO(f)');
subplot(212);
plot(time,vo);
title('vo(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('vo(t)');

%Compare and comment on the frequency content and magnitude of the obtained signal.
%To obtain the same signal as m(t), I have chosen the Ac as 1 and Ac' as 2.
%We see the same frequency and the same amplitude. There is just a little
%phase shift at the demodulated signal because of lowpass filter.


