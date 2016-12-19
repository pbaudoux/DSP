%%
% Digital Signal Processing exercise session 2

clear;
close all;

%%
% Exercice 2.1.1

[yid, Fs] = audioread('oef2id.wav');
ytestid = yid(1:256);
nfft = 256;
figure;
plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(ytestid,nfft))));

% A : frequencies are easily recovered thanks to the DFT. Not that if the
% sampling frequency does not respect the nyquist rate, the frequencies 
% could have been subject to aliasing, and the identified frequencies would
% thus be aliases

%%
% Exercise 2.1.2

[yni, Fs] = audioread('oef2ni.wav');
ytestni = yni(1:256);
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
% The DFT seen as as a Fourier series considers that the input signal is a 
% period of a periodic signal, which is not the case in general

% Analysis of the effect of different windows
% wintool was used to create window_rect, window_hann and window_flat

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
% defined. The flat top window gives peaks with flat tops, but their
% amplitude is lower.
% The rectangular window actually corresponds to what was done first, when
% exctracting directly samples from the signal.


%%
% Exercise 2.1.3

y_padd_id = [ytestid; zeros(3840, 1)];
y_padd_ni = [ytestni; zeros(3840, 1)];

% Analysis of the impact of DFT length

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
% The ideal, 4096 points should not look like this, it  should be in the
% same shape as with 256 points but with more samples.

% Analysis of the impact of window length
figure;
win = window(@rectwin,256);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,1)
plot((-1/2:1/nfft1:1/2-1/nfft1), abs(fftshift(fft(y_padded,nfft1))));
title('Ideal case - 256 rectangluar window');

win = window(@rectwin,512);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,2)
plot((-1/2:1/nfft1:1/2-1/nfft1), abs(fftshift(fft(y_padded,nfft1))));
title('Ideal case - 512 rectangluar window');

win = window(@rectwin,1024);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,3)
plot((-1/2:1/nfft1:1/2-1/nfft1), abs(fftshift(fft(y_padded,nfft1))));
title('Ideal case - 1024 rectangluar window');

win = window(@hann,256);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,4)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 256 hann window');

win = window(@hann,512);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,5)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 512 hann window');

win = window(@hann,1024);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,6)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 1024 hann window');

win = window(@flattopwin,256);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,7)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 256 flat top window');

win = window(@flattopwin,512);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,8)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 512 flat top window');

win = window(@flattopwin,1024);
y = yid(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,9)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Ideal case - 1024 flat top window');

figure
win = window(@rectwin,256);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,1)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 256 rectangluar window');

win = window(@rectwin,512);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,2)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 512 rectangluar window');

win = window(@rectwin,1024);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,3)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 1024 rectangluar window');

win = window(@hann,256);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,4)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 256 hann window');

win = window(@hann,512);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,5)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 512 hann window');

win = window(@hann,1024);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,6)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 1024 hann window');

win = window(@flattopwin,256);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,7)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 256 flat top window');

win = window(@flattopwin,512);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,8)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 512 flat top window');

win = window(@flattopwin,1024);
y = yni(1:length(win));
y_win = y.*win;
y_padded = padd(y_win, nfft2);
subplot(3,3,9)
plot((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(y_padded,nfft2))));
title('Non-ideal case - 1024 flat top window');

% A : it appears that the length of the window, regardless of the ideality
% or of the type of window, allows to increase the precision of the DFT.
% The amplitude of the peaks is higher and these peaks are less thick.


%%
% Exercise 2.2

[x, fs] = audioread('oef2mul.wav');

win = window(@hann,256);
xp = x(1:length(win));
x_win = xp.*win;
x_padded = padd(x_win, nfft2);

figure;
semilogy((-1/2:1/nfft2:1/2-1/nfft2), abs(fftshift(fft(x_padded,nfft2))));
title('Frequency content');

% A : the first peak is located at (0.1282;40.98) and the second at (0.1863;0.03121)

disp(['The first frequency content is at ', num2str(0.1282*fs), ' Hz']);
disp(['The second frequency content is at ', num2str(0.1863*fs), ' Hz and is ',...
    num2str(db2mag(40.98)/db2mag(0.03121)), ' times less strong']);

% The first frequency content is at 4102.4 Hz
% The second frequency content is at 5961.6 Hz and is 111.5423 times less strong













