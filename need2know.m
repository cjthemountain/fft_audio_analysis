function void = need2know(varargin)
#crops trial octave-workspace saves down to
#recorded wav file, frequencies list, mean amplitudes
	for j=1:nargin
		load(varargin{j});
		filepath = [varargin{j} "_trimmed"];
		recordedwaves = trial{:,4};
		save(filepath, "recordedwaves", "frequencies", "meanamplitudes");
		clear recordedwaves frequencies meanamplitudes
	endfor

endfunction
