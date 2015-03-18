(

~headsize = 8;
~populationSize = 64;


~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Dust2, Crackle, Blip, Saw, PMOsc, Logist0, CML0];

~methods = ~ugens.collect({|ugen| 
	var ar;
	ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first;
	if (ar.isNil) {
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar
});

~terminals = (~methods.collect(_.argNames).collect(_.size).maxItem + ~headsize).collect({|i|
	(97 + i).asAscii.asSymbol
});

~paramheadsize = 5;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
});

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals, 
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);

~maps = #[unipolar, bipolar, freq, lofreq, midfreq, widefreq].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.chromosomes.do({|chrom| 
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	~terminals.size.do({ chrom.addExtraDomain(~maps.choose) })
});

)


~specs = ~paramgep.chromosomes.collect({|chrom| chrom.extraDomains })

~mapArgs = {|array|
	
}

~params = ~paramgep.chromosomes.collect({|chrom, i|
	var rawargs;
	rawargs = chrom.asExpressionTree(false).asFunctionString.interpret.value(*chrom.constants);
	rawargs.collect({|num, i| chrom.extraDomains[i].map(num.wrap(0.0, 1.0)).roundFreq })
});


~params.do({|prm| prm.postcs; "--".postln})

roundFreq



