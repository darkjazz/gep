s.loadDirectory("/Users/alo/Data/gep/synthdefs/");

~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~data = (); 

~defnames.do({|name|
	var args, arch = ZArchive.read("/Users/alo/Data/gep/metadata/" ++ name.asString ++ ".gepmeta");
	args = arch.readItem;
	arch.close;
	~data[name] = args
});

~data.collect(_.stats).collect(_.mfcc).select({|cf| cf.size == 20 }).size

~defnames.sort({|a, b| a.asString.split($_).last < b.asString.split($_).last });


SynthDef(\foaXform, {|out, in, xng, yng, zng, xfoc, yfoc, zfoc, dur, done|
	var input, fft, af, bf;
	input = In.ar(in) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: done);
	fft = FFT(LocalBuf(1024), input);
	af = Array.fill(4, { IFFT(PV_Diffuser(fft, Dust.kr(50))) });
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
	bf = FoaTransform.ar(bf, 'focus', xfoc, yfoc, zfoc);
	Out.ar(out, FoaTransform.ar(bf, 'rtt', xng, yng, zng))
}).add;

~playNext = {
	
}