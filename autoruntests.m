function void = autoruntests(minfreq, maxfreq,points,time,wavetype)
	numberoftests = points;
	#minfreq = 20;		#hz
	#maxfreq = 20000;	#hz
	fs = 48000;		#sampling frequency
	t = time; #seconds to play each tone
	croptime = .1; #time to cut from head of each sample
	#note: the trials samples  will always be cropped from the trials data
	fprintf(1,"samples should total to about %f seconds\n", (t-croptime)*numberoftests);

	#generate sound wavs
	frequencies = minfreq:(maxfreq-minfreq)/numberoftests:maxfreq;
	trials = cell(numberoftests,8,fs*t);

	#prep workspace data for save to file
	ztime = clock();
	filename = [mat2str(ztime(1)) "-" mat2str(ztime(2)) "-" mat2str(ztime(3))... 
		    "_" mat2str(ztime(4)) ":" mat2str(ztime(5)) ":" mat2str(floor(ztime(6))) ".m"];

	#run tests
	fprintf(1, "running tests... \n");
	for i = 1:numberoftests
		fprintf(1,"running %f Hz\n", frequencies(i));fflush(1);
		[meanamplitudes(i),pit,trials{i,1},trials{i,2},trials{i,3},trials{i,4},...
		trials{i,5},trials{i,6},trials{i,7},trials{i,8}] = performtrial(frequencies(i),fs,t,croptime,wavetype);
	endfor
	fprintf("finished trials\n");

	#save data to file
	#TODO
	if exist("./trials", "file")!=7
		mkdir trials
	endif
	cd trials;
	save(filename);
	cd ..;
	fprintf(1,"saved to file\n");fflush(1);

	#post-processing
	fprintf(1,"running need2know\n"); fflush(1);
	need2know(['trials/' filename]);
	fprintf(1, "created trimmed file with smaller filesize including meanamplitudes (need2know()\n");fflush(1);
	meandbamplitudes = amplitude2db(meanamplitudes);
	fprintf(1,"converted meanamplitudes to meandbamplitudes\n"); 
	autoplottrial(trials,frequencies,pit,t,filename);
	fprintf(1, "Done :D\n");
endfunction
