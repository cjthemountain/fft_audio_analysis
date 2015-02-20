#white noise (generated gaussain distribution capped at [-1 1]) 
fprintf(1,"\nwhite noise\n");fflush(1); 
fprintf("frequency range =  [%f %f]\n",min(frequencies), max(frequencies));fflush(1); 
amplitudes{1}  = wavegen(0,20000,fs,tnoise,'whitenoise'); 
amplitudes{1} = amplitudes{1}'; 
times = 1/fs:1/fs:(size(amplitudes{1},2)/fs); 
freqdata{1} = performtrial(amplitudes{1},fs); 

#meanamplitude{1} = rms(freqdata{1}{5})*2^.5;
 #GOAL: need to compare mean amplitudes of whitenoise data recorded 
                                #based on 1/3 octave levels.
#TODO: average? amplitudes within each octave level

#HOW:? evaluate the FFT of the recorded signal start to end
#for each value, use the thirdoctaverange function
	#to sort each point into a list with a member for each list
	#do IFFT on each member of the list
	#perform RMS based averaging of each octave amplitude   
	#dump those values into the meanamplitudes array

for i=1:40
	sorted{i}=[];
endfor

fprintf(1,"size of freqdata{1}{4},1: %d\n", size(freqdata{1}{4},1));
for i=1:size(freqdata{1}{4},1) #for each frequency in the fft
	temp = real(freqdata{1}{4}(i));
	values = thirdoctaverange(temp);
	z = values.isonumber-10;
	if z>0
		sorted{z} = [sorted{z}; freqdata{1}{4}(i)];
	endif
	fprintf(1,"hi: %f\tlow: %f\tactual: %f\t i: %d\t\n",values.hi, values.low,temp,i);
	fflush(1);
endfor

for i=1:length(sorted)
	sorted{i} = ifft(sorted{i});
	meanmplitude{i} = rms(sorted{i})*2^.5;
endfor
				
ztime = clock(); 
filename = [descriptor "-" mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3)) ...  
            "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ... 
            "-whitenoise" ".m"]; 
 
plotnumber = plotsummary(frequencies,times,amplitudes,freqdata,fs,croptime,filename, plotnumber); 
 
fprintf(1,"saving data to file: %s\n",filename);fflush(1); 
if exist("./trials", "file")!=7 
        mkdir trials 
endif 
cd trials; 
save(filename); 
cd ..; 
