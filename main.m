#aquire experimental trial data
tic;
fprintf(1, "iterating trials\n");
loadparams;
for i=1:tnum
	fprintf(1,"trial %d of %d\n", i,tnum); fflush(1);
	whitenoise;
endfor

#calculate average means
fprintf(1,"average mean amplitudes across all trials\n");
files = dir("./trials/*whitenoise.m");
#temp = load(["trials/" files(1).name]);
ama = zeros(size(meanamplitudes,1),size(meanamplitudes,2));
for s=1:size(files,1)
	fprintf(1, "loading file %s\n", ["./trials/" files(s).name]);fflush(1);
        temp = load(["trials/" files(s).name]);
	ama = ama + (temp.meanamplitudes)./length(ama);
	maxisonum(i) = max(temp.isonumbers);
	clear temp;
endfor

#plot
fprintf(1, "plotting bar graph\n");
figure();
hold on;
bar(linspace(13,13+length(ama), length(ama)), ama, 'hist');
xlabel("iso standard 1/3 octave band #");
ylabel("wave amplitude [-1,1]");
title("average mean peak amplitudes of white noise data");

cd trials;
mkdir(descriptor);
movefile("./*whitenoise.m", descriptor);
cd(descriptor);
save(descriptor);
cd ../..;
fprintf(1,"trials took %f minutes overall\n", toc/60);fflush(1);

