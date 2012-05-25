f = {|a, b, c| if ([a, b, c].collect(_.binaryValue).sum > 1) { true } { false } }

g = {|a,b,c|  and(  or( a, b ),  or(  or( b, c ), b ) )}


// AWESOME YEAH!!! FOUND IT!!! GENERATION = 7, numgenes = 2
g = {|a,b,c| or(  and( c,  or( a, b ) ),  and( b, a ) )}

8.do({|i|
	f.(*i.asDigits(2, 3).collect(_.booleanValue)).postln
})

8.do({|i|
	g.(*i.asDigits(2, 3).collect(_.booleanValue)).postln
})


~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(40, 2, 3, ~methods, ~terminals, True.methods.select({|meth| [\or].includes(meth.name)  }).first);


~gep.tailsize

(
~gep.chromosomes.do({|orf|
	var score=0, ofnc;
	ofnc = orf.translate.interpret;
	8.do({|i|
		var args, ofunc;
		args = i.asDigits(2,3).collect(_.booleanValue);
		if (f.(*args) == ofnc.(*args)) {
			score = score + 1
		}
	});
	orf.score = score
})
)

~mean = ~gep.chromosomes.collect({|chr| chr.score }).mean

~max = ~gep.chromosomes.collect(_.score).maxItem

~gep.chromosomes.selectIndices({|chr| chr.score == 8})

~gep.chromosomes.do({|chr| chr.score.postln  })
~gep.chromosomes.do({|chr| chr.code.postln  })
~gep.chromosomes.do({|chr| 
	chr.code.collect({|it| if (it.isKindOf(Method)) { it.name } { it }  }).postln
})




~gep.chromosomes[28].translate

(
~winnerIndices = ~gep.chromosomes.selectIndices({|chr| chr.score >= ~mean }).scramble.keep(10);
if (~winnerIndices.size < 10) {
	(10-~winnerIndices.size).do({
		~winnerIndices = ~winnerIndices.add(~gep.populationSize.rand)
	})	
};
~newcodes = ~winnerIndices.collect({|ind|
	var code, other;
	other = ~winnerIndices.select({|indB| indB != ind  }).choose;
	code = ~gep.simpleCrossover( ~gep.chromosomes[ind].code, ~gep.chromosomes[other].code );
	~gep.mutate(code);
	code.postln;
	code;
});

)


(
~loserIndices = ~gep.chromosomes.selectIndices({|chr| chr.score <= ~mean }).scramble.keep(10);
if (~loserIndices.size < 10) {
	(10-~loserIndices.size).do({
		~loserIndices = ~loserIndices.add(~gep.populationSize.rand)
	})
};
~loserIndices.do({|ind, i|
	~gep.chromosomes[ind].code = ~newcodes.wrapAt(i)
});

)








~xover = {|codeA, codeB|
	var newcode, xoverpoints, point, off;
	newcode = Array.newClear(codeA.size);
	point = (codeA.size - 2).rand + 1;
	off = 2.rand.booleanValue;
	codeA.do({|element, i|
		if (off) { newcode[i] = codeA[i] } { newcode[i] = codeB[i] };
		if (i == point) { off = off.not }
	});
	newcode
}

~mutation = {|code|
	var index;
	index = code.size.rand;
	if (code[index].isKindOf(Method)) {
		code[index] = ~methods.select({|mth| mth != code[index] }).choose
	}
	{
		code[index] = ~terminals.select({|trm| trm != code[index] }).choose
	}
}