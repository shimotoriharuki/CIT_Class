
function [Pyn, fn] = spec_fun1(t,y,Fs,flag)
ny = length(y);
f = Fs * (0:ny-1)/(ny-1);
Py = 20*log10(abs(fft(y)));

fn = f(1: (ny+1)/2);
Pyn = Py(1:(ny+1)/2);

if flag == 1
    subplot(211), plot(t, y), title("Time Domain"), xlabel("Time[s]")
    subplot(212), plot(t, Py), title("Freq Domain"), xlabel("Freq[Hz]")

end
