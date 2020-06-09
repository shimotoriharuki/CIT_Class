import_file_name = "voice/audio_800Hz.wav";
save_file_name_p = "figure/voice_800Hz.jpg";
save_file_name_f = "figure/voice_800Hz.fig";

[x,fs] = audioread(import_file_name);

plot_number = 3;

voive_part = x(1.5e4:4.0e4);    %1.5e4����4.0e4�܂ŉ�����؂���
t = (0:1/fs:(length(voive_part)-1)/fs);

subplot(plot_number, 1, 1);
plot(t,voive_part)
xlabel('����[s]')
ylabel('�U��')
xlim([0 t(end)])
title('�؂��������� "800Hz"')

m = length(voive_part);       % original sample length
n = pow2(nextpow2(m));        % transform length
y = fft(voive_part,n);        % DFT of signal

f = (0:n-1)*(fs/n);
power = abs(y).^2/n;   

subplot(plot_number, 1, 2);
plot(f(1:floor(n/2)),power(1:floor(n/2)))
xlabel('���g��[Hz]')
ylabel('�p���[')
title('�p���[�X�y�N�g��')
xlim([0 1000])

subplot(plot_number, 1, 3);
pspectrum(voive_part, fs, 'spectrogram', 'MinThreshold',-60, 'FrequencyLimits',[0, 1000])
title('�X�y�N�g���O����')

saveas(gcf,save_file_name_p)
saveas(gcf,save_file_name_f)

