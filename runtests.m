numberoftests = 10;
maxfreq = 600;	#hz
minfreq = 400;	#hz
fs = 48000;		#sampling frequency
t = 0.75; #seconds to play each tone
#note: the first .02 seconds will always be cropped from the trial data
fprintf(1,"samples should total to about %f seconds\n", (t-.02)*numberoftests);

#generate sound wavs
frequencies = minfreq+(maxfreq-minfreq)/numberoftests:(maxfreq-minfreq)/numberoftests:maxfreq;
trial = cell(numberoftests,8,fs*t);

#perform calibration (should be done once per speaker setup)
fprintf(1,"any change of position, orientation, or volume controls on the pc or hardware will\ 
require a new calibration for comparable results\n");
fflush(1);

calibrate = input("would you like to run a speaker calibration?\nc for calibrate\nl for load calibration\ns to skip calibration\ndefaults to latest calibration (just hit enter)\n", "s");
if (strcmp("c",calibrate)==1 || strcmp("y", calibrate)==1)
	calibrationdata = calibratespeakerandmic(frequencies);
	#TODO
	#add elseifs for l, s, and default
	#must save calibration data in calibrate function first...
else 
	fprintf(1, "skipping calibration procedure\n");
endif

#prep workspace data for save to file
filedesignation = input("filename: ", "s");
ztime = clock();
filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6)))... 
	    "-" filedesignation ".m"];

#run tests
fprintf(1, "running tests... \n");
for i = 1:numberoftests
	[pit trial{i,1},trial{i,2},trial{i,3},trial{i,4},...
	trial{i,5},trial{i,6},trial{i,7},trial{i,8}] = performtrial(frequencies(i),fs,t);
endfor
fprintf("finished trial\n");

#save data to file
cd trials;
save(filename);
cd ..;
fprintf(1,"saved to file\n");

#TODO
#use calibration data to convert [-1,1] amplitudes to dba spl
fittedtrials = fit2dbaspl(trial);

#TODO
#calculate amplitude difference in time domain signals

#TODO
#calculate amplitude difference in frequency domain signals

#plot stuff
plottrial(trial, frequencies,pit,t);

fprintf(1, "Done :D\n");

