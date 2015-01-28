function a = comparetrials(varargin)
#function a = comparetrials(varargin)
#compare multiple experimental data files in time and frequency domains
#use: something = comparesamples(experiment_filepath, experiment_filepath, ..., "wav" | "fft" | "both" | "meanamplitudes")
#a{i} containts a structure for each i containing the workspace of each filepath
#each filepath should point to an octave-workspace .m file
	if (nargin<2)
		fprintf(1, "you need at least 1 file and tell me what to plot\n");
	endif
	figure(); hold on;
	tic;
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
		a{i} = load(varargin{i});
		fprintf(1,"loaded %s\n", varargin{i});
		if (strcmp(varargin{end},"meanamplitudes")==1)
			plot(a{i}.frequencies, a{i}.meanamplitudes, '--', 'color', [r g b]);
		else
			close(1);
			plottrial(trial,frequencies,pit,t);			
		endif
		toc
	endfor
	if (strcmp(varargin{end},"meanamplitudes")==1)
		legend(varargin{1}, varargin{2});
		xlabel("frequency");
		ylabel("amplitude");
	endif
	fprintf(1, "finished plotting\n");
endfunction
