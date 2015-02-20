function [range,domain] = time2freq(sample,fs)
	fftdata = fft(sample);
	fftlength = length(fftdata);
	fftamplitudes = fftdata(1:fftlength);
	freq = (fs*(1:fftlength)/fftlength)';
	range = freq;
	domain = fftamplitudes;
endfunction
 
