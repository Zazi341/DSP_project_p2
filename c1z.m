sig = load('sig_2.mat'); % assuming the variables are 'y' and 'z'
Fs = sig.Fs;
playerObj = audioplayer(sig.z,Fs);
   start = 1;
   stop = playerObj.SampleRate * 3;
   play(playerObj,[start,stop]);   
