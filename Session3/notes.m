
function note = notes(beginfreq,endfreq)

% note = notes(beginfreq,endfreq)
% 
% This function returns a structure with two fields: name, freq. The name
% field contains the names of the notes (first octave only) and the freq
% field contains the frequencies of all notes that lay between the start
% and stop frequencies, where the start frequency is the frequency of
% the note corresponding to the frequency that is the nearest to beginfreq,
% and the stop frequency is the frequency of the highest note of which the frequency
% is smaller than endfreq. Only the first octave of the names of the notes
% that correspond to the frequencies in the freq field is given, the rest can
% be found by a repetition of these names.
% 
% example of use with spectrogram:
% figure;
% spectrogram(signal,hann(Nwindow),Noverlap,Nfft,fs,'yaxis');
% note = notes(110,fs/2);
% set(gca,'YTick',note.freq)
% set(gca,'YTickLabel',note.name)

if beginfreq <= 0
    error('begin frequency should be larger than 0')
end

step = 2^(1/12);

names = {'a' 'a#' 'b' 'c' 'c#' 'd' 'd#' 'e' 'f' 'f#' 'g' 'g#'};
freqs(1) = 110;
for i = 2 : 12;
    freqs(i) = freqs(i-1)*step;
end

freqratio = max(beginfreq,freqs)./min(beginfreq,freqs);
smallerpowof2 = 2.^(floor(log2(freqratio)));
largerpowof2 = 2.^(ceil(log2(freqratio)));
diff = abs([freqratio-smallerpowof2; freqratio-largerpowof2]);
powof2 = [smallerpowof2; largerpowof2];
% nearestpowof2 = powof2(find(repmat(min(diff),2,1)==diff)))
nearestpowof2 = powof2(find(min(min(diff))==diff));
nearestpowof2 = nearestpowof2(1);
firstindex = find(min(diff)==min(min(diff)));

for i = 1 : 12
    note.name{i} = names{mod(firstindex+(i-1)-1,12)+1};
end


i = 1;
note.freq(1) = (max(beginfreq,freqs(firstindex))==beginfreq)*freqs(firstindex)*nearestpowof2+~(max(beginfreq,freqs(firstindex))==beginfreq)*freqs(firstindex)/nearestpowof2;
while note.freq(i)<=endfreq
    i = i + 1;
    note.freq(i) = note.freq(i-1)*step;
end

note.freq = note.freq(1:end-1);