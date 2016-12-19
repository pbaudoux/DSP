clear;
close all;

%% Exercise 4.1.2

b1 = firls(1,[0 1],[0 pi],'differentiator');
%fvtool(b1,1,'freq');

% A: The fvtool allows to see that he amplitude is not linear as  the ideal 
% differentiator is, but has a sinusoidal shape instead. The phase is
% linear as expected with a FIR filter.
% The result of the curvature of the amplitude of the frequency response is
% that the filter is a good approximation of a perfect differentiator only
% in a reduced frequency range.

b2 = firls(2,[0 1],[0 pi],'differentiator');
b3 = firls(3,[0 1],[0 pi],'differentiator');
b4 = firls(100,[0 1],[0 pi],'differentiator');
b5 = firls(101,[0 1],[0 pi],'differentiator');

[h1, w1] = freqz(b1, 1, 1024);
[h2, w2] = freqz(b2, 1, 1024);
[h3, w3] = freqz(b3, 1, 1024);
[h4, w4] = freqz(b4, 1, 1024);
[h5, w5] = freqz(b5, 1, 1024);

figure;
plot(w1, abs(h1), w2, abs(h2), w3, abs(h3), w4, abs(h4), w5, abs(h5));
legend('First order filter', 'Second order filter', 'Third order filter',...
	'Order 100', 'Order 101', 'location', 'northwest');
title('Magnitude response of differentiators')
xlabel('Frequency [rad/s]')
ylabel('Magnitude')
line([0 pi], [0 pi], 'LineStyle', '--', 'Color', 'k')
axis([0 pi 0 3.5])

% It is seen on the figure that when the order of the filter increases,
% the frequency range in which the filter is accurate increases.
% Moreover, when the order of the filter is even (and thus the number of
% samples of the impulse response is odd), the linear phase constraint makes
% H(pi) = 0, which makes the filter not look like a differentiator.

% Depending on the application, the filter order should be tuned so that the
% frequencies of interest can be correctly differentiated and this order should
% be odd.

% Re-computing of the filters impulse response coefficients while
% denormalizing the amplitude, and apply them to two different sine waves

fs = 10000;
f1 = 1000;
j = 1;
for t = 0:1/fs:0.05
	sin1(j) = sin(2*pi*f1*t);
	j = j+1;
end

f4 = 4000;
j = 1;
for t = 0:1/fs:0.05
	sin4(j) = sin(2*pi*f4*t);
	j = j+1;
end

b2 = firls(2,[0 1],[0 fs/2],'differentiator');
b3 = firls(3,[0 1],[0 fs/2],'differentiator');
b4 = firls(100,[0 1],[0 fs/2],'differentiator');
b5 = firls(101,[0 1],[0 fs/2],'differentiator');

% Computing derivatives of 1 kHz sine
figure;
subplot(2,2,1);
plot(conv(b2,sin1));
title('Output of second order differentiator - 1 kHz sine')
xlim([0 500]);

subplot(2,2,2);
plot(conv(b3,sin1));
title('Output of third order differentiator - 1 kHz sine')
xlim([0 500])

subplot(2,2,3);
plot(conv(b4,sin1));
title('Output of 100th order differentiator - 1 kHz sine')
xlim([0 600])

subplot(2,2,4);
plot(conv(b5,sin1));
title('Output of 101st order differentiator - 1 kHz sine')
xlim([0 600])

% Computing derivatives of 4 kHz sine
figure;
subplot(2,2,1);
plot(conv(b2,sin4));
title('Output of second order differentiator - 4 kHz sine')

subplot(2,2,2);
plot(conv(b3,sin4));
title('Output of third order differentiator - 4 kHz sine')


subplot(2,2,3);
plot(conv(b4,sin4));
title('Output of 100th order differentiator - 4 kHz sine')

subplot(2,2,4);
plot(conv(b5,sin4));
title('Output of 101st order differentiator - 4 kHz sine')

% A: It appears that in the case of the 1 kHz sine, the filters become
% more accurate when their order increase. The frequency being quite
% low with respect to the sampling frequency, the error that comes 
% from the low order or the even orders is not very significant.

% In the case of the 4 kHz sine, the second order filter is not
% accurate at all because 4kHz is close to the higher normalized
% frequencies.
% The higher order filters have good accuracy, as expected when looking at
% the frequency response of the different filters.
