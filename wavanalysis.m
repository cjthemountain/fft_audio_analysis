clear all; close all; clc;
[y,fs,bps] = wavread("./virgin_b777.wav");
[f,a] = time2freq(y,fs);
plot(f,real(a));
axis([0 1000 0 max(a)]);
