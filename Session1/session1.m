clear;
close all;


%% Exercise section 1.1.3 

i = 1;
A = 1;
f_0 = 400;
f_s = 3200;

for t=0.001:1/f_s:0.006
    s(i) = A*sin(2*pi*f_0*t);
    i = i + 1;
end

% Compute and plot first sinusoid
figure;
stem(s)
title('400 Hz sine sampled at 3200 Hz');
xlabel('Sample');
ylabel('Amplitude');

% A : the scale of the horizontal axis is the sample number (integer)

% Compute and plot second sinusoid
i = 1;
f_1 = 800;
phi = 0;
f_s1 = 6400;
for t=0.0005:1/f_s1:0.003
    s2(i) = A*sin(2*pi*f_1*t);
    i = i + 1;
end

figure;
stem(s2)
title('800 Hz sine sampled at 6400 Hz');
xlabel('Sample');
ylabel('Amplitude');

% Compute and the difference between the two

for i = 1:length(s)
    diff(i) = s(i) - s2(i);
end

figure;
stem(diff);
title('Difference between the two sampled versions');
xlabel('Sample');
ylabel('Amplitude');

% A: the sampled versions are identical

% Computing the time scales and plot
t1 = 0.001:1/f_s:0.006;
t2 = 0.0005:1/f_s1:0.003;

figure;
subplot(2,1,1), stem(t1,s);
title('400 Hz sine sampled at 3200 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2), stem(t2,s2);
title('800 Hz sine sampled at 6400 Hz');
xlabel('Time (s)');
ylabel('Amplitude');

for i = 1:51;
    x4(i) = cos(pi*(i-1)/sqrt(23));
end

figure;
stem(x4);
title('Sampled signal x4(n)');
xlabel('Sample');
ylabel('Amplitude');

% A : The sampled signal will be periodic only if the ratio between
%   the period of the signal and the sampling period is an integer,
%   which is not the case here.

%% Exercise section 1.2.1

sampling_cos;
% A : aliasing appears when f_cos > fs/2

sampling_block;
% A : there is no aliasing for the fundamental because its frequency range
% goes from 0 to fs/2. The harmonics are in a range of 0 to N*fs/2 and
% will thus be aliased

%% Exercise section 1.2.2

oversamp(4)

% A : The spectrum is modified. It is replaced around the origin and
% replicated N times, N being the oversampling factor


%% 1.3.1 : Exercise 1

% Constructing triangular signal
amplitude = 1;
elementsPerHalfPeriod = 32;
risingSignal = linspace(0, amplitude, elementsPerHalfPeriod);
fallingSignal = linspace(amplitude, 0, elementsPerHalfPeriod);
tri = [risingSignal, fallingSignal(2:end-1)];
Nfft = 1024;

% Going to frequency domain then back to time domain 
% and plotting for various values of subsample factor

figure;
subplot(3,2,1)
stem(tri)
title('Initial triangular signal');
xlabel('Sample');
ylabel('Amplitude');
for N = 1:5
    s_out = time2time(N,tri,Nfft);
    subplot(3,2,N+1)
    stem(s_out);
    title(['signal reconstructed with N = ', num2str(N)]);
    xlabel('Sample');
    ylabel('Amplitude');
    xlim([0 length(s_out)]);
end

% Answers to the questions :

% A : The signal is reconstructed and is followed by samples of value 0.
%   The number of zeros is related to the length of the FFT, and thus the
%   higher the subsampling factor, the less zeros following the signal.
%   When Nfft/N is not an integer, the signal is not correctly
%   reconstructed (here for N=3, N=5).

% A : The useful signal has always the same number of samples but the
% actual computed signal is longer when N (the subsampling factor)
% is smaller because of the zeros.

% A : In order to avoid time-domain aliasing, it is necessary to compute at
% least the same amount of samples in the frequency domain as there are
% samples the initial time domain signal. Illustration :
% One case with enough frequency samples and one with not enough samples.

% Illustration
elementsPerHalfPeriod = 128;
risingSignal = linspace(0, amplitude, elementsPerHalfPeriod);
fallingSignal = linspace(amplitude, 0, elementsPerHalfPeriod);
tri = [risingSignal, fallingSignal(2:end-1)];

figure;
subplot(2,1,1)
s_out = time2time(1,tri,1024);
stem(s_out);
title('signal reconstructed with enough frequency samples');
xlabel('Sample');
ylabel('Amplitude');
xlim([0 length(s_out)]);
subplot(2,1,2)
s_out = time2time(8,tri,1024);
stem(s_out);
title('signal reconstructed with NOT enough frequency samples');
xlabel('Sample');
ylabel('Amplitude');
xlim([0 length(s_out)]);



%% 1.3.1 : Exercise 2
f1 = 500;
f2 = 1000;
fs = 750:500:4250;
figure;
for i = 1:length(fs)
    k=1;
    for j = 0:1/fs(i):0.01
        s(i,k) = cos(2*pi*f1*j)*cos(2*pi*f2*j);
        k = k+1;
        subplot(4,2,i);
        plot(s(i,:));
        title(['Signal sampled at fs = ', num2str(fs(i)), ' Hz']);
        xlabel('Sample');
        ylabel('Amplitude');
        xlim([0 length(s(i,:))]);
    end
end

% A : the minimal theoretical sampling frequency is 3 kHz  (due to the 
% product of the cos). It can be seen % on the plot that the correct shape 
%can be retrieved starting from fs = 3250 Hz.
