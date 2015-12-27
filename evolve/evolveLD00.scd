~ev = EvolverEnvir(
	(
		ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.1, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0
	)
);


[ 'gep_gen004_016_150925_132445', 'gep_gen004_024_150925_132503' ].do({|name|
	~ev.addChromosomeByDefname(name)
});

~ev.initializePopulation

(
// evolve 5 generations, each doubling in size
4.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

)

~ev.extractTargetFeatures("/Users/alo/snd/gep/atak.aiff")


~ev.defineFitnessFunction



~gep.updateScores




~gep.draw

~gep.drawCompare(0, 1)



~gep.chromosomes[1].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~th = 7.7

~ev.play


~indices = [6]

~ev.save(~indices, false, 8)

