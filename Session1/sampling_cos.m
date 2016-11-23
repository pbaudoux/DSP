
function sampling_cos
% sample cosines of different frequencies
% , and plot the corresponding magnitude
% spectra.
%
% use: sampling
nfft=1024;
% close all open graphs.
figure;
% main loop: generate sampled cosines with normalized frequency
% i/nfft
% (i from 0 to nfft) in steps of 56 (remark: if i ? nfft/2
% something strange will happen. Why?).
step=56;
for i=0:step:nfft
    % cconstruct matrix x as a row matrix, containing an
    % integer number of periods from the sampled cosine
    x=cos(2*pi*(i/nfft)*(0:nfft-1));
    plot((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(x,nfft))));
    title(['Amplitude spectrum (f0=', num2str(i/nfft),' & fs=1)'])
    pause(0.3)
end