function [timelost tplayedc trecordedc wavplayedc wavrecordedc] = cropdata(tplayed, trecorded, wavplayed, wavrecorded)
#trim audio sample to cut out any issues due to accessing the microphone and speaker
#aka cut out sound card issues for cleaner data
#note: first .01525ish seconds is bunk data regardless of sample length
# will cut first .02 seconds from all samples
#VERIFY: there is probably a time shift between signal out and signal in
	#find .02 seconds
	i=1;
	pit=0;
	while (i<size(trecorded,1) && (pit==0))
		if (trecorded(i)>.02)
			pit = i;		
		else
			i=i+1;
		endif
	endwhile
	
	#crop out first ~.02 seconds from all samples
	tplayedc = tplayed(pit:end);
	trecordedc = trecorded(pit:end);
	wavplayedc = wavplayed(pit:end);
	wavrecordedc = wavrecorded(pit:end);
	
	timelost = trecorded(pit);

	for i=1:size(tplayedc,1)
		tplayedc(i) = tplayedc(i)-tplayed(pit);
		trecordedc(i) = trecordedc(i) - trecorded(pit);
	endfor

endfunction
