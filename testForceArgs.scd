(

// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 4;
~populationSize = 16;

~ugens = [LFSaw, SinOsc, LFTri, LFPulse, LFNoise2, LFNoise0, DelayN, CombN];

~forceArgs = ('maxdelaytime': 1.0);

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

~gep = UGEP(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first, ~forceArgs
);


)


~chrm = ~gep.chromosomes[2]
~chrm.code

~chrm.asUgenExpressionTree.asSynthDefString



