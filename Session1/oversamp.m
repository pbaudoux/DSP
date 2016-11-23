function oversamp(o)
% use: oversamp(o)

nsin=16; nfft=1024;
if o > (nfft/nsin)
    disp(['oversampling factor too high. Limit to ' num2str(nfft/nsin)])
elseif o < 1
    disp('Error! Choose o > 1.')
else
    disp('frequency axis 0? > 1 (digital => periodic)');
    disp('Triangle shapes are caused by low graphical resolution and intepolation by Matlab');
    % construct x as a row matrix containing nfft/nsin periods
    % of the sampled cosine
    x=cos(2*pi*(1/nsin)*(0:nfft-1));
    % draw the sampled cosine...
    subplot(2,2,1);
    plot((0:1:nsin-1), x(1:nsin) ,'.'); title('1 period cosine')
    % and its spectrum (same frequency resolution as we'll
    % later use for the oversampled case
    subplot(2,2,2);
    plot((-1/2:1/(nsin*o):1/2-1/(nsin*o)),abs(fftshift(fft(x,(nsin*o)))));
    title('Amplitude spectrum')
    % construct the oversampled signal; The buffer now contains
    % (nfft/nsin)/o periods.The original cosine had a period nsin.
    xo=zeros(1,nsin*o);
    for i=0:nsin-1
        xo(i*o+1)=x(i+1);
    end
    % plot the oversampled signal...
    subplot(2,2,3), plot(xo,'r.');
    title([num2str(o),'-fold oversampling']);
    % ... and its spectrum
    subplot(2,2,4);
    plot((-1/2:1/(nsin*o):1/2-1/(nsin*o)), abs(fftshift(fft(xo,nsin*o))));
    title('Spectrum after oversampling');
end