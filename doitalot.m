pkg load aaudio;
pkg load ltfat;
pkg load plot;	

points = 10;
lowfreq = 20;
highfreq = 20000;
segments = 1;
repeats=1;
currentfrequency = lowfreq:(highfreq-lowfreq)/segments:highfreq;
period = .2;

for j=1:repeats
	for i=1:segments
		fprintf(1,"current frequency range [%d\t%d]\n",currentfrequency(i), currentfrequency(i+1));
		autoruntests(currentfrequency(i),currentfrequency(i+1),points/segments,period)
	endfor
endfor	
