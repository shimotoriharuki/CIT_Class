%{
SampleRate: 8000
    BitsPerSample: 8
      NumChannels: 1
         DeviceID: -1
    CurrentSample: 1
     TotalSamples: 0
          Running: 'off'
         StartFcn: []
          StopFcn: []
         TimerFcn: []
      TimerPeriod: 0.0500
              Tag: ''
         UserData: []
             Type: 'audiorecorder'
%}

recObj = audiorecorder;

disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.')

play(recObj);

y = getaudiodata(recObj);
plot(y);