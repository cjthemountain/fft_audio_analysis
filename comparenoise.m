function handle = comparenoise(handle,directory)
#function a = comparemeans(handle)
#compares all "constant" or "whitenoise" trials mean amplitudes @ each frequencies on a single plot
#assumes all octave workspace saves files are in ./trials
#handle is current plot number
	if (nargin<2)
		fprintf(1, "need handle and directory\n");
		fflush(1);
	else 
		handle = handle+1;
	endif
	figure(handle); hold on;
	if (exist(directory, "file")!=7)
		fprintf(1, "there is no folder %s\n", directory);
		fflush(1);
	endif
	files = dir([directory "/*"]);
	n=1;
	o=1;
	for i=1:size(files,1) #for each directory
		if (files(i).isdir==1)			
			subfiles = dir([directory "/" files(i).name "/*"]);
			for j=1:size(subfiles,1)
				if (subfiles(j).name(end)!="m") #only read sorted files
					fprintf(1, "loading file %s\n", [directory "/" files(i).name "/" subfiles(j).name]);
					fflush(1);
					temp = load([directory "/" files(i).name "/" subfiles(j).name]);
					temp.ama = temp.ama./temp.tnum; #normalized to 1 secondof data
					#change the x values here to actual frequencies
					plot(linspace(13,13+length(temp.ama),length(temp.ama)), temp.ama,...
						'color', [rand() rand() rand()]);	
					legs{o} = temp.descriptor;
					o = o+1;
					xlabel('1/3 octave bands by iso standard number');
					ylabel('floating point amplitude');
					rangex = linspace(13,13+length(temp.ama),length(temp.ama));
					for k = 1:length(temp.ama)
						rangey(i,k) = temp.ama(k); 
					endfor
					meanama(n) = mean(temp.ama);
					meanamafile{n} = temp.descriptor;
					n=n+1;
					clear temp;
				endif
			endfor
			clear subfiles;
		endif
		title('white noise average mean amplitudes across various times and iterations');
		axis([10 50]);
		legend(legs);
	endfor

	handle = handle +1;
	figure(handle);
	#change x values here to actual frequencies
	bar(rangex,rangey');
	title('white noise average mean amplitudes across various times and iterations');
	axis([10 50]);
	legend(legs);
	handle = handle+1;
	figure(handle); hold on;
	for i=1:length(meanama)
		foo(i,i) = meanama(i);
	endfor
	bar(foo);
	legend(meanamafile{1,:});
	
endfunction
