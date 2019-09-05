(
~ev = EvolverEnvir(
	(
		populationSize: 256, numgenes: 5, headsize: 17, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.1, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/alo/snd/evolver/"
	)
);

~ugens = [ LFSaw, Crackle, SinOsc, LFTri, Dust2, LFPulse, Pulse, Impulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Blip, Saw, PMOsc, Softclip, Distort, Tanh ];

~ev.initializeRandomPopulation
)

~ev.extractTargetFeatures("/Users/alo/snd/gep/gepsynth01.aif")


~ev.defineFitnessFunction

~gep.updateScores


~gep.drawDistanceMatrix(15)

~gep.draw

~gep.drawCompare(0, 1)



~gep.chromosomes[0].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes[0]

~th = 7.0

~ev.play

~player.stop

~indices = [ 5, 14, 35, 41, 116, 133, 141, 150, 156, 161, 198, 204, 228 ]

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

Server.killAll
s.boot

