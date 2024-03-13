~ev = EvolverEnvir(
	(
		populationSize: 128, numgenes: 3, headsize: 13, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.3, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/alo/snd/evolver/"
	)
);

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFGauss, LFPulse, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Blip, Saw, PMOsc];

~ev.initializeRandomPopulation


~ev.extractTargetFeatures("/Users/alo/snd/gep/fxchck.aif")


~ev.defineFitnessFunction

~gep.updateScores


~gep.drawDistanceMatrix(6)

~gep.draw

~gep.drawCompare(0, 1)



~gep.chromosomes[26].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes[0]

~th = 7.0

~ev.play

~gep.generation


~indices = [ 10, 37, 43, 55, 58 ]

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

~gep.chromosomes.collect(_.score).select({|sc| sc > ~th }).size
