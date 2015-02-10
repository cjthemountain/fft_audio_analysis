# run this to perform a full analysis on a single sample
# intended for use with hardware: anechoic chamber, 
# sample stand, microphone, and speaker
# all data will be saved to the trials folder with format
# descriptor-date-time

pkg load aaudio;
pkg load ltfat;
pkg load plot;
pkg load signal;
pkg load communications;
clear all; close all; clc;

points =  10; 
minfreq = 20;
maxfreq = 20000;
fs = 48000;
tsweep = 10;
tconstant = 1;
croptime = .1; #for constant tones, cut out croptime  bad data from head
tconstant=tconstant+croptime;
frequencies = minfreq:(maxfreq-minfreq)/points:maxfreq;
plotnumber = 1;
descriptor = "";

while (length(descriptor)==0)
	fprintf(1,"please enter the material identifier. This should be unique to the sample.\n");
	fflush(1);
	descriptor = input("sample descriptor: ", 's');
endwhile

#run the various sound tests
constant
sinesweep
whitenoise
#737noise
