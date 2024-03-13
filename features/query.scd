~names = [
	["gep_gen005_098_130503_124217", "gep_gen006_117_130503_132055", "gep_gen010_009_151023_212831", "gep_gen018_022_130502_004720"],
	["gep_gen005_098_130503_124217", "gep_gen006_117_130503_132055"],
	["gep_gen005_098_130503_124217", "gep_gen001_054_160830_170546", "gep_gen011_009_151023_220502", "gep_gen012_091_151023_230450"]
]


~return = ~names[2]

~names.do({|array|
	~return = ~return.asSet & array.asSet
})

~return

(~names[1].asSet & ~names[1].asSet).asArray



~query = GESQuery()


~defnames = ~query.search("distortion piano")

~defnames.size

(
~paths = ~defnames.collect({|name|
	"/Volumes/igaluk/synths/ges_ld_01/%.wav".format(name)
});

~buffers = ~paths.collect({|path|
	Buffer.read(s, path)
})
)

(
~play = {|buf, amp|
	SynthDef('play-ges', {|amp|
		var sig = PlayBuf.ar(buf.numChannels, buf.bufnum, loop: 1);
		if (buf.numChannels == 1) {
			sig = Pan2.ar(sig);
		};
		Out.ar(0, sig)
	}).play(1, ['amp', amp])
}
)


~synth = ~play.(~buffers[4], 1.0)

~synth.free