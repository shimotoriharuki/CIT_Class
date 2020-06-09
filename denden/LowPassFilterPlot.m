% low pass filter plot

freq2 = (200:100:1000);
freq1 = (10:10:100);
freq = horzcat(freq1, freq2);
freq(1 , 1) =10; 
sin_AM = 100;
sin_T = 1 ./ freq/4;
T = 1 ./ freq;

      %10    20   30   40   50   60     70   80   90  100   200   300   400   500   600   700   800   900 1000
Am = [98.32, 94 , 88, 82.5 ,77,  72,  67.8,  64,  60,  57, 37.1, 27.3, 21.5, 17.8, 15.0, 12.9, 11.4, 10.0, 9.2]; %振幅データ
db = mag2db(Am); %デシベル変換
data_T = [0.02872, 0.0153, 0.011, 0.0086, 0.0072, 0.0062, 0.0055, 0.0049, 0.0044, 0.004, 0.0022, 0.00155, 0.0012, 0.000975, 0.00082, 0.000707, 0.00062, 0.000552, 0.000498]; %山の時間
              %10       20     30     40      50      60      70      80     90     100     200     300      400     500      600     700      800      900 1000    
T_diff = sin_T - data_T; %時間差
Phase_diff = (T_diff ./ T) * 2 * pi;%位相差[rad]
Phase_diff = rad2deg(Phase_diff); %位相差[deg]

% polyfit%
% %{
p1 = polyfit(freq,Phase_diff,10);
Phase_diff_p = polyval(p1,freq);
p2 = polyfit(freq,db,4);
db_p = polyval(p2,freq);
% %}

% fit%
%{
f=fit(freq', Phase_diff', 'exp2');
%}

% %{
% subplot(2,1,1);
% plot(f,freq, Phase_diff);
grid on
yyaxis right
semilogx(freq, Phase_diff_p, "--ob");
ylabel('位相差[deg]')


% subplot(2,1,2);
yyaxis left
semilogx(freq, db_p, "-xb");
ylabel('振幅[db]')
xlabel('周波数[Hz]')
legend('振幅', '位相差')
% %}

title('ローパスフィルタの周波数特性')

