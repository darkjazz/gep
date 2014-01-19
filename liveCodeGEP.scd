Server.local.boot;

(
~ncoef = 20;
~rate = 20;
~headsize = 7;
~numgenes = 4;
~populationSize = 32;

~mode = 0;

~decoder = FoaDecoder();
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/input/shellylivecode.aiff");

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/input/shellylivecode.aiff");

~graphics = CinderApp(800, 600, mode: ~mode);

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newRandomFromLibrary(~populationSize, ~numgenes, ~headsize, ~linker, ~excludeUGenList);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics);
 
)



(
~genetic.prepareAnalyzers;
~genetic.assignCodeWindow(Document.current);
~graphics.open;
)


~input.synth.set(\mamp, 0.0);

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 20.0, 50.0, 0.0, 0.0, 0.0);


~graphics.setPattern(12, 1, 0.5, 0, 0, 0.6, 0.8, 1.0);


~gep.chromosomes[0].asUgenExpressionTree.asFoaNdefString('000_010', Normalizer, 'saw')

~genetic.makeNdefWindow('000_000', 0, 'saw')


~genetic.getArgsForDef('000_000').asString

~gep.chromosomes[1].asUgenExpressionTree.asFoaSynthDefString('000_000', Normalizer, 'saw')

~gep.chromosomes[1].asUgenExpressionTree.asFoaSynthDefString('000_001', Normalizer, "0", "0", "0")


~chrom = ~genetic.cospecies.chromosomes[0]
~chrom.code
~spec = ~chrom.extraDomains.first.first.asString.drop(2)
~args.asExpressionTree(false).asFunctionString.replace("map", ~spec ++ ".map").interpret.value(*~chrom.constants)

(
~genetic.evaluateCurrentPopulation(3, {|genetic|
	~genetic.meanStats;
	Post << "Analysis completed!" << Char.nl;
})

)

s.queryAllNodes

s.sendMsg("/n_free", 1005)

~genetic.distances.do(_.postln)

~genetic.distances.keysValuesDo({|key, val| Post << key << ": " << val << Char.nl  })


~genetic.selectWeightedRandom

~genetic.generateNewDefs(*~genetic.selectWeightedRandom)

~genetic.generateNewDefs(~gep.chromosomes[35], ~gep.chromosomes[36])


~gep.chromosomes[34].asUgenExpressionTree.asSynthDefString('000_034')


~genetic.defs.collect(_.name)

~genetic.args.size

~genetic.defs.do({|def| def.name.postln  })


~genetic.play('000_000')

~genetic.fade('000_001', 0.0, 0.1, 4)

~genetic.set('000_001', 0.5)

~genetic.free('000_000')

~genetic.tag('000_002')

s.queryAllNodes



~genetic.play('000_002')

~genetic.set('000_002', 0.0)

~genetic.fade('000_002', 0.1, 0.0, 4)

~genetic.free('000_001')

~genetic.tag('000_001')



~genetic.play('000_003')

~genetic.set('000_003', 0.2)

~genetic.fade('000_003', 0.0, 0.2, 10)

~genetic.free('000_003')

~genetic.tag('000_011')


~genetic.play('000_004')

~genetic.set('000_004', 0.5)

~genetic.fade('000_004', 0.05, 0.0, 10)

~genetic.free('000_004')




~genetic.play('000_006')

~genetic.set('000_006', 0.4)

~genetic.fade('000_006', 0.1, 0.0, 4)

~genetic.free('000_006')

~genetic.tag('000_009')




~genetic.play('000_007')

~genetic.set('000_007', 0.5)

~genetic.fade('000_007', 0.0, 0.1, 10)

~genetic.free('000_007')

~genetic.tag('000_007')


~genetic.play('000_008')

~genetic.set('000_008', 0.5)

~genetic.fade('000_008', 0.5, 0.0, 10)

~genetic.free('000_008')

~genetic.tag('000_008')



~genetic.play('000_009')

~genetic.set('000_009', 0.5)

~genetic.fade('000_009', 0.5, 0.0, 4)

~genetic.free('000_009')

~genetic.tag('000_009')


~genetic.play('000_011')

~genetic.set('000_011', 0.5)

~genetic.fade('000_011', 0.5, 0.0, 4)

~genetic.free('000_011')

~genetic.tag('000_011')


~genetic.play('000_013')

~genetic.set('000_013', 0.0)

~genetic.fade('000_013', 0.0, 0.3, 4)

~genetic.free('000_013')

~genetic.tag('000_013')



~genetic.play('000_014')

~genetic.set('000_014', 0.2)

~genetic.fade('000_014', 0.6, 0.0, 4)

~genetic.free('000_014')

~genetic.tag('000_014')


~genetic.play('000_015')

~genetic.set('000_015', 0.0)

~genetic.fade('000_015', 0.0, 0.3, 10)

~genetic.free('000_015')

~genetic.tag('000_015')


~genetic.play('000_016')

~genetic.set('000_016', 0.3)

~genetic.fade('000_016', 0.0, 0.3, 10)

~genetic.free('000_016')

~genetic.tag('000_016')



~genetic.play('000_017')

~genetic.set('000_017', 0.0)

~genetic.fade('000_017', 0.0, 0.8, 10)

~genetic.free('000_017')

~genetic.tag('000_017')



~genetic.play('000_018')

~genetic.set('000_018', 1.0)

~genetic.fade('000_018', 0.0, 0.8, 10)

~genetic.free('000_018')

~genetic.tag('000_018')



~genetic.play('000_019')

~genetic.set('000_019', 0.1)

~genetic.fade('000_019', 0.0, 0.8, 10)

~genetic.free('000_019')

~genetic.tag('000_019')


~genetic.play('000_020')

~genetic.set('000_020', 0.1)

~genetic.fade('000_020', 0.0, 0.8, 10)

~genetic.free('000_020')

~genetic.tag('000_020')



~genetic.play('000_025')

~genetic.set('000_025', 0.4)

~genetic.fade('000_025', 0.0, 0.8, 10)

~genetic.free('000_025')

~genetic.tag('000_025')



~genetic.play('000_026')

~genetic.set('000_026', 1.0)

~genetic.fade('000_026', 0.8, 0.0, 10)

~genetic.free('000_026')

~genetic.tag('000_026')



~genetic.play('000_027')

~genetic.set('000_027', 0.1)

~genetic.fade('000_027', 0.0, 0.8, 10)

~genetic.free('000_027')

~genetic.tag('000_027')


~genetic.play('000_030')

~genetic.set('000_030', 0.1)

~genetic.fade('000_030', 0.4, 0.8, 10)

~genetic.free('000_030')

~genetic.tag('000_030')




~genetic.play('000_031')

~genetic.set('000_031', 1.0)

~genetic.fade('000_031', 0.4, 0.8, 10)

~genetic.free('000_035')

~genetic.tag('000_031')


~genetic.play('000_033')

~genetic.set('000_033', 0.4)

~genetic.fade('000_033', 0.4, 0.8, 10)

~genetic.free('000_033')

~genetic.tag('000_033')



~genetic.postTags

s.queryAllNodes

~genetic.play('000_032')

~genetic.set('000_032', 0.1)

~genetic.fade('000_008', 0.0, 0.1, 10)

~genetic.free('000_032')


~genetic.play('000_033')

~genetic.fade('000_033', 0.0, 0.1, 10)

~genetic.free('000_033')


~genetic.play('000_011')

~genetic.fade('000_011', 0.0, 0.2, 6)

~genetic.free('000_011')


~genetic.play('000_034')

~genetic.fade('000_034', 0.2, 0.7, 2)

~genetic.free('000_034')


~genetic.play('000_017')

~genetic.fade('000_017', 0.0, 0.1, 6)

~genetic.free('000_017')


~genetic.play('000_016')

~genetic.fade('000_016', 0.01, 0.0, 3)

~genetic.free('000_016')


~genetic.play('000_018')

~genetic.fade('000_018', 0.0, 0.2, 6)

~genetic.fade('000_018', 0.4, 0.0, 30)

~genetic.free('000_018')


~genetic.play('000_020')

~genetic.fade('000_020', 0.1, 0.0, 6)

~genetic.free('000_020')



~genetic.play('000_022')

~genetic.fade('000_022', 0.0, 0.3, 6)

~genetic.free('000_022')


~genetic.play('000_024')

~genetic.fade('000_024', 0.1, 0.4, 6)

~genetic.free('000_024')


~genetic.play('000_025')

~genetic.fade('000_025', 0.0, 0.1, 2)

~genetic.free('000_025')


~genetic.play('000_026')

~genetic.fade('000_026', 0.1, 0.0, 20)

~genetic.free('000_026')



~genetic.play('000_027')

~genetic.fade('000_027', 0.0, 0.4, 2)

~genetic.free('000_027')


~genetic.play('000_028')

~genetic.fade('000_028', 0.0, 0.3, 4)

~genetic.free('000_028')


~genetic.play('000_031')

~genetic.fade('000_031', 0.0, 0.1, 10)

~genetic.free('000_031')


~genetic.play('000_036')

~genetic.fade('000_034', 0.0, 0.1, 10)

~genetic.fade('000_031', 0.2, 0.0, 10)

~genetic.free('000_031')


s.queryAllNodes



~genetic.play('000_042')

~genetic.set('000_042', 0.5)

~genetic.free('000_042')


~genetic.play('000_043')

~genetic.set('000_043', 0.5)

~genetic.free('000_043')






~genetic.set('000_058', 0.7)

~genetic.set('000_037', 0.5)

~genetic.free('000_002')

~genetic.free('000_031')


~genetic.play('000_009')

~genetic.play('000_044')

~genetic.set('000_003', 0.0)

~genetic.set('000_010', 0.0)

~genetic.set('000_034', 0.9)


~genetic.free('000_034')

~genetic.synths



~genetic.cospecies.chromosomes[0].constants

~args = Array();
(
~generateNewArgs = {|indA, indB|
	var newA, newB, spec;
	newA = GEPChromosome(indA.code.copy, ~gep.terminals, ~gep.numgenes, ~gep.linker);
	newA.extraDomains = [[indA.extraDomains.first.first.copy]];
	newA.constants = indA.constants.copy;
	newB = GEPChromosome(indB.code.copy, ~gep.terminals, ~gep.numgenes, ~gep.linker);
	newB.extraDomains = [[indB.extraDomains.first.first.copy]];
	newB.constants = indB.constants.copy;

	~genetic.performGeneticOperations(~genetic.cospecies, newA);
	~genetic.performGeneticOperations(~genetic.cospecies, newB);
	// recombination
	~genetic.cospecies.performRecombination(newA, newB);

	spec = newA.extraDomains.first.first.asString.drop(2);
	~args = ~args.add(
		newA.asExpressionTree(false).asFunctionString
			.replace("map", spec ++ ".map").interpret.value(*newA.constants)
	);

	spec = newB.extraDomains.first.first.asString.drop(2);
	~args = ~args.add(
		newB.asExpressionTree(false).asFunctionString
			.replace("map", spec ++ ".map").interpret.value(*newB.constants)
	);
	
}

)

~generateNewArgs.(~genetic.cospecies.chromosomes[0], ~genetic.cospecies.chromosomes[1])

(
~fspec = ControlSpec.specs['freq'];
~sums = ~genetic.gepAnalyzer.diffStats.select({|stat, key|
	~genetic.gepAnalyzer.segmentStats[key].err.collect(_.last).sum == 0
}).collect({|stat, key|
	var means, dev;
	means = [
		stat.mfcc.collect(_.last).collect(_.mean).mean,
		stat.flat.collect(_.last).mean,
		~fspec.unmap(stat.cent.collect(_.last).mean),
		stat.amps.collect(_.last).mean
	];
	dev = [
		stat.mfcc.collect(_.last).collect(_.stdDev).stdDev,
		stat.flat.collect(_.last).stdDev,
		~fspec.unmap(stat.cent.collect(_.last).stdDev),
		stat.amps.collect(_.last).stdDev
	];
//	Post << key << Char.nl;
//	Post << "MFCC: " << stat.mfcc.collect(_.last).collect(_.mean).mean << Char.nl;
//	Post << "Flat: " << stat.flat.collect(_.last).mean << Char.nl;
//	Post << "Cent: " << ~fspec.unmap(stat.cent.collect(_.last).mean) << Char.nl;
//	Post << "Amps: " << stat.amps.collect(_.last).mean << Char.nl;
//	Post << "Summed: " << sums.sum << Char.nl;
	[means.mean, dev.mean].mean
})
)

~sums.findKeyForValue(~sums.values.minItem)

~sums.findKeyForValue(~sums.values.maxItem)


~genetic.gepAnalyzer.diffStats['000_000'].amps.collect(_.last).sum

~genetic.gepAnalyzer.segmentStats['000_000'].mfcc.collect(_.last)

~genetic.gepAnalyzer.meanStats.do({|stat| stat.amp.mean.postln })

s.queryAllNodes

Server.local.queryAllNodes

(
~fspec = ControlSpec.specs['freq'];
~sums = ~genetic.gepAnalyzer.diffStats.collect({|stat, key|
	var means, dev;
	if (~genetic.gepAnalyzer.segmentStats[key].err.collect(_.last).sum > 0) {
		0.0
	}
	{
		means = [
			stat.mfcc.collect(_.last).collect(_.mean).mean,
			stat.flat.collect(_.last).mean,
			~fspec.unmap(stat.cent.collect(_.last).mean),
			stat.amps.collect(_.last).mean
		];
		dev = [
			stat.mfcc.collect(_.last).collect(_.stdDev).stdDev,
			stat.flat.collect(_.last).stdDev,
			~fspec.unmap(stat.cent.collect(_.last).stdDev),
			stat.amps.collect(_.last).stdDev
		];
		1.0 - [means.mean, dev.mean].mean
	}
})
)

~sums = ~sums.collect({|sum| if (sum.isNaN) { 0 } { sum } })
	
~sums.do(_.postln)

~sums.findKeyForValue(~sums.values.minItem)

~defname = ~sums.findKeyForValue(~sums.values.maxItem)

~defname = '000_030'

~index = ~genetic.defs.indexOf(~genetic.defs.select({|def| def.name.asSymbol == ~defname.asSymbol }).first)

~defname = ~genetic.findClosest

~defname = ~genetic.findFarthest

~genetic.distances.do(_.postln)

~synth =	Synth(~defname, [\out, 0] ++ [~genetic.genetic.terminals, ~genetic.args[~index]].lace(~genetic.genetic.terminals.size*2) );


~synth.free

