function data  = calibratespeakerandmic()
	minfreq = input("minimum frequency? ");
	maxfreq = input("maximum frequency? ");
	numberofsamples = input("how many frequency steps would you like to use? ");
	numberofvolumes = input("how many volumes would you like to evaluate? ");
	frequency = minfreq+(maxfreq-minfreq)/numberofsamples:(maxfreq-minfreq)/numberofsamples:maxfreq;
	volumes = 1/numberofvolumes:1/numberofvolumes:1;
	fprintf(1,"each of the %d frequencies will play for 10 seconds %d times, once for each volume,\
during which you can measure the db spl level\n", numberofsamples, numberofvolumes); 
	fprintf(1,"place the dbspl sensor as close to the microphone as possible\n");
	fflush(1);
	for i=1:numberofsamples
		clear tonetime tone timelost tplayedc trecordedc wavplayedc wavrecordedc;
		[tonetime, tone] = chirpgen(frequency(i),0,48000,1,0);
		for j=1:length(volumes)
			#aquire data
			recordedtone = aplayrec((tone')*volumes(j),1,48000,'default'); 
			dbspl(i,j) = input("return measured dbspl: ");
	
			#crop bad data out
			[timelost tonetimec recordedtonetimec tonec recordedtonec] =...
				 cropdata(tonetime',tonetime',tone',recordedtone);

		#collect the data in a convenient way
		tones{i,j} = tonec;
		tonetimes{i,j} = tonetimec;
		recordedtones{i,j} = recordedtonec;
		recordedtonetimes{i,j} = recordedtonetimec;
		meanamplitudes(i,j) = rms(recordedtones{i})*2^.5; 

		endfor
	endfor

	data{1} = dbspl;
	data{2} = meanamplitudes;
	data{3} = recordedtones;

	clear minfreq maxfreq numberofsamples numberofvolumes frequency volumes tones;
	clear tontimes recordedtones recordedtonetimes meanamplitudes;

	#write calibration to file
	if exist("./calibrations","file")!=7
		mkdir calibrations
	endif
	cd calibrations
	ztime = clock();
	filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
            "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6)))...
	    "-" "calibration" ".m"];
	save(filename, "data");
	cd ..;
	fprintf(1, "saved %s\n", filename);
	clear all;
endfunction
