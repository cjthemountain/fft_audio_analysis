function x = speakerrangetest(fs,trials,r,g,b,r1,g1,b1)
	# 0<r,g,b<1
	figure(1);
	hold on;
	for i = 1:size(trials,1)
		plot(trials{i,5},trials{i,6},'color',[r1 g1 b1]); #signal out
		plot(trials{i,7},trials{i,8},'color',[r g b]); #mic in
	endfor
	legend('signal in (mic)', 'signal out');
	xlabel("frequencies");
	ylabel("amplitude");
	title("microphone in (system response)");

	x = 0;
	hold off;
endfunction
