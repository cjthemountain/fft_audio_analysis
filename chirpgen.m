function [t,x] = chirpgen(freq0,freq1,fs,time,switcher)
	if (nargin!=5)
		fprintf(1,"requires 5 args. chirpgen(freq0,freq1,fs,time, switch)\n");
		x = -1;
	endif
	freq0 = freq0/2;
	freq1 = freq1/2;

	t=1/fs:1/fs:time;
	f=freq0:(freq1-freq0)/length(t):freq1-(freq1-freq0)/length(t);
	
	switch (switcher)
		case 0	#constant held at freq0
			x = cos(2*pi*freq0*t);		
		case 1	#absolute value of linear sweep from freq0 to freq1
			x = abs(cos(2*pi*f.*t));#abs
		case 1.1#linear sweep from freq0 to freq1  
			x = cos(2*pi*(f.*t)); 
		otherwise
			x = zeros(length(time),1);
	endswitch
endfunction
