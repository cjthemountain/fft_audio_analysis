function void = plottrial(trials, frequencies, pit, sampleduration)
#function void = plottrial(trials, frequencies, pit, sampleduration)
# plots trialnumber from trials. plotwhat can be 
# fr   = frequency response
# wav  = raw wav
# both = frequency response and raw wav	


	plotem=0; 
	while (plotem==0 || (plotem!=1 && plotem!=2)) 
		plotem = input("do you want to plot anything?\nreturn for no plot\n1) single trial\
\n2) all trials\n please select a number: "); 
	endwhile 
	

	plotwhat = "nothing"; 
	if (plotem!=0) 
		while (!strcmp(plotwhat,"wav") && !strcmp(plotwhat,"fr") && !strcmp(plotwhat,"both")) 
			plotwhat = input("what do you want to plot?\n\tfr  = frequency response\n\t\
wav = raw wav\n\tboth = frequency response and raw wav\n", "s");  
		endwhile 
	else 
		fprintf(1,"you chose to skip plotting\n"); 
	endif 
	 
	switch plotem 
		case 1 
			fprintf(1, "range of trials is [1 %d]\n", size(trials,1)); 
			trialnumber = input("plot which trial? " ); 
			fprintf(1,"trial %d, input frequency %dhz\n", trialnumber, frequencies(trialnumber)); 
		case 2 
			poop = 1 
		otherwise 
			fprintf(1,"skipping plotting\n"); 
	endswitch       
	if (plotem==1)
		# assign local variables based on trial selection 
		playedtonetime 	= trials{trialnumber,1}; 
		playedtone 	= trials{trialnumber,2};
		recordedtonetime= trials{trialnumber,3};
		recordedtone	= trials{trialnumber,4};
		playedfreqrange	= trials{trialnumber,5};
		playedfreqamp	= trials{trialnumber,6};
		recfreqrange	= trials{trialnumber,7};
		recfreqamp	= trials{trialnumber,8};
	switch plotwhat
		case "both"		
			#plot the time domain data
			figure();
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
		case "fr"
			#plot the frequency domain data
			figure();
			hold on;
			plot(playedfreqrange, playedfreqamp,'b--');
			plot(recfreqrange,recfreqamp,'r--');
			title("frequency domain");
			xlabel("frequency");
			ylabel("amplitude");
			legend("played", "recorded");
			hold off;
			x = 0;
		case "wav"
			#plot the time domain data
			figure();
			hold on;
			plot(playedtonetime, playedtone, 'b--');
			plot(recordedtonetime, recordedtone, 'r--');
			title("time domain");
			xlabel("time (sec)");
			ylabel("amplitude (d2a)");
			legend("played", "recorded");
			hold off;
		otherwise
			fprintf(1, "don't understand what you want to plot\n");
	endswitch
	elseif (plotem==2) #plot all trials
		figure();
		playedtonetime 	= trials{1,1}; 
		playedtone 	= trials{1,2};
		recordedtonetime= trials{1,3};
		recordedtone	= trials{1,4};
		playedfreqrange	= trials{1,5};
		playedfreqamp	= trials{1,6};
		recfreqrange	= trials{1,7};
		recfreqamp	= trials{1,8};
		#frequency amplitudes should be summed, not concatenated
		for i = 2:size(trials,1)
			recfreqamp 	= recfreqamp 	+ trials{i,8};
			playedfreqamp 	= playedfreqamp + trials{i,6};
		endfor
		
		#append all trials into big vectors
		#and realign times to be sequential
		for i=2:size(trials,1)
			# assign local variables based on trial selection 
			playedtonetime 	 = [playedtonetime;	trials{i,1}+sampleduration*i-sampleduration ]; 
			recordedtonetime = [recordedtonetime;	trials{i,3}+sampleduration*i-sampleduration ];
			playedtone 	 = [playedtone;		trials{i,2}];
			recordedtone	 = [recordedtone; 	trials{i,4}];
			#playedfreqrange = [playedfreqrange; trials{i,5}];
			#recfreqrange	 = [recfreqrange; trials{i,7}];
			#playedfreqamp	 = [playedfreqamp; trials{i,6}];
			#recfreqamp	 = [recfreqamp; trials{i,8}];
		endfor	

		switch plotwhat
			case "both"		
				#plot the time domain data
				subplot(2,1,1);
				hold on;
				#plot(playedtonetime, playedtone, 'color', [rand() rand() rand()]);
				plot(recordedtonetime, recordedtone, 'color', [rand() rand() rand()]);
				title("recorded data time domain");
				xlabel("time (sec)");
				ylabel("amplitude (d2a)");
				#legend("played", "recorded");
				hold off;
				
				#plot the frequency domain data
				subplot(2,1,2);
				hold on;
				#plot(playedfreqrange, playedfreqamp,'color', [rand() rand() rand()]);
				plot(recfreqrange,recfreqamp, 'color', [rand() rand() rand()]);
				title("recorded data frequency domain");
				xlabel("frequency");
				ylabel("amplitude");
				#legend("played", "recorded");
				hold off;
				x = 0;
			case "fr"
				#plot the frequency domain data
				hold on;
				#plot(playedfreqrange, playedfreqamp,'color', [rand(), rand() rand()]);
				plot(recfreqrange,recfreqamp,'color', [rand() rand() rand()]);
				title("frequency domain");
				xlabel("frequency");
				ylabel("amplitude");
				#legend("played", "recorded");
				hold off;
				x = 0;
			case "wav"
				#plot the time domain data
				hold on;
				#plot(playedtonetime, playedtone, 'color', [rand() rand() rand()]);
				plot(recordedtonetime, recordedtone, 'color', [rand() rand() rand()]);
				title("time domain");
				xlabel("time (sec)");
				ylabel("amplitude (d2a)");
				#legend("played", "recorded");
				hold off;
			otherwise
				fprintf(1, "don't understand what you want to plot\n");
		endswitch
	endif
	
endfunction
