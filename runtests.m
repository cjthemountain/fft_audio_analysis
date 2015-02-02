pkg load aaudio;
pkg load ltfat;
pkg load plot;

numberoftests = 2;
minfreq = 10000;	#hz
maxfreq = 12000;	#hz
fs = 48000;		#sampling frequency
t = .5; #seconds to play each tone
croptime = .1; #time to cut from head of each sample
#note: the trials samples  will always be cropped from the trials data
fprintf(1,"samples should total to about %f seconds\n", (t-croptime)*numberoftests);

#generate sound wavs
frequencies = minfreq+(maxfreq-minfreq)/numberoftests:(maxfreq-minfreq)/numberoftests:maxfreq;
trials = cell(numberoftests,8,fs*t);

#perform calibration (should be done once per speaker setup)
fprintf(1,"any change of position, orientation, or volume controls on the pc or hardware will require a new calibration for comparable results\n");
fflush(1);

#calibrate = input("would you like to run a speaker calibration?\nc for calibrate\nl for load calibration\ns to skip calibration\ndefaults to latest calibration (just hit enter)\n", "s");
#if (strcmp("c",calibrate)==1 || strcmp("y", calibrate)==1)
#	calibrationdata = calibratespeakerandmic(frequencies);
#	#TODO
#	#add elseifs for l, s, and default
#	#must save calibration data in calibrate function first...
#else 
#	fprintf(1, "skipping calibration procedure\n");
#endif

#prep workspace data for save to file
filedesignation = input("filename to save trials to: ", "s");
ztime = clock();
filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
	    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6)))... 
	    "-" filedesignation ".m"];

#run tests
fprintf(1, "running tests... \n");
for i = 1:numberoftests
	fprintf(1,"running %f Hz\n", frequencies(i));fflush(1);
	[meanamplitudes(i),pit,trials{i,1},trials{i,2},trials{i,3},trials{i,4},...
	trials{i,5},trials{i,6},trials{i,7},trials{i,8}] = performtrial(frequencies(i),fs,t,croptime);
endfor
fprintf("finished trials\n");

#save data to file
#TODO
if exist("./trials", "file")!=7
	mkdir trials
endif
cd trials;
save(filename);
cd ..;
fprintf(1,"saved to file\n");fflush(1);
fprintf(1,"running need2know\n"); fflush(1);
need2know(['trials/' filename]);
fprintf(1, "created trimmed file with smaller filesize including meanamplitudes (need2know()\n");fflush(1);
meandbamplitudes = amplitude2db(meanamplitudes);
fprintf(1,"converted meanamplitudes to meandbamplitudes\n"); 
autoplottrial(trials,frequencies,pit,t);
fprintf(1, "clearing all variables from workspace\n");
clear all;
fprintf(1, "Done :D\n");

