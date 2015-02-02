function dbfp = amplitude2db(amplitudes)
# converts vector of values by 20*log(value^2);
	for i=1:length(amplitudes)
		pfp(i) = amplitudes(i)^2; #aka floating point mean amplitude power
		dbfp(i)= 20*log(pfp(i)); 
	endfor 
endfunction
