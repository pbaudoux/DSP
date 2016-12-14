clear;
close all;

%% Exercise 5.2.1 : single echo



% A: the single echo filter is a FIR filter since the output is a function
% of the input samples only.

% impulse response of the filter is in the form:
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
close;
% Again, this is a FIR filter since the output at time n only depends on
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
D = 50;

for i = 1:3
    subplot(3,1,i)
    coeff = createCoeff(K, a(i), D);
    [h, t] = impz(coeff, 1);
    plot(t,h);
    title(['Impulse response with a = ',num2str(a(i))]);
end    
    
% A: when a > 1, the impulse at the input is amplified up to the point when
% the impulse response stops. The filter is still stable because any causal
% FIR filter is stable.
% When a = 1, the impulse is maintained up to the end.
% When a < 1, the impulse is fading.
    
    
    
    
    
    
    
    
    
    
    