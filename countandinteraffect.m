function handle = countanditeraffect(handle)

#function a = comparemeans(handle)
#compares all "constant" or "whitenoise" trials mean amplitudes @ each frequencies on a single plot
#assumes all octave workspace saves files are in ./trials
#handle is current plot number
	if (nargin<1)
		fprintf(1, "no plot handle passed in. Assumed to be 4, iterating to 5\n");
		fflush(1);
		handle=5;
	else 
		handle = handle+1;
	endif
	figure(handle); hold on;
	

	if (exist("./trials", "file")!=7)
		fprintf(1, "there is no trials folder\n");
		fprintf(1, "run a test and try again\n");
		fflush(1);
		error("foo");
	endif

	files = dir("./trials/*");
	for i=1:size(files,1) #for each directory
		if (files(i).isdir==1)			
			subfiles = dir(["./trials/" files(i).name "/*sec"]); #only already averaged files
			for j=1:size(subfiles,1)
				fprintf(1, "loading file %s\n", ["./trials/" files(i).name "/" subfiles(j).name]);fflush(1);
				temp = load(["./trials/" files(i).name "/" subfiles(j).name]);
				#temp.ama = temp.ama./temp.tnoise; #normalized to 1 secondof data
				plot(linspace(13,13+length(temp.ama),length(temp.ama)), temp.ama, 'color', [rand() rand() rand()]);	
				legs{i} = temp.descriptor;
				xlabel('1/3 octave bands by iso standard number');
				ylabel('floating point amplitude');
				clear temp;
			endfor
		endif
	endfor

	title('white noise average mean amplitudes across various times and iterations');
	axis([10 50]);
	legend(legs);
		
	handle = handle+1;
endfunction
