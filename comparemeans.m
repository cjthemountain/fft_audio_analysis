function handle = comparemeans(handle)

#function a = comparemeans(handle)
#compares all "constant" trials mean amplitudes @ each frequencies on a single plot
#assumes all octave workspace saves files are in ./trials
#handle is current plot number
	if nargin!=1
		handle=3;
	endif
	handle = handle+1;
	figure(handle); hold on;
	if (nargin<1)
		fprintf(1, "no plot handle passed in. Assumed to be 3, iterating to 4\n");
		handle=1;
	endif

	if (exist("./trials", "file")!=7)
		fprintf(1, "there is no trials folder\n");
		fprintf(1, "run a test and try again\n");
		fflush(1);
		error("foo");
	endif
	files = dir("./trials/*constant.m");
	for i=1:size(files,1) #for each file
		fprintf(1, "loading file %s\n", ["./trials/" files(i).name]);fflush(1);
		temp = load(["trials/" files(i).name]);		
		plot(temp.frequencies, temp.meanamplitude, 'color', [rand() rand() rand()]);	
		legs{i} = temp.descriptor;
		clear temp;
	endfor
	legend(legs);
	xlabel('frequencies');
	ylabel('floating point amplitude');
	title('mean amplitudes via rms*sqrt(2)');
	axis([-1 20001]);
endfunction
