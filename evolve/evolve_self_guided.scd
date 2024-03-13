(
~ev = EvolverEnvir(
	(
		populationSize: 5, numgenes: 5, headsize: 17, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.1, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/alo/snd/evolver/auto/"
	)
);

~ugens = [  SinOsc, LFSaw, LFNoise2, LFTri, LFPulse, Dust2, LFDNoise3 ];

~ev.initializeRandomPopulation;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/alo/snd/gep/gepsynth01.aif")

)


~gep.updateScores;
~maxindex = ~gep.chromosomes.collect(_.score).maxIndex;
~ev.save([~maxindex], true, ~recdur, true);
~ev.extractTargetFeatures(~mostRecentSavePath);

Tdef('evolve', {
	~recdur = 5;
	11.do({|i|
		Post << "**** GENERATION " << i << " ****" << Char.nl;
		~paramgep.nextGeneration;
		~gep.nextGeneration;
		(~recdur + 1.0 * ~gep.chromosomes.size).wait;
		~maxindex = ~gep.chromosomes.collect(_.score).maxIndex;
		~ev.save([~maxindex], true, ~recdur, true);
		(~recdur + 1).wait;
		~ev.extractTargetFeatures(~mostRecentSavePath);
		(~recdur + 1).wait;

	});
})

Tdef('evolve').play


~gep.chromosomes.collect(_.score).maxIndex





~gep.updateScores


~gep.drawDistanceMatrix(15)

~gep.draw

~gep.drawCompare(0, 1)

~normalizedDepthScores


gepAnalyzer

~gep.chromosomes[0].asUgenExpressionTree.draw(~ugens, ~gep.colors)


~th = 7.0

~ev.play

~player.stop

~indices = [ 6, 16, 18, 36, 43, 47, 51, 53, 54, 65, 66, 72, 78, 84, 99, 108, 115, 119, 135, 161, 163, 171, 172, 175, 207, 216, 224 ]

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

~gep.chromosomes.collect(_.score).selectIndex({|sc| sc > ~th })

Server.killAll
s.boot

