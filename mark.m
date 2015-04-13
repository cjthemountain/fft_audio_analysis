fs = 48000;
time = 10;
noise = wavegen(233,1000,fs,time,'constant');
freqdata{1} = performtrial(noise,fs);

#plot
subplot(2,1,1); hold on;
plot(linspace(1/fs,fs*time,fs*time), noise, 'b');
plot(linspace(1/fs,fs*time,fs*time), freqdata{1}{5}, 'r--');
title("time domain");
legend("played signal", "recorded signal");
axis([0 fs*time -1.1 1.1]);

subplot(2,1,2); hold on;
plot(freqdata{1}{3}, freqdata{1}{4}, 'r--');
plot(freqdata{1}{1}, freqdata{1}{2}, 'b');
title("frequency domain");
legend("recorded signal", "played signal");
axis([0 20000 0 250]);

high = max(real(freqdata{1}{5}));
low = min(real(freqdata{1}{5}));
fprintf(1,"max: %f\n", high);
fprintf(1,"min: %f\n", low);
fprintf(1,"peak2peak: %f\n", high-low);
fprintf(1,"\n");
