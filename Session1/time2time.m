function s_out = time2time(N,s,Nfft)
%%%
% Compute the FFT of the signal s, then subample the frequency domain by a
% factor N, then compute the inverse FFT
%%%
   
    S = fft(s,Nfft);
    S_sub = S(1:N:length(S));
    s_out = ifft(S_sub);

end