(
~ev = EvolverEnvir(
	(
		populationSize: 43, numgenes: 2, headsize: 23, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.25, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.25, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 7, recordPath: "/Users/alo/snd/evolver/sinosc/"
	)
);

~ugens = [ SinOsc, LFSaw, LFTri ];

~ev.initializeRandomPopulation;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/alo/snd/gep/gepsynth01.aif")
)


~gep.updateScores


~gep.drawDistanceMatrix(5)

~gep.draw

~gep.drawCompare(0, 1)


~gep.drawUGenTree(36, ~ugens);
~gep.drawUGenTree(28, ~ugens);

~ev.playOne(38)


~th = 7.0

~ev.play

~player.stop

~indices = [ 67 ]

~ev.save(~indices, true, 11, true)

s.record

s.scope

s.stopRecording

(
// for each next generation
~paramgep.nextGeneration;
~gep.nextGeneration;
)

[~gep.meanScore, ~gep.maxScore]

~gep.chromosomes.collect(_.score).selectIndices({|sc| sc > ~th })

Server.killAll
s.boot



~gep.chromosomes[13].asUgenExpressionTree.asSynthDefString('whatever_00', Pan2, Limiter, false)


