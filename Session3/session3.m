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


% figure;
% for i = 1:3
% 	subplot(3,1,i)
% 	spectrogram(noot(:,i), N, round(N/2), [], Fs, 'yaxis');
% 	note = notes(110,Fs/2);
% 	set(gca,'YTick',note.freq)
% 	set(gca,'YTickLabel',note.name)
% 	title(['Noot ', num2str(i)])
% end

figure;
spectrogram(noot1, N, round(N/2), [], Fs, 'yaxis');
note = notes(170,Fs/2);
set(gca,'YTick',note.freq)
set(gca,'YTickLabel',repmat(note.name,1,7))
title('Noot 1')

length(note.freq)/length(note.name)