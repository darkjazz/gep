(
~headsize = 5;
~numgenes = 2;
~populationSize = 100;

~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(~populationSize, ~numgenes, ~headsize, ~methods, ~terminals, True.methods.select({|meth| [\or].includes(meth.name)  }).first);

~gep.addFitnessFunc({|chromosomes|
	var majorityRule;
	majorityRule = {|a, b, c| 
		if ([a, b, c].collect(_.binaryValue).sum > 1) { true } { false } 
	};
	chromosomes.do({|orf|
		var score = 0, func;
		func = orf.asExpressionTree(false).asFunctionString.interpret;
		8.do({|i|
			var args;
			args = i.asDigits(2,3).collect(_.booleanValue);
			if (majorityRule.(*args) == func.(*args)) {
				score = score + 1
			}
		});
		orf.score = score
	})
});

~gep.mutationRate = 1.0;
~gep.recombinationRate = 1.0;
~gep.transpositionRate = 1.0;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~gep.updateScores;

[~gep.generationCount, ~gep.meanScore, ~gep.maxScore].postln

)

(
10.do({

	~gep.nextGeneration;
	
	if (~gep.maxScore == 8) {
		~gep.maxScoreORFs.do({|orf| orf.asExpressionTree(false).asFunctionString.postln })
	};
	
	[~gep.generationCount, ~gep.meanScore, ~gep.maxScore].postln

})
)

~tree = ~gep.maxScoreORFs.first.asExpressionTree(false)

~gep.chromosomes.do({|orf| [orf.asExpressionTree(false).asFunctionString.size, orf.score].postln  })

~gep.chromosomes.do({|orf| orf.asExpressionTree(false).asFunctionString.postln  })

~gep.at(19).code

~gep.maxScoreORFs.first.asExpressionTree(false).asFunctionString

~tree = ExpressionTree(~gep.maxScoreORFs.last)

~tree.root

.nodes.do({|node|
	node.value.postln
})

.do({|node|
	node.nodes.postln
})


//gen 37:
f={|a,b,c| or(  and( c, a ),  and(  or( a, c ), b ),  and(  or(  or( c, a ), b ),  or( a, a ) ) )}

// gen 1:
f={|a,b,c| or(  and(  and( b, c ), c ),  and(  and(  or( c, b ), a ),  or( b, c ) ) )}

// gen 38
f = {|a,b,c| or(  and( c, b ),  and( a,  or( b, c ) ) )}

// gen 55
f = {|a,b,c| or(  not(  not(  and(  and( a, a ),  and( b, c ) ) ) ),  and(  or( a,  and( b, c ) ),  or( b, c ) ) )}

// gen 1

f = {|a,b,c| or(  and( a,  or( c, b ) ),  and( b, c ) )}

~mr = {|a, b, c| 
	if ([a, b, c].collect(_.binaryValue).sum > 1) { true } { false } 
};


8.do({|i|
	var args;
	args = i.asDigits(2,3).collect(_.booleanValue);
	[~mr.(*args), f.(*args)].postln
});

