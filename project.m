clc
clear
filename = 'آهنگ ریتم تند.wav';
[y,Fs] = audioread(filename);
sound(y,Fs);
%% record
% Fs=100000;
% nBits=24;
% nChannels=2;
% y=audiorecorder(Fs,nBits,nChannels);
% msgbox('Start speaking...')
% times=2;
% recordblocking(y,times);
% msgbox('End of Recording...');
% y=getaudiodata(y);
% sound(y,Fs)
%% plotting signal
T = 1/Fs;             % Sampling period       
L = length(y);             % Length of signal
t = (0:L-1)*T;
figure
plot(t(1:L),y(1:L))
axis('tight')
title('Signal')
xlabel('t (seconds)')
ylabel('X(t)')
%% fft
m=fft(y);
z=angle(m)*180/pi;
P2 = abs(m/L);
P1 = P2(1:L/2+1);
angle=z(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure
subplot(2,1,1)
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
ylabel('|P1(f)|')
subplot(2,1,2)
plot(f,angle)
title('Single-Sided Angle Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('angle(deg)')
%% echo channel 1
timelag = 0.2;
delta = round(Fs*timelag);
alpha = 0.4;

orig = [y(:,1);zeros(delta,1)];
echo = [zeros(delta,1);y(:,1)]*alpha;

mtEcho = orig + echo;
t = (0:length(mtEcho)-1)/Fs;
figure
subplot(2,1,1)
plot(t,[orig echo])
legend('Original','Echo')
axis('tight')
subplot(2,1,2)
plot(t,mtEcho)
legend('Total')
xlabel('Time (s)')
axis('tight')
%% echo channel 1 and 2
timelag1 = 0.3;
delta1 = round(Fs*timelag1);
alpha1 = 0.2;

orig = [mtEcho(:,1);zeros(delta1,1)];
echo1 = [zeros(delta1,1);mtEcho(:,1)]*alpha1;

mtEcho1 = orig+echo1;
t = (0:length(mtEcho1)-1)/Fs;
figure
subplot(2,1,1)
plot(t,[orig echo1])
legend('Original','Echo1')
axis('tight')
subplot(2,1,2)
plot(t,mtEcho1)
legend('Total')
xlabel('Time (s)')
axis('tight')
%% echo channel 1 and 2 and 3
timelag2 = 0.5;
delta2 = round(Fs*timelag2);
alpha2 = 0.1;

orig = [mtEcho1(:,1);zeros(delta2,1)];
echo2 = [zeros(delta2,1);mtEcho1(:,1)]*alpha2;

mtEcho2 = orig+echo2;
t = (0:length(mtEcho2)-1)/Fs;
figure
subplot(2,1,1)
plot(t,[orig echo2])
legend('Original','Echo2')
axis('tight')
subplot(2,1,2)
plot(t,mtEcho2)
legend('Total')
xlabel('Time (s)')
axis('tight')