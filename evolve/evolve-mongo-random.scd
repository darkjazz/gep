(
~ev = EvolverEnvir(
	(
		populationSize: 201, numgenes: 3, headsize: 57, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 1.0, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.2, geneTranspositionRate: 0.1,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/alo/snd/evolver/"
	)
);

~ev.initializeRandomDbPopulation;

~ugens = ~gep.methods;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/alo/snd/gep/dilemma.aiff")
)


~ugens.size

~gep.updateScores




~gep.drawDistanceMatrix(10)

~gep.draw

~gep.drawCompare(0, 1)

~gep.drawScroll

~terminals

~ev.playOne(0)


~gep.drawUGenTree(2, ~ugens);


~th = 6.7

~ev.play

~player.stop

~indices = [  ]

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

s.queryAllNodes

JsonWriter

380 / 2

gep_gen001_050_240427_142653
gep_gen002_049_240427_150116
gep_gen002_057_240427_150140
gep_gen002_141_240427_150302
gep_gen004_043_240427_173413
gep_gen004_051_240427_173437
gep_gen004_109_240427_173635
gep_gen004_110_240427_173647
gep_gen004_160_240427_173834


s.sendMsg("/n_free", 3030)