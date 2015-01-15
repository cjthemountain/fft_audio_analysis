numberoftests = 50;
maxfreq = 20000;	#hz
minfreq = 0;	#hz
fs = 48000;		#sampling frequency
t = 0.1;

#generate sound wavs
frequencies = minfreq:(maxfreq-minfreq)/numberoftests:maxfreq;
trial = cell(numberoftests,8,fs*t);

calibrate = input("would you like to run a speaker calibration? ", "s");
if (strcmp("yes",calibrate)==1)
	speakerrangetest(fs, trial, 1, .5, .5, .5, 1, .5);
endif

#prep workspace save to file
filedesignation = input("filename: ", "s");
ztime = clock();
filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6)))... 
	    "-" filedesignation ".m"];

#run tests
for i = 1:numberoftests
	[trial{i,1},trial{i,2},trial{i,3},trial{i,4},...
	trial{i,5},trial{i,6},trial{i,7},trial{i,8}] = performtrial(frequencies(i),fs,t);
endfor

#save data to file
cd trials;
save(filename);
cd ..;

#TODO
#calculate amplitude difference in time domain signals

#TODO
#calculate usefule amplitude difference in frequency domain signals

#plot a particular frequency trial
plottrial(trial,1); 
