#compare two wav files in time and frequency domains

[anc_on,anc_on_fs,anc_on_bps]  = wavread("clippedAudio/anc_on.wav");
[anc_off,anc_off_fs,anc_off_bps]  = wavread("clippedAudio/anc_off.wav");

[anc_on_freq,anc_on_amp] = time2freq(anc_on,anc_on_fs); 
[anc_off_freq,anc_off_amp] = time2freq(anc_off,anc_off_fs); 

#plot the time domain data
subplot(2,1,1);
hold on;
plot(anc_off, 'r--');
plot(anc_on, 'b--');
title("time domain");
xlabel("time (sec)");
ylabel("amplitude (d2a)");
legend("anc off", "anc on");
hold off;

#plot the frequency domain data
subplot(2,1,2);
hold on;
plot(anc_off_freq,anc_off_amp,'r--');
plot(anc_on_freq,anc_on_amp,'b--');
title("frequency domain");
xlabel("frequency");
ylabel("amplitude");
legend("off", "on");
hold off;

