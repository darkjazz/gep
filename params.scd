(
// UGENS

~headsize = 7;
~numgenes = 2;
~populationSize = 40;

~methods = [SinOsc, LFSaw, LFNoise0, LFPulse].collect({|ugen| 
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

~gep = GEP(~populationSize, ~numgenes, ~headsize, ~methods, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

~gep.mutationRate = 0.1;
~gep.recombinationRate = 0.3;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~paramheadsize = 3;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
}) ++ ControlSpec.methods.select({|mth| mth.name == 'map' });

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals, 
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);

~maps = #[freq, lofreq, midfreq, widefreq, phase].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.chromosomes.do({|orf| 
	orf.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	orf.addExtraDomain(Array.with(~maps.choose))
})

)

(
var index, spec, args, orf, defstr;
index = 26;
~defname = "test_" ++ (index.asString.padLeft(2, "0"));

defstr = ~gep.at(index).asExpressionTree.asSynthDefString(~defname).postln;
defstr.interpret.add;
orf = ~paramgep.at(index);
spec = orf.extraDomains.first.first.asString.drop(2);
~args = orf.asExpressionTree(false).asFunctionString(true).replace("map", spec ++ ".map").interpret.value(*orf.constants);

)

z=Synth(~defname, [~terminals, ~args].lace(~terminals.size * 2))

z.free

~paramgep.chromosomes.do({|orf| 
	var str, funcstr;
	str = orf.extraDomains.first.first.asString.drop(2);
	funcstr = orf.asExpressionTree(false).asFunctionString(true);
	funcstr.postln;
	funcstr.replace("map", str ++ ".map").interpret.value(*orf.constants).postln;
	"-----------------".postln
})

~paramgep.at(0).asExpressionTree(false).asFunctionString(true).replace("map", ~maps.choose.asString.drop(2) ++ ".map").interpret.value(0.3, 0.6)

~paramgep.chromosomes.do({|orf| orf.asSymbols.postln  })

~paramgep.at(0).asSymbols.clump(~paramgep.geneSize).do(_.postln)

~prmtree = ~paramgep.at(2).asExpressionTree(false)

~prmtree.asFunctionString
.interpret.value(0.5)

~prmtree.asFunctionString.interpret.value(pi)


~prmtree.root.nodes.first.nodes.first.value

~paramethods.first.argNames
