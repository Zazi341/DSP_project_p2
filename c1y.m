sig = load('sig_2.mat'); %load sig_2
Fs = sig.Fs; % = 8192 Hz
playerObj = audioplayer(sig.y,Fs); %play the audio
   start = 1;
   stop = playerObj.SampleRate * 3;
   play(playerObj,[start,stop]);   
