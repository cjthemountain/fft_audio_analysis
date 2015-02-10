#constant tone tests
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

