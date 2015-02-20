function data = performtrial(p,fs)

	#play audio through speaker and record output
	r = aplayrec(p',1,fs,'default');
	data{5} = r;  #recorded amplitude vector

	#convert to frequency domain data
	[data{1},data{2}] = time2freq(p,fs);
	[data{3},data{4}] = time2freq(r,fs);

endfunction
