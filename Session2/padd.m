function y_padded = padd(y, N)

padded_len = N-length(y);
y_padded = [y; zeros(padded_len, 1)];

end