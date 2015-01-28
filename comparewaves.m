function void = comparesamples(varargin)
#compare multiple wav files in time and frequency domains
#use: comparesamples(sample_filepath, sample_filepath, ..., "wav" | "fft" | "both")
	if (nargin<2)
		fprintf(1, "you need at least 1 file and tell me what to plot\n");
	endif

	for i=1:(nargin-1)
		switch i
			case 1
				r=1; g=0; b=0;
			case 2
				r=0; g=1; b=0;
			case 3
				r=0; g=0; b=1;
			otherwise
				r = rand(); g = rand(); b = rand();
		endswitch
		
		[file{i},file_fs{i},file_bps{i}]  = wavread(varargin{i});
		[file_freq{i},file_amp{i}] = time2freq(file{i},file_fs{i}); 

		#plot stuff
		if (strcmp(varargin{end},"both")==1)
			#plot the time domain data
			subplot(2,1,1);
			hold on;
			plot(file{i}, '--', 'color', [r g b]);
			hold off;
			
			#plot the frequency domain data
			subplot(2,1,2);
			hold on;
			plot(file_freq{i},file_amp{i},'--', 'color', [r g b]);
			hold off;

			#other plot formatting
			subplot(2,1,1);
			hold on;
			legend(varargin);
			title("time domain");
			xlabel("sample #");
			ylabel("amplitude (d2a)");
			hold off;
			
			subplot(2,1,2);
			hold on;
			legend(varargin);
			title("frequency domain");
			xlabel("frequency");
			ylabel("amplitude");
			hold off;

		elseif (strcmp(varargin{end},"wav")==1)
			#plot the time domain data
			hold on;
			plot(file{i}, '--', 'color', [r g b]);
			legend(varargin);
			title("time domain");
			xlabel("sample #");
			ylabel("amplitude (d2a)");
			hold off;

		elseif (strcmp(varargin{end},"fft")==1)
			hold on;
			plot(file_freq{i},file_amp{i},'--', 'color', [r g b]);
			legend(varargin);
			title("frequency domain");
			xlabel("frequency");
			ylabel("amplitude");
			hold off;
			
		endif
i	endfor 
	fprintf(1, "finished initial plotting\n");
	
endfunction
