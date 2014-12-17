function void = plottrial(trials, trialnumber)
	
	playedtonetime 	= trials{trialnumber,1}; 
	playedtone 	= trials{trialnumber,2};
	recordedtonetime= trials{trialnumber,3};
	recordedtone	= trials{trialnumber,4};
	playedfreqrange	= trials{trialnumber,5};
	playedfreqamp	= trials{trialnumber,6};
	recfreqrange	= trials{trialnumber,7};
	recfreqamp	= trials{trialnumber,8};
	
	figure(trialnumber);
	#plot the time domain data
	subplot(2,1,1);
	hold on;
	plot(playedtonetime, playedtone, 'b--');
	plot(recordedtonetime, recordedtone, 'r--');
	title("time domain");
	xlabel("time (sec)");
	ylabel("amplitude (d2a)");
	legend("played", "recorded");
	hold off;

	#plot the frequency domain data
	subplot(2,1,2);
	hold on;
	plot(playedfreqrange, playedfreqamp,'b--');
	plot(recfreqrange,recfreqamp,'r--');
	title("frequency domain");
	xlabel("frequency");
	ylabel("amplitude");
	legend("played", "recorded");
	hold off;
	x = 0;
endfunction
