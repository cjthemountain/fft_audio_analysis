function void = plotsummary(frequencies,times,amplitudes,data,fs,time2crop,filename)
	for i=1:size(data,2)
		[amplitudes{i},data{i}{5}] =... 
			cropdata(times,amplitudes{i},data{i}{5},time2crop);
	endfor
	#sum ffts	
	for i = 2:size(data,2)
		data{1}{2}	= data{1}{2} + data{i}{2};
		data{1}{4}   	= data{1}{4} + data{i}{4};
	endfor
	
	#append time domains
	newtimes = times;	
	for i=2:size(data,2)
		newtimes	= [newtimes		times+max(times)*i-max(times)];
		amplitudes{1} 	= [amplitudes{1}	amplitudes{i}];
		data{1}{5}	= [data{1}{5}; 		data{i}{5}];
	endfor	
	
	#plot the time domain data
	subplot(2,1,1);
	hold on;
	plot(newtimes, amplitudes{1}, 'color', [0 0 0]); #played waves in black
	plot(newtimes, data{1}{5},    'color', [1 0 0]); #recorded waves in red
	title(filename);
	xlabel("time (sec)");
	ylabel("amplitude (d2a)");
	legend("played", "recorded");
	
	#plot the frequency domain data
	subplot(2,1,2);
	hold on;
	m=1;	
	for n=1:length(frequencies)
		markersx(m)	=frequencies(n);
		markersx(m+1)	=frequencies(n);
		markersy(m)	=0;
		markersy(m+1)	=max(data{i}{2});
		m=m+2;
	endfor	
	plot(data{1}{1}, data{1}{2},'color', [0 0 0]); #played frequencies black
	plot(data{1}{1}, data{1}{4},'color', [1 0 0]); #recorded frequencies red
	highlight played frequencies in green --
	for m=1:2:length(markersx)-1
		plot([markersx(m) markersx(m+1)],[markersy(m) markersy(m+1)], 'g--');
	endfor
	xlabel("frequency");
	ylabel("amplitude");
	legend("wav played", "wav recorded", "frequencies played");
	hold off;

	#TODO
	#autosave plot as image....
endfunction
