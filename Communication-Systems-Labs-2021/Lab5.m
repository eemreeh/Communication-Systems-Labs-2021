clear all; clc; close all;

%% 2.1 SSB Modulation
%a
fm = 450;
fc = 5000;
Fs = 20000;
Ts = 1/Fs;
time = 0:Ts:0.03;

m = 3*cos(2*pi*fm*time);
c = cos(2*pi*fc*time);

%b
s = m.*c;

%c
fcutoff = fc;
[b1,a1] = butter(4,fcutoff/(Fs/2),'high');
[b2,a2] = butter(21,fcutoff/(Fs/2),'high');

N = 2^nextpow2(length(time));
div = length(time);

[h1, w1] = freqz(b1,a1,N,Fs);
[h2, w2] = freqz(b2,a2,N,Fs);

%d
figure(1)
plot(w1, abs(h1));
hold on;
plot(w2, abs(h2));
title('HighPass Filters');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('order < 5','order > 20');


%e
s_usb1 = filter(b1,a1,s);
s_usb2 = filter(b2,a2,s);

%f
FVec = linspace(-Fs/2,Fs/2, N);

S = abs(fftshift(fft(s,N))./div);
S_USB1 = abs(fftshift(fft(s_usb1,N))./div);
S_USB2 = abs(fftshift(fft(s_usb2,N))./div);

figure(2)
subplot(311);
plot(FVec,S);
title('S(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('S(f)');
subplot(312);
plot(FVec,S_USB1);
title('S_ USB1(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('S_ USB1(f)');
subplot(313);
plot(FVec,S_USB2);
title('S_ USB2(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('S_ USB2(f)');

%We see that filter with greater order filters much better than the filter 
%which has lesser order. Also, the lower side band signal passed through the
%filter at the second graph but not at the third graph. Because greater order 
%generates more ideal like filter.
%% 2.2 SSB Demodulation
%a

%s_usb2 which has order greater that 20 is more likely desired modulated
%signal. That is why I have chosen s_usb2.

phase = 0;
Ac = 4;
LocalO = Ac*cos(2*pi*fc*time+phase);
v = s_usb2.*LocalO;

%b
% plot(FVec,abs(fftshift(fft(v,N)/N)));
fcutoff2 = 1000;

[b,a] = butter(2,fcutoff2/(Fs/2));

%Our cutoff frequency is supposed to be between fm and 2fc-fm that is why I
%have chosen cutoff as 1000Hz with order of 2 because we desire least order
%as possible and more original message like modulated signal. I obtain
%those with 2nd order 1000Hz cutoff filter.

%c
m_demod = filter(b,a,v);

%d
M = abs(fftshift(fft(m,N))./div);
V = abs(fftshift(fft(v,N))./div);
M_DEMOD = abs(fftshift(fft(m_demod,N))./div);

figure(3)
subplot(311);
plot(FVec,M);
title('M(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('M(f)');
subplot(312);
plot(FVec,V);
title('V(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('V(f)');
subplot(313);
plot(FVec,M_DEMOD);
title('M_ DEMOD(f)');
ylabel('Amplitude');
xlabel('Frequency (Hz)');
legend('M_ DEMOD(f)');

%When we multiply s with local oscillator, we obtain the signal with 1/4
%times message signal. Thus, I have chosen 4 as amplitude of local
%oscillator. Thanks to this, we almost obtain the original message signal.
%There are peaks at 450Hz because our message signal is a cosine with 450Hz
%frequency. Also at V(f) we see peak at 2fc-fm because of product
%modulator.

%e
figure(4)
plot(time,m);
hold on;
plot(time,m_demod);
title('m(t) and m_ demod(t)');
ylabel('Amplitude');
xlabel('Timse (sec)');
legend('m(t)','m_ demod(t)');

%We obtain almost the same with demodulating s(t). There is just a little
%phase and amplitude difference because of nonideal filter.








