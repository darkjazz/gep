~ev = EvolverEnvir(
	(
		populationSize: 128, numgenes: 4, headsize: 10, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.1, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13
	)
);

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFGauss, SinOscFB, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Blip, Saw, PMOsc, FBSineL, Logist1, Dust2];

~ev.initializeRandomPopulation


~ev.extractTargetFeatures("/Users/alo/snd/gep/atak.aiff")


~ev.defineFitnessFunction


~gep.updateScores


~gep.drawDistanceMatrix(4)

~gep.draw

~gep.drawCompare(0, 1)



~gep.chromosomes[1].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~th = 7.0

~ev.play


~indices = [1, 5, 13, 15, 17, 18, 23, 32, 34, 36, 38, 43, 45, 51, 55, 57, 59, 60, 65, 68, 70, 76, 77, 79, 89, 96, 98, 99, 101, 103, 104, 106, 111, 113, 120, 122, 123, 126]

~ev.save(~indices, true, 5)

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
