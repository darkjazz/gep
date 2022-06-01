(
~ev = EvolverEnvir(
	(
		populationSize: 307, numgenes: 3, headsize: 57, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.25, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.2, geneTranspositionRate: 0.2,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/alo/snd/evolver/"
	)
);

~ugens = [ SinOsc, Saw, LFSaw, VarSaw, LFTri, Pulse, LFPulse, LFNoise0, LFPar, Logist0, LFNoise1, LFNoise2, Formant, Blip, PMOsc, SyncSaw, Dust2 ];

~ev.initializeRandomPopulation;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/alo/snd/gep/gepsynth06.aif")
)



~gep.updateScores


~gep.drawDistanceMatrix(30)

~gep.draw

~gep.drawCompare(0, 1)

~gep.drawScroll


~ev.playOne(299)


~mostRecentSavePath

gepAnalyzer

~gep.drawUGenTree(3, ~ugens);


~th = 7

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

122

s.sendMsg("/n_free", 3030)