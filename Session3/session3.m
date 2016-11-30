clear all;
close all;

%% Exercise 3.1.2

[y, Fs] = audioread('karaoke.wav');
y_mono = y(:,1) + y(:,2);

Ts = 1/Fs;
N = 0.1/Ts;
figure;
subplot(2,1,1)
spectrogram(y_mono, N, round(N/2), [], Fs, 'yaxis');
title('Original sampling frequency')

% A: After some trials, it appears that increasing the window length increases the
% frequency resolution but lowers the time resolution.
% In this case, the signal is not stationnary at all, and a rather short windows 
% should thus be used.

% The fundamental frequency appears to be around 300 Hz (probably a D or a E_b) 
% and a slight vibrato is visible.

% The instants at which the words begin and end are easily identified, where there is 
% nearly no energy present in the spectrum (mainly blue).

% The default window used by matlab is the Hamming window, because the rectangular window
% induces the so-called "leakage" due to its sidelobes.

p= 1;
q= 20;
ratio = p/q;
y_mono_resamp = resample(y_mono,p,q);
subplot(2,1,2)
spectrogram(y_mono_resamp, N, round(N/2), [], Fs*ratio, 'yaxis');
title(['Sampling frequency reduced by a factor ', num2str(1/ratio)])

% The zoomed figure confirms the fundamental frequency around 300 Hz

close all;

[noot1, Fs] = audioread('noot1.wav');
[noot2, Fs] = audioread('noot2.wav');
[noot3, Fs] = audioread('noot3.wav');
% All Fs are 44.1 kHz
Ts = 1/Fs;
N = 0.1/Ts;
noot = [noot1, noot2, noot3];


figure;
for i = 1:3
	subplot(3,1,i)
	x = resample(noot(:,i),p,q);
	spectrogram(x, N, round(N/2), [], Fs*ratio, 'yaxis');
	%note = notes(110,Fs/2);
	%set(gca,'YTick',note.freq)
	%set(gca,'YTickLabel',note.name)
	title(['Noot ', num2str(i)])
end

% We cannot make the YTicks work, so the notes will be identified "manually" :
% noot3: 350 Hz -> F
% noot2: 260 Hz -> C
% noot1: 440 Hz -> A 

%% Exercise 3.2.1 : computation of random filter impulse response
close all;

coeff = rand(10,1);
impulse = [1 0 0 0 0 0 0 0 0 0];
h = conv(coeff, impulse);
figure;
stem(h);

%% Exercise 3.2.2 : design of FIR filters
close all;

% The original sampling frequency is 44.1 kHz. Downsampled 5 times, it gives
% fs = 8820 Hz.
% The maximal frequency at which the signal can have power is fs/2 = 4410 Hz.

% The filter is designed with window design method since they offer great
% performance even if they are suboptimal, which is not a problem here.

% multiple options have been tested with fdatool
f = fir1(101,0.1,'low',kaiser(102,1));
figure;
% Plot phase and amplitude
freqz(f,1)

step = ones(1, length(f));
imp = [1 zeros(1,length(f)-1)];

figure;
subplot(2,1,1)
stem(conv(f,step));
title('Step response of the filter');
subplot(2,1,2)
stem(conv(f,imp));
title('Impulse response of the filter');

y_conv = conv(y_mono,conv(f,imp));
down_y = y_conv(1:5:end);
figure
stem(down_y)
title('Downspampled audio signal')