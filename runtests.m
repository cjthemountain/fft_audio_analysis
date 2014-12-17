numberoftests = 50;
maxfreq = 15000;	#hz
minfreq = 10000;	#hz
fs = 48000;		#sampling frequency
t = 0.1;

frequencies = minfreq:(maxfreq-minfreq)/numberoftests:maxfreq;
trial = cell(numberoftests,8,fs*t);

for i = 1:numberoftests
	[trial{i,1},trial{i,2},trial{i,3},trial{i,4},trial{i,5},trial{i,6},trial{i,7},trial{i,8}] = performtrial(frequencies(i),fs,t);

endfor

#plot stuff
#plottrial(trial,1); #plot trial 1 (aka trial{1,1 through 4}) in both time and frequency domains 
speakerrangetest(fs, trial, .7, .3, .2, .1, .4, .5); #overlay all trials in frequency domain

#TODO
#save data to file
