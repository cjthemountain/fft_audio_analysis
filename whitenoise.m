#white noise (generated gaussain distribution capped at [-1 1]) 
fprintf(1,"\nwhite noise\n");fflush(1); 
fprintf("generating white noise between [%f %f] for %f seconds\n",min(frequencies), max(frequencies), tnoise);fflush(1); 
amplitudes{1}  = wavegen(0,20000,fs,tnoise,'whitenoise'); 
amplitudes{1} = amplitudes{1}'; 
times = 1/fs:1/fs:(size(amplitudes{1},2)/fs); 
fprintf(1,"running trial\n");fflush(1);
freqdata{1} = performtrial(amplitudes{1},fs); 

for i=1:40
	sorted{i}=[];
endfor

fprintf(1,"sorting data by third octave iso standard\n");fflush(1);
j=0;
for i=1:size(freqdata{1}{4},1) #for each frequency in the fft
	thisfrequency = freqdata{1}{3}(i);
	fftdata = freqdata{1}{4}(i);
	values = thirdoctaverange(thisfrequency);
	z = values.isonumber-10;
	if z>0
		sorted{z} = [sorted{z}; freqdata{1}{4}(i)];
	endif
	if j==500
		percentcomplete = i/length(freqdata{1}{4})*100;
		fprintf(1,"%f%% sorted\n",percentcomplete);fflush(1);
		j=0;
	endif
	j++;
endfor

fprintf(1,"\nperforming inverse fft\n");fflush(1);
for i=1:length(sorted)
	isorted{i} = ifft(sorted{i});
	meanamplitude{i} = rms(isorted{i})*2^.5; #rms(sorted{i})*2^.5;
endfor

fprintf(1,"calculating means\n");fflush(1);
for i=1:length(meanamplitude)
	if length(meanamplitude{i})!=0
		meanamplitudes(i) = meanamplitude{i};
		values = thirdoctaverange(meanamplitudes(i));
		isonumbers(i) = values.isonumber;
	endif
endfor
isorange = linspace(13,max(isonumbers),length(meanamplitudes));

ztime = clock(); 
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ...  
            "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ... 
            "-whitenoise" ".m"]; 
 
#plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,croptime,filename, plotnumber); 
 
fprintf(1,"saving data to file: %s\n",filename);fflush(1); 
if exist("./trials", "file")!=7 
        mkdir trials 
endif 
cd trials; 
save(filename); 
cd ..; 
