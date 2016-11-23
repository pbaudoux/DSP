%%
% Digital Signal Processing exercise session 2

clear all;
close all;

%%
% Exercice 2.1.1

[yid, Fs] = audioread('oef2id.wav');
ytestid = yid(1:256);
nfft = 256;
figure;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(ytestid,nfft))));

% A : frequencies are easily recovered thanks to tthe DFT. Not that if the
% sampling frequency does not respect the nyquist rate, the frequencies 
% could have been subject to aliasing, and the identified frequencies would
% thus be alises

%%
% Exercise 2.1.2

[yni, Fs] = audioread('oef2ni.wav');
ytestni = yni(1:256);
nfft = 256;
figure;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(ytestni,nfft))));

% A : the frequencies are slightly shifted, and the frequency peaks are
% thicker and thus less precise.

% Analysis of the signal repetition
yrid = [yid(1:256); yid(1:256); yid(1:256); yid(1:256)];
yrni = [yni(1:256); yni(1:256); yni(1:256); yni(1:256)];

figure;
subplot(2,1,1);
stem(yrid-yid);
title('Ideal scenario : difference between original and reconstructed signals');
subplot(2,1,2);
stem(yrni-yni);
title('Non-ideal scenario : difference between original and reconstructed signals');

% A : It appears that the ideal case is the case where 256 samples is the
% period (or a multiple of the period) of the signal.
% In the non-ideal case, it is not true and thus the repetition of the
% signal every 256 samples does really correspond to the actual signal.

% Analysis of the effect of different windows
% wintool was used to create window_rect, window_hann and window_flat

close all;
load('hann.mat');
load('rect.mat');
load('flat.mat');

figure;
subplot(3,1,1)
y_rect = ytestni.*window_rect;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(y_rect,nfft))));
title('FFT with rectangular window')
subplot(3,1,2)
y_hann = ytestni.*window_hann;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(y_hann,nfft))));
title('FFT with Hann window')
subplot(3,1,3)
y_flat = ytestni.*window_flat;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(y_flat,nfft))));
title('FFT with flat top window')

% A : the Hann window allows to have peaks that are more precisely
% definite. The flat top window gives peaks with flat tops, but their
% amplitude is lower.


%%
% Exercise 2.1.3

close all;
y_padd_id = [ytestid; zeros(3840, 1)];
y_padd_ni = [ytestni; zeros(3840, 1)];

% Analysis of DFT length

nfft1 = 256;
nfft2 = 4096;
figure;
subplot(2,2,1)
plot((-1/2:1/nfft1:1/2-1/nfft1), abs(fftshift(fft(y_padd_id,nfft1))));
title('Ideal case - 256');
subplot(2,2,2)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padd_id,nfft2))));
title('Ideal case - 4096');
subplot(2,2,3)
plot((-1/2:1/nfft1:1/2-1/nfft1), abs(fftshift(fft(y_padd_ni,nfft1))));
title('Non-ideal case - 256');
subplot(2,2,4)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padd_ni,nfft2))));
title('Non-ideal case - 4096');

% A : The length of the DFT allows to have more frequency samples but does
% not increase the precision. In the non ideal case, the peaks are still
% thick.

% Effect of window length


