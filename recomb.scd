~headsize = 5;
~tailsize = 6;
~genesize = ~headsize + ~tailsize;

~numgenes = 5;

a=(0..(~headsize+~tailsize*~numgenes-1));
b=a.copy+100;

~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(40, ~numgenes, ~headsize, ~methods, ~terminals, True.methods.select({|meth| [\or].includes(meth.name)  }).first);

~gep.chromosomes.first.code.clump(~genesize)
 
~gep.recombinationRate = 1.0

~gep.geneRecombinationRate = 0.5

~gep.singleRecombination(a, b).do(_.postln)

~gep.multipleRecombination(a, b).do(_.postln)

~gep.geneRecombination(a, b).do(_.postln)

a

~gep.transposeInsertSequence(a)

a.clump(~genesize)

~tis = {|code, genesize, headsize|
	var sourceindex, head, targetindex, seqlen, newcode;
	newcode = code.copy;
	targetindex = rrand(0, code.size-genesize).round(genesize) + 1;
	seqlen = rrand(1,3);
	[seqlen, targetindex].postln;
	sourceindex = targetindex + rrand(1, genesize-seqlen);
	head = code[(sourceindex..sourceindex+seqlen-1)] ++ 
		code[(targetindex..targetindex+headsize-seqlen-1)];
	(targetindex..targetindex+headsize-2).do({|index, i|
		newcode[index] = head[i]
	});
	newcode
}

~tr = {|code, genesize, headsize|
	var sourceindex, head, targetindex, seqlen, newcode, root, find;
	newcode = code.copy;
	targetindex = rrand(0, code.size-genesize).round(genesize);
	seqlen = rrand(1,4);
	sourceindex = targetindex + rrand(1, genesize-seqlen);
	find = code[(targetindex..targetindex+headsize-1)].drop(sourceindex-targetindex)
		.selectIndices({|pos| ~terminals.includes(pos).not }).first;
	if (find.notNil)
	{
		sourceindex = sourceindex + find;
		[targetindex, sourceindex, seqlen].postln;	
		head = code[(sourceindex..sourceindex+seqlen-1)] ++ 
			code[(targetindex..targetindex+headsize-seqlen-1)];
		(targetindex..targetindex+headsize-1).do({|index, i|
			newcode[index] = head[i]
		});
	};
	newcode
}

x=~tis.(a, ~genesize, ~headsize)

x.clump(~genesize)

rrand(0, a.size-~genesize).round(~genesize)

a=~gep.at(5).code

~gep.at(2).asSymbols.clump(~genesize)

a.do(_.postln)

i=rrand(1, ~headsize-1)
a[a.keep(~genesize).drop(i).selectIndices({|pos| ~terminals.includes(pos).not }).first..rrand(2,4)]

b=~tr.(a, ~genesize, ~headsize)
b.clump(~genesize)


~gep.at(5).asSymbols.clump(~genesize)

b.collect({|it| if (it.class == Symbol) { it } { it.name }  }).clump(~genesize)

(
a.clump(~genesize)
)
(
b.clump(~genesize)
)

x=\a

if (x.class == Symbol) { "yes" }


// gene transposition

(
~headsize = 5;
~numgenes = 5;
~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(40, ~numgenes, ~headsize, ~methods, ~terminals, True.methods.select({|meth| [\or].includes(meth.name)  }).first);
)

~gep.geneTranspositionRate = 1.0

a=~gep.at(0).code
b=~gep.transposeGene(a)

a.clump(~gep.geneSize)
b.clump(~gep.geneSize)

