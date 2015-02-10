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

plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs_sample,0,filename, plotnumber);

fprintf(1,"saving data to file: %s\n",filename);fflush(1);
if exist("./trials", "file")!=7
        mkdir trials
endif
cd trials;
save(filename);
cd ..;

