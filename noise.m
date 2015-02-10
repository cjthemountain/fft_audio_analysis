function y = noise(time,fs)
	y = wgn(time*fs,1,1,'linear');
	for i=1:length(y)
		if y(i)>1
			y(i)=1;
		elseif y(i)<-1
			y(i)=-1;
		endif
	endfor
endfunction
