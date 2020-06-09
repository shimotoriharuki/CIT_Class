
[y_a,Fs_a] = audioread("voice/audio_a.wav");
Y_a = fft(y_a);
f_a = (0:length(Y_a)-1)*50/length(Y_a);
subplot(2, 1, 1);
plot(y_a);
title("voice_a");

subplot(2, 1, 2);
plot(f_a,abs(Y_a))
title("fft_a");





[y_i,Fs_i] = audioread("voice/audio_i.wav");
Y_i = fft(y_i);
f_i = (0:length(Y_i)-1)*50/length(Y_i);

hold on
subplot(2, 1, 1);
plot(y_i);
title("voice_i");

subplot(2, 1, 2);
plot(f_i,abs(Y_i))
title("fft_i");
hold off




[y_u,Fs_u] = audioread("voice/audio_u.wav");
Y_u = fft(y_u);
f_u = (0:length(Y_u)-1)*50/length(Y_u);

hold on
subplot(2, 1, 1);
plot(y_u);
title("voice_u");

subplot(2, 1, 2);
plot(f_u,abs(Y_u))
title("fft_u");
hold off





[y_e,Fs_e] = audioread("voice/audio_e.wav");
Y_e = fft(y_e);
f_e = (0:length(Y_e)-1)*50/length(Y_e);

hold on
subplot(2, 1, 1);
plot(y_e);
title("voice_e");

subplot(2, 1, 2);
plot(f_e,abs(Y_e))
title("fft_e");
hold off


[y_o,Fs_o] = audioread("voice/audio_o.wav");
Y_o = fft(y_o);
f_o = (0:length(Y_o)-1)*50/length(Y_o);

hold on
subplot(2, 1, 1);
plot(y_o);
title("voice_o");

subplot(2, 1, 2);
plot(f_o,abs(Y_o))
title("fft_o");
hold off

xlim([40 50]);







