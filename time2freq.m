function [range,domain] = time2freq(sample,fs)
	fftdata = abs(fft(sample));
	fftlength = floor(length(fftdata)/2)-1;
	#fftlength = length(fftdata);
	fftamplitudes = (fftdata(1:fftlength));
	freq = (fs*(1:fftlength)/fftlength)';
	
	range = freq;
	domain = fftamplitudes;
endfunction
 
