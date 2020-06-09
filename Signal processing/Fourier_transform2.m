
[x,fs] = audioread("voice/audio_a.wav");

y = fft(x);
t = 0:1/fs:10-1/fs;                      % 10 second span time vector

n = length(x);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT

y0 = fftshift(y);         % shift y values
f0 = (-n/2:n/2-1)*(fs/n); % 0-centered frequency range
power0 = abs(y0).^2/n;    % 0-centered power

plot(f0,power0)
xlabel('Frequency')
ylabel('Power')


