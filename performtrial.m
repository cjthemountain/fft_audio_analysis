function [meanamplitude,pit,tplayedtime,tplayed,trectime,trec,fplayedrange,fplayedamp,frecrange,frecamp] = performtrial(freq, fs, t,croptime)

	#generate tones
	[playedtonetime, playedtone] = wavegen(freq,0,fs,t,'constant'); #constant tones
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
		cropdata(playedtonetime, recordedtonetime, playedtone, recordedtone, croptime);	

	#convert to frequency domain data
	[frequenciesplayed, frequenciesplayedamplitude] = time2freq(playedtone,fs);
	[frequenciesrecorded, frequenciesrecordedamplitude] = time2freq(recordedtone,fs);
	frequenciesplayed = frequenciesplayed';
	
	time = playedtonetime;
	amplitude = playedtone;
	frange = frequenciesplayed;
	fdomain = frequenciesplayedamplitude;

	tplayedtime 	= playedtonetime;
	tplayed 	= playedtone;
	fplayedrange	= frequenciesplayed(1:length(frequenciesplayed)/2);
	fplayedamp	= frequenciesplayedamplitude(1:length(frequenciesplayedamplitude)/2);
	
	trectime	= recordedtonetime; 
	trec		= recordedtone;
	frecrange	= frequenciesrecorded(1:length(frequenciesrecorded)/2);
	frecamp		= frequenciesrecordedamplitude(1:length(frequenciesrecordedamplitude)/2);

	meanamplitude 	= rms(trec)*2^.5;
endfunction
