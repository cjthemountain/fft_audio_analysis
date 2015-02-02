function void = need2know(varargin)
#crops trial octave-workspace saves down to
#recorded wav file, frequencies list, mean amplitudes
	for j=1:nargin
		load(varargin{j});
		filepath = [varargin{j} "_trimmed"];
		recordedwaves = trials{:,4};
		#convert floating point to power representation
		#Vmax mic is ~1.1V(?), mic resistance 275ohms, P = V^2/R  so...	
		for i=1:length(recordedwaves)
			pelec(i) = recordedwaves(i)^2/275; #electrical power
		endfor
		save(filepath, "recordedwaves", "frequencies", "meanamplitudes", "pelec");
		clear recordedwaves frequencies meanamplitudes
	endfor

endfunction
