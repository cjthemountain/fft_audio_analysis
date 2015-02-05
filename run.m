# run this to perform a full analysis on a single sample
# intended for use with hardware: anechoic chamber, 
# sample stand, microphone, and speaker
# all data will be saved to the trials folder with format
# descriptor-date-time

pkg load aaudio;
pkg load ltfat;
pkg load plot;
pkg load signal;
clear all;

points = 20; 
minfreq = 20;
maxfreq = 20000;
fs = 48000;
tsweep = 20;
tconstant = tsweep/points;
croptime = .1; #for constant tones, cut out croptime  bad data from head
tconstant=tconstant+croptime;
frequencies = minfreq:(maxfreq-minfreq)/points:maxfreq;
plotnumber = 1;
descriptor = "";

while (length(descriptor)==0)
	fprintf(1,"please enter the material identifier. This should be unique to the sample.\n");
	fflush(1);
	descriptor = input("sample descriptor: ", 's');
endwhile

#TODO
#generate/load tones
#run trials
#save 

#constant tones test
fprintf(1,"constant tones\n");fflush(1);
for i=1:length(frequencies)
	fprintf("current frequency: %f\n",frequencies(i));fflush(1);
	amplitudes{i} = wavegen(frequencies(i),0,fs,tconstant,'constant');
	times = 1/fs:1/fs:tconstant; #all time vectors should be identical, use this one
	freqdata{i} = performtrial(amplitudes{i},fs);
	meanamplitude(i) = rms(freqdata{i}{5})*2^.5;
endfor

ztime = clock();
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ...
            "-constant" ".m"];

plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,croptime,filename, plotnumber);

fprintf(1,"saving data to file: %s\n",filename);fflush(1);
if exist("./trials", "file")!=7
        mkdir trials
endif
cd trials;
save(filename);
cd ..;
clear amplitudes ans filename freqdata  i maxfreq meanamplitude minfreq times ztime;

#sine sweep tones
fprintf(1,"\nsin sweep tone\n");fflush(1);
fprintf("frequency range =  [%f %f]\n",min(frequencies), max(frequencies));fflush(1);
amplitudes{1} = wavegen(min(frequencies),max(frequencies),fs,tsweep,'linearsweep');
times = 1/fs:1/fs:tsweep; 
freqdata{1} = performtrial(amplitudes{1},fs);
meanamplitude{1} = rms(freqdata{1}{5})*2^.5;

ztime = clock();
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ...
            "-sweep" ".m"];

plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,0,filename, plotnumber);

fprintf(1,"saving data to file: %s\n",filename);fflush(1);
if exist("./trials", "file")!=7
        mkdir trials
endif
cd trials;
save(filename);
cd ..;
clear amplitudes ans filename freqdata  i maxfreq meanamplitude minfreq times ztime;

#aircraft noise (recorded professionally from a 737)
fprintf(1,"\n737 aircraft noise\n");fflush(1);
fprintf("frequency range =  [%f %f]\n",min(frequencies), max(frequencies));fflush(1);
[amplitudes{1},fs_sample,format_sample]  = auload("./media/Background Noise 737 on ground .wav");
amplitudes{1} = amplitudes{1}';
times = 1/fs_sample:1/fs_sample:(size(amplitudes{1},2)/fs_sample);
freqdata{1} = performtrial(amplitudes{1},fs_sample);
meanamplitude{1} = rms(freqdata{1}{5})*2^.5;

ztime = clock();
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ...
            "-737" ".m"];

plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,0,filename, plotnumber);

fprintf(1,"saving data to file: %s\n",filename);fflush(1);
if exist("./trials", "file")!=7
        mkdir trials
endif
cd trials;
save(filename);
cd ..;
clear all;
