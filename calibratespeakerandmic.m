function void  = calibratespeakerandmic(time2crop)
	pkg load communications;
	pkg load signal;
	minfreq = input("minimum frequency? ");
	maxfreq = input("maximum frequency? ");
	numberofsamples = input("how many frequency steps would you like to use? ");
	numberofvolumes = input("how many volumes would you like to evaluate? ");
	frequency = minfreq+(maxfreq-minfreq)/numberofsamples:(maxfreq-minfreq)/numberofsamples:maxfreq;
	volumes = 1/numberofvolumes:1/numberofvolumes:1;
	ambientdbz = input("ambient db(Z)");
	for i=1:numberofsamples
		tone = wavegen(frequency(i),0,48000,1,'constant');
		for j=1:length(volumes)
			#aquire data
			dbspl(i,j) = 0;
			while (dbspl(i,j)==0) 
				fprintf(1,"volume: %f\tfreq: %f\ti=%d\tj=%d\n", volumes(j), frequency(i),i,j);fflush(1);
				recordedtone = aplayrec((tone')*volumes(j),1,48000,'default');
				dbspl(i,j) = input("return measured dbspl: ");
				if dbspl(i,j)==-1
					dbspl(i,j)=0;
					i = input("go back to i=");
				endif
				if dbspl(i,j)==-2
					dbspl(i,j)=0;
					j = input("go back to j=");
				endif
			endwhile
			[tone,recordedtone] = cropdata(linspace(0,1,1/48000),tone,recordedtone,time2crop);	
			meanamplitudes(i,j) = rms(recordedtone)*2^.5;
		endfor
	endfor


	#write calibration to file
	if exist("./calibrations","file")!=7
		fprintf(1,"creating calibrations folder in local directory\n");fflush(1);
		mkdir calibrations;
	endif
	cd calibrations
	ztime = clock();
	filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
            "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6)))...
	    "-" "calibration" ".m"];
	save(filename);
	cd ..;
	fprintf(1, "saved %s\n", filename);
	clear all;
endfunction
