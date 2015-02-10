function void  = calibratespeakerandmic(time2crop)
	minfreq = input("minimum frequency? ");
	maxfreq = input("maximum frequency? ");
	numberofsamples = input("how many frequency steps would you like to use? ");
	numberofvolumes = input("how many volumes would you like to evaluate? ");
	frequency = minfreq+(maxfreq-minfreq)/numberofsamples:(maxfreq-minfreq)/numberofsamples:maxfreq;
	volumes = 1/numberofvolumes:1/numberofvolumes:1;
	ambietdbz = input("ambient db(Z)");
	for i=1:numberofsamples
		tone = wavegen(frequency(i),0,48000,5,'constant');
		for j=1:length(volumes)
			fprintf(1,"volume: %f\tfreq: %f\n", volumes(j), frequency(i));
			#aquire data
			dbspl(i,j) = 0;
			while (dbspl(i,j)==0) 
				recordedtone = aplayrec((tone')*volumes(j),1,48000,'default'); 
				dbspl(i,j) = input("return measured dbspl: ");
			endwhile
	
			#crop bad data out
			#[timelost tonetimec recordedtonetimec tonec recordedtonec] =...
			#	 cropdata(tonetime',tonetime',tone',recordedtone,time2crop);

			#collect the data in a convenient way
		endfor
	endfor


	#write calibration to file
	if exist("./calibrations","file")!=7
		mkdir calibrations
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
