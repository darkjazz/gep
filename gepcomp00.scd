(
s.loadDirectory("/Users/alo/Data/gep/synthdefs/");

~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

//load metadata
~data = (); 

~defnames.do({|name|
	var args, arch = ZArchive.read("/Users/alo/Data/gep/metadata/" ++ name.asString ++ ".gepmeta");
	args = arch.readItem;
	arch.close;
	~data[name] = args
});

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

~decoder = FoaDecoder();

)

(
Routine({
	var bus;
	bus = Bus.audio;
	~decoder.start;
	s.sync;
	~defnames.do({|defname|
		var synth, dur;
		dur = rrand(1, 7);
		synth = Synth(defname, [\out, bus ] ++ ~data[defname][\args]);
		Synth.after(synth, \foaXform, [\out, ~decoder.bus, \in, bus, 
			\xng, rrand(-pi, pi), \yng, rrand(-pi, pi), \zng, rrand(-pi, pi),
			\xfoc, rrand(-pi/4, pi/4), \yfoc, rrand(-pi/4, pi/4),\zfoc, rrand(-pi/4, pi/4),
			\dur, dur, \done, 3
		]).setn(\env, Env([0, 1, 1, 0], [0.05, 0.9, 0.05]));
		(dur.rand).wait;
		synth = nil
	})
}).play
)