function [t,x] = wavegen(freq0,freq1,fs,time,switcher)
#switcher must be 'constant', 'abssweep','linearsweep','chirp', or 'whitenoise'
	if (nargin!=5)
		fprintf(1,"requires 5 args. chirpgen(freq0,freq1,fs,time, switch)\n");
		x = -1;
	endif
	freq0 = freq0/2;
	freq1 = freq1/2;

	t=1/fs:1/fs:time;
	f=freq0:(freq1-freq0)/length(t):freq1-(freq1-freq0)/length(t);
	
	switch (switcher)
		case 'constant'		#constant held at freq0
			x = sin(2*pi*freq0*t);		
		case 'abssweep'		#absolute value of linear sweep from freq0 to freq1
			x = abs(sin(2*pi*f.*t));#abs
		case 'linearsweep' 	#linear sin sweep from freq0 to freq1  
			f = linspace(freq0,freq1,length(t));
			x = sin(2*pi.*f.*t);
		case 'chirp' 		#using chirp function, phase shift to sine
			x = chirp(t,freq0,max(t),freq1,'linear',pi/2); 
		case 'whitenoise'		#generate white noise
			fprintf(1,"ERROR: white noise not yet implemented\n");
		otherwise
			x = zeros(length(time),1);
	endswitch
endfunction
