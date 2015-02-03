# run this to perform a full analysis on a single sample
# intended for use with hardware: anechoic chamber, 
# sample stand, microphone, and speaker
# all data will be saved to the trials folder with format
# descriptor-date-time

pkg load aaudio;
pkg load ltfat;
pkg load plot;
pkg load signal;

points = 10; #number of points to test between high and low freq
minfreq = 20;
maxfreq = 20000;
fs = 48000;
t = .25;
croptime = .1; #for constant tones, cut out croptime  bad data from head
frequencies = minfreq:(maxfreq-minfreq)/points:maxfreq;
descriptor = input("sample descriptor: ", 's');

#TODO
#generate/load tones
#run trials
#save 

#constant tones test
for i=1:length(frequencies)
	fprintf("current frequency: %f\n",frequencies(i));fflush(1);
	amplitudes{i} = wavegen(frequencies(i),0,fs,t,'constant');
	times = 1/fs:1/fs:t; #all time vectors should be identical, use this one
	freqdata{i} = performtrial(amplitudes{i},fs);
	meanamplitude{i} = rms(freqdata{i}{5})*2^.5;
endfor

ztime = clock();
filename = [descriptor mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ...
            ".m"];

plotsummary(frequencies,times,amplitudes,freqdata,fs,croptime,filename);

fprintf(1,"saving data to file: %s\n",filename);fflush(1);
if exist("./trials", "file")!=7
        mkdir trials
endif
cd trials;
save(filename);
cd ..;

#sweep tones


#white noise


#aircraft noise (recorded professionally from a 737)

