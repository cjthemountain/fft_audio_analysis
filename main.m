#aquire experimental trial data
fprintf(1, "iterating trial\n");
loadparams;
for i=1:2
	whitenoise;
endfor

fprintf(1,"average mean amplitudes across all trials\n");
files = dir("./trials/*whitenoise.m");
temp = load(["trials/" files(1).name]);
ama = zeros(size(meanamplitudes,1),size(meanamplitudes,2));
for s=2:size(files,1)
	fprintf(1, "loading file %s\n", ["./trials/" files(s).name]);fflush(1);
        temp = load(["trials/" files(s).name]);
	ama = ama + temp.meanamplitudes;
	maxisonum(i) = max(temp.isonumbers);
	clear temp;
endfor
for i=1:length(ama)
	ama(i) = ama(i)/i;
endfor
figure();
hold on;
bar(linspace(13,max(maxisonum),length(ama)), ama, 'hist');
cd trials;
mkdir(descriptor);
mv ./*whitenoise.m descriptor;
cd ..;

