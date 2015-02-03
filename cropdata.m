function [p,r] = cropdata(pt,p,r,time2crop)
#trim audio sample to cut out any issues due to accessing the microphone and speaker
#aka cut out sound card issues for cleaner data
#note: first .01525ish seconds is bunk data regardless of sample length
#TODO: VERIFY: there is possible a time shift between signal out and signal in
	i=1;
	pit=0;
	while (i<size(pt,2))
		if pt(i)<time2crop
			p(i) = 0;
			r(i) = 0;	
			i = i+1;
		else
			i = i+1;
		endif
	endwhile
endfunction
