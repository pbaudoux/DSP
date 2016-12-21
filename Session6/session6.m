clear;
close all;

[sign, Fs] = audioread('sign.wav');
[myst, Fs2] = audioread('mystery_x.wav');


figure;
Ts = 1/Fs;
N = 0.1/Ts;
spectrogram(sign, N, round(N/2), [], Fs, 'yaxis');


figure;
Ts2 = 1/Fs2;
N2 = 0.1/Ts2;
spectrogram(myst, N2, round(N2/2), [], Fs2);
ax = gca;
ax.YDir = 'reverse';

% The secret message in sign is DSSP
% The secret message in mystery_x is Merry Christmas