z = "SynthDef('000_022', {|out=0,amp=0,rotx=0,roty=0,rotz=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, FoaTransform.ar( FoaEncode.ar( Array.fill(4, { IFFT( PV_Diffuser( FFT( LocalBuf(1024), Limiter.ar(Normalizer.ar((  Pulse.ar( LFNoise1.ar(g, i, i ),  LFNoise0.ar(i, e, g ),  LFDNoise0.ar(l, c, d ), l ))*( Impulse.ar(c, e, i,  Blip.ar( Dust2.ar(d, l, j ), a, e, g ) ))*( Pulse.ar(a,  SinTone.ar(e, g, d, j ), k, m ))*( LFSaw.ar( LFNoise1.ar( FSinOsc.ar(h, m, h, i ), f, f ),  LFSaw.ar(e, b, h, j ), f,  LFSaw.ar(f, h, b, m ) ) )))*amp))) }), FoaEncoderMatrix.newAtoB ), 'rtt', LFSaw.kr(rotx).range(-pi, pi), LFNoise1.kr(roty).range(-pi, pi), LFPulse.kr(rotz).range(-pi, pi))) })"

z = z.replace(" ", "")


l = 64

forBy(63, z.lastIndex, l, {|index|
	var insert = min(z.find(",", offset: index), z.find("(", offset: index));
	[index, insert].postln;
	z = z.insert(insert+1, Char.nl)
})

z