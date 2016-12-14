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


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    