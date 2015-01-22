function [pit tplayedtime,tplayed,trectime,trec,fplayedrange,fplayedamp,frecrange,frecamp] = performtrial(freq, fs, t)

	#generate constant tone at freq
	[playedtonetime, playedtone] = chirpgen(freq,0,fs,t,0);
	playedtone = playedtone';
	playedtonetime = playedtonetime';
	#playedtone = playedtone/3; #scale generated tone amplitude by 1/3 to avoid clipping if necessary

	#play audio through speaker and record output
	#tic; #start a timer
	recordedtone = aplayrec(playedtone,1,fs,'default');
	#toc; #split the timer
	recordedtonetime = playedtonetime;

	#crop data before converting to frequency domain
	[pit playedtonetime recordedtonetime playedtone recordedtone] =... 
		cropdata(playedtonetime, recordedtonetime, playedtone, recordedtone);	

	#convert to frequency domain data
	[frequenciesplayed, frequenciesplayedamplitude] = time2freq(playedtone,fs);
	[frequenciesrecorded, frequenciesrecordedamplitude] = time2freq(recordedtone,fs);
	frequenciesplayed = frequenciesplayed';
	
	time = playedtonetime;
	amplitude = playedtone;
	frange = frequenciesplayed;
	fdomain = frequenciesplayedamplitude;

	#this should cut out any issues due to microphone and speaker access misalignment

	tplayedtime 	= playedtonetime;
	tplayed 	= playedtone;
	fplayedrange	= frequenciesplayed(1:length(frequenciesplayed)/2);
	fplayedamp	= frequenciesplayedamplitude(1:length(frequenciesplayedamplitude)/2);
	
	trectime	= recordedtonetime; 
	trec		= recordedtone;
	frecrange	= frequenciesrecorded(1:length(frequenciesrecorded)/2);
	frecamp		= frequenciesrecordedamplitude(1:length(frequenciesrecordedamplitude)/2);
endfunction
