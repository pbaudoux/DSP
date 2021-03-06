clear;
close all;

%% Exercise 5.2.1 : single echo

% A: the single echo filter is a FIR filter since the output is a function
% of the input samples only.

% The impulse response of the filter is in the form:
% imp = [1, zeros(1,D-1), a]; 
% with a=attenuation and D=delay

fs = 100;
j = 1;
for t = 1:1/fs:2
	sin1(j) = sin(2*pi*10*t);
	j = j+1;
end

a = [0.8 0.5 0.2];    % attenuation
D = [10  50  100];	  % delay, in number of samples

% Plot output for different values of delay and attenuation
figure;
subplot(2,2,1);
stem(sin1)
title('Input Signal')
for i=1:3
    imp = [1, zeros(1,D(i)-1), a(i)];
    filter_output = conv(sin1,imp);
    subplot(2,2,i+1);
    stem(filter_output);
    title(['Output with a = ', num2str(a(i)), ' and D = ', num2str(D(i))]);
end
    
%% Exercise 5.2.2 : higher-order echos

% A: Again, this is a FIR filter since the output at time k only depends on
% the present and past input.
% The function createCoeff returns the coefficients b_i of the FIR equation

% Applying it to start.wav with various parameter values
a = [0.8 0.5 0.3];
D = [10  50  100];
K = [30, 20, 10];    

figure;
subplot(2,2,1);
[start, Fs] = audioread('start.wav');
plot(start);
title('Input Signal')

for i=1:3
    coeff = createCoeff(K(i), a(i), D(i));
    filter_output = filter(coeff, 1, start);
    subplot(2,2,i+1);
    plot(filter_output);
    title(['Output with a = ', num2str(a(i)), ' D = ', num2str(D(i))...
        , ' and K = ', num2str(K(i))]);
end
    
% Impulse response of the filter

figure;
a = [0.5 1 1.5];
K = 20;
D = 10;

for i = 1:3
    subplot(3,1,i)
    coeff = createCoeff(K, a(i), D);
    [h, t] = impz(coeff, 1);
    plot(t,h);
    title(['Impulse response with a = ',num2str(a(i))]);
end

% The impulse response is 1+K*D long.
% A: when a > 1, the impulse at the input is amplified up to the point when
% the impulse response stops. The filter is still stable because any causal
% FIR filter is stable.
% When a = 1, the impulse is maintained up to the end.
% When a < 1, the impulse is fading.



%% Exercise 5.2.3 : Full echo

D = 10;
a = 0.5;

% coefficients of IIR
b_i = 1;
a_i = [1 zeros(1,D-1) a];

figure;
subplot(2,1,1)
plot(start)
title('Input signal');
subplot(2,1,2)
output = filter(b_i,a_i,start);
plot(output)
title('Output of the IIR filter');
    
%% Exercise 5.3.1 : Notch filter


w0 = 2*pi/5;
a = 0.9;

zer = [ exp(sqrt(-1)*w0), -exp(sqrt(-1)*w0) ];  % zeros of TF
pol = [ a*exp(sqrt(-1)*w0), -a*exp(sqrt(-1)*w0) ];  % poles of TF

b = poly(zer);
a = poly(pol);

freqz(b,a);
title('Notch Filter frequency response, w0 = 2pi/5')

%% Exercise 5.3.2 : Application

[data, Fs] = audioread('strtnoise.wav');
cancel_freq = 50;     %frequency to cancel
w0 = 2*pi*cancel_freq/Fs;
a = 0.9;

zer = [ exp(sqrt(-1)*w0), -exp(sqrt(-1)*w0) ];      % zeros of TF
pol = [ a*exp(sqrt(-1)*w0), -a*exp(sqrt(-1)*w0) ];  % poles of TF
b = poly(zer);
a = poly(pol);

filtered = filter(b,a,data);

% Frequency response
figure;
freqz(b,a);
title('Notch Filter frequency response, cancels 50Hz')

% Plot the result of the filtering
figure;
subplot(2,2,1)
plot(data);
title('Original Signal')
subplot(2,2,2)
nfft = 1024;
semilogy((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(data,nfft))));
title('Original signal frequency content');
subplot(2,2,3)
plot(real(filtered));
title('Filtered Signal')
subplot(2,2,4)
semilogy((-1/2:1/nfft:1/2-1/nfft), abs(fftshift(fft(filtered,nfft))));
title('Filtered signal, frequency content');

% Study of the transient length

j = 1;
for t = 1:1/Fs:3
	sin50(j) = sin(2*pi*50*t);
	j = j+1;
end

input = [zeros(1,10000), sin50];
output = filter(b,a,input);

figure;
subplot(2,1,1)
plot(input)
title('Input signal');
subplot(2,1,2)
plot(real(output))
title('Output signal');

% A: Zooming on the picture, the transient seems to last moreover half a
% period of the sinewave. However, the amplitude is never reduced to less
% than 10 percent of the original amplitude, the factor a has to be
% increased.
    
    
    
    
    
    