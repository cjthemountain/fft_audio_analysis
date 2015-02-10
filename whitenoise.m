#white noise (generated gaussain distribution capped at [-1 1]) 
fprintf(1,"\nwhite noise\n");fflush(1); 
fprintf("frequency range =  [%f %f]\n",min(frequencies), max(frequencies));fflush(1); 
amplitudes{1}  = wavegen(0,20000,fs,10,'whitenoise'); 
amplitudes{1} = amplitudes{1}'; 
times = 1/fs:1/fs:(size(amplitudes{1},2)/fs); 
freqdata{1} = performtrial(amplitudes{1},fs); 
meanamplitude{1} = rms(freqdata{1}{5})*2^.5; 
 
ztime = clock(); 
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ...  
            "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ... 
            "-whitenoise" ".m"]; 
 
plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,0,filename, plotnumber); 
 
fprintf(1,"saving data to file: %s\n",filename);fflush(1); 
if exist("./trials", "file")!=7 
        mkdir trials 
endif 
cd trials; 
save(filename); 
cd ..; 
clear all;
