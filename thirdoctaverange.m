function values = thirdoctaverange(frequency)
	values.center = -1;
	values.isonumber = -1;
	values.hi = -1;
	values.low = -1;
	thirdbands = zeros(35,3);
	thirdbands(20,:) = [1000/2^(1/6) 1000 1000*2^(1/6)];
	for i=19:-1:1
		thirdbands(i,2) = thirdbands(i+1,2)/2^(1/3); 		
		thirdbands(i,1) = thirdbands(i,2)/2^(1/6);
		thirdbands(i,3) = thirdbands(i,2)*2^(1/6);
	endfor
	for i=21:35
		thirdbands(i,2) = thirdbands(i-1,2)*2^(1/3); 		
		thirdbands(i,1) = thirdbands(i,2)/2^(1/6);
		thirdbands(i,3) = thirdbands(i,2)*2^(1/6);
	endfor
	for i=1:size(thirdbands,1)
		if ((frequency >=thirdbands(i,1)) && (frequency < thirdbands(i,3)))
			values.low 	= thirdbands(i,1);
			values.center 	= thirdbands(i,2);
			values.hi	= thirdbands(i,3); 
			values.isonumber = i+10;
		endif
	endfor
endfunction
