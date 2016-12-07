clear;
close all;

%% Exercise 4.1.2

b1 = firls(1,[0 1],[0 pi],'differentiator');
%fvtool(b1,1,'freq');

% The fvtool allows to see that he amplitude is not linear as  the ideal 
% differentiator is, but has a sinusoidal shape instead. The phase is linear.

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



