function handle = comparemeans(type,handle)

#function a = comparemeans(handle)
#compares all "constant" or "whitenoise" trials mean amplitudes @ each frequencies on a single plot
#assumes all octave workspace saves files are in ./trials
#handle is current plot number
	figure(handle); hold on;
	if (nargin<2)
		fprintf(1, "incorrect number of input arguments\n");
		fprintf(1, "no plot handle passed in. Assumed to be 4, iterating to 5\n");
		fflush(1);
		handle=5;
	endif

	if (exist("./trials", "file")!=7)
		fprintf(1, "there is no trials folder\n");
		fprintf(1, "run a test and try again\n");
		fflush(1);
		error("foo");
	endif
	if type=='whitenoise'
		files = dir("./trials/*whitenoise.m");
		for i=1:size(files,1) #for each file
			fprintf(1, "loading file %s\n", ["./trials/" files(i).name]);fflush(1);
			temp = load(["trials/" files(i).name]);
			plot(temp.isorange,temp.meanamplitudes, 'color', [rand() rand() rand()]);	
			legs{i} = temp.descriptor;
			xlabel('1/3 octave bands by iso standard number');
			ylabel('floating point amplitude');
			clear temp;
		endfor
	elseif type=='constant'
		files = dir("./trials/*constant.m");
		for i=1:size(files,1) #for each file
			fprintf(1, "loading file %s\n", ["./trials/" files(i).name]);fflush(1);
			temp = load(["trials/" files(i).name]);		
			plot(temp.frequencies, temp.meanamplitude, 'color', [rand() rand() rand()]);	
			legs{i} = temp.descriptor;
			xlabel('frequencies');
			ylabel('floating point amplitude');
			clear temp;
		endfor
	endif
	legend(legs);
	title('mean amplitudes via rms*sqrt(2)');
	axis([-1 20001]);
		
	handle = handle+1;
endfunction
