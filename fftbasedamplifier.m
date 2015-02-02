fs = 8000;
t = linspace(0,1,fs);
freq = 800;
fprintf(1, "foo\n");

ya = sin(2*pi*freq*t);
num_per_sec = 5;
fprintf(1, "foo\n");

yb = repmat(ya,num_per_sec,1);
fprintf(1, "foo\n");

xxb=linspace(0,1,length(yb))';
fprintf(1, "foo\n");

xxa=linspace(0,1,length(ya))';
fprintf(1, "foo\n");

yi_t=interp1(xxb,yb,xxa,'linear');
fprintf(1, "foo\n");




