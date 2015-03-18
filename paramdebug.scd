~paramgep.chromosomes.collect({|chrom, i|
	var rawargs;
	
	rawargs = chrom.asExpressionTree(false).asFunctionString.interpret
		.value(*chrom.constants);
//	rawargs.collect({|num, i| 
//		chrom.extraDomains[i].map(num.wrap(0.0, 1.0)).roundFreq 
//	})
});

~paramgep.at(0)