function a = comparemeans(varargin)

#function a = comparemeans(varargin)
#compare mean frequency amplitudes across multiple trials
#use: something = comparesamples(experiment_filepath, experiment_filepath, ...)
#a{i} containts a structure for each i containing the workspace of each filepath
#each filepath should point to an octave-workspace .m file containing
#frequencies vector, meanamplitudes vector
	if (nargin<2)
		fprintf(1, "you need at least 2 mfiles\n");
	endif
	plottitle = "";
	figure();
	hold on;
	for i=1:nargin
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
		#plot(a{i}.frequencies, a{i}.meanamplitudes, '--', 'color', [r g b]);
		dbfp = amplitude2db(a{i}.meanamplitudes);
		plot(a{i}.frequencies, dbfp, '--', 'color', [r g b]);
	endfor
	legend(varargin{1}, varargin{2});
	xlabel("frequency");
	ylabel("amplitude (floating point dB)");
	fprintf(1, "finished plotting\n");
	#figure();
	#plot(a{1}.frequencies, (a{2}.meanamplitudes-a{1}.meanamplitudes), 'ko');
endfunction
