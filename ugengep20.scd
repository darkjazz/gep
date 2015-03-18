(
~geprun = UGepRun(
	size: 128,
	numgenes: 2,
	ncoef: 20,
	rate: 20,
	headsize: 12,
	methods: [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, SawDPW, Dust2, Crackle, Blip, Saw, PMOsc, Logist0, CML0, QuadL, CuspL, GbmanL, HenonL, StandardL, Spring, Ball, LFClipNoise, LFDNoise0, LFDNoise1, Distort, Tanh, Softclip, Sqrt, Squared, Cubed, BitNot],
	linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
	targetBufPath: "/Users/alo/sounds/gep/genfx00.aif",
	methodRatio: 0.75
)
)

~geprun.createTargetStats

~geprun.defineFitnessFunction

~geprun.assignScores

~geprun.history.do(_.postln); ""
~geprun.history.size

~geprun.next


~th = 7.0;
~geprun.selectScores(~th)
~geprun.selectScores(~th).size

~geprun.play(~th)

~indices = [2, 59, 75, 114];

~geprun.save(~indices)









~ugenCounts = ();
~geprun.gep.methods.do({|ugen|
	~ugenCounts[ugen.name.asSymbol] = 0;
});
~geprun.gep.chromosomes.collect(_.code).collect({|code| code.select(_.isKindOf(Class)) }).flat
.do({|ugen|
	~ugenCounts[ugen.name.asSymbol] = ~ugenCounts[ugen.name.asSymbol] + 1;
})

