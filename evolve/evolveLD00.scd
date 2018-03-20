~ev = EvolverEnvir(
	(
		ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 1.0, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0
	)
);


[ 'gep_gen000_040_160829_103156', 'gep_gen000_047_160829_103202' ].do({|name|
	~ev.addChromosomeByDefname(name)
});

~ev.initializePopulation

(
// evolve 5 generations, each doubling in size
5.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

)


~ev.extractTargetFeatures("/Users/alo/snd/gep/atak.aiff")


~ev.defineFitnessFunction

~gep.updateScores


~gep.drawDistanceMatrix(7)

~gep.draw

~gep.drawCompare(0, 4)



~gep.chromosomes[1].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes[0].asUgenExpressionTree.asSynthDefString('whatever_00', Pan2, Limiter, false)


~th = 7.0

~ev.play


~indices = [6]

~ev.save(~indices, false, 8)

