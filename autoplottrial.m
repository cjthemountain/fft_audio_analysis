function void = plottrial(trials, frequencies, pit, sampleduration, filename)
#function void = plottrial(trials, frequencies, pit, sampleduration, filename)
	
	figure();
	playedtonetime 	= trials{1,1}; 
	playedtone 	= trials{1,2};
	recordedtonetime= trials{1,3};
	recordedtone	= trials{1,4};
	playedfreqrange	= trials{1,5};
	playedfreqamp	= trials{1,6};
	recfreqrange	= trials{1,7};
	recfreqamp	= trials{1,8};

	for i = 2:size(trials,1)
		recfreqamp 	= recfreqamp 	+ trials{i,8};
		playedfreqamp 	= playedfreqamp + trials{i,6};
	endfor
	
	for i=2:size(trials,1)
		playedtonetime 	 = [playedtonetime;	trials{i,1}+sampleduration*i-sampleduration ]; 
		recordedtonetime = [recordedtonetime;	trials{i,3}+sampleduration*i-sampleduration ];
		playedtone 	 = [playedtone;		trials{i,2}];
		recordedtone	 = [recordedtone; 	trials{i,4}];
	endfor	

	#plot the time domain data
	subplot(2,1,1);
	hold on;
	#plot(playedtonetime, playedtone, 'color', [rand() rand() rand()]);
	plot(recordedtonetime, recordedtone, 'color', [1 0 0]);
	title(filename);
	xlabel("time (sec)");
	ylabel("amplitude (d2a)");
	#legend("played", "recorded");
	hold off;
	
	#plot the frequency domain data
	subplot(2,1,2);
	hold on;
	m=1;	
	for n=1:length(frequencies)
		markersx(m)	=frequencies(n);
		markersx(m+1)	=frequencies(n);
		markersy(m)	=0;
		markersy(m+1)	=max(playedfreqrange);
		m=m+2;
	endfor	
	for m=1:2:length(markersx)-1
		plot([markersx(m) markersx(m+1)],[markersy(m) markersy(m+1)], 'g--');
	endfor
	plot(playedfreqrange, playedfreqamp,'color', [0 0 0]);
	plot(recfreqrange,recfreqamp, 'color', [1 0 0]);
	xlabel("frequency");
	ylabel("amplitude");
	legend("frequency list", "frequency list", "wav played", "wav recorded");
	hold off;
	x = 0;

	#TODO
	#autosave plot as image....
endfunction
