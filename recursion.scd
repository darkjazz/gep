(
~headsize = 5;
~numgenes = 2;
~populationSize = 10;

~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(~populationSize, ~numgenes, ~headsize, ~methods, ~terminals, True.methods.select({|meth| [\or].includes(meth.name)  }).first);
)

~code = ~gep.at(1).code

~code.clump((~code.size/~numgenes).asInt)

~gep.at(1).asSymbols.clump(~gep.geneSize)

~gep.at(1).translate

~tree=~gep.at(1).asExpressionTree(false)

~tree.asFunctionString


or ( and( and( b, b ), c ) , and( not( and( b, a ) ), not( a ) ) )

or( not(b), and( or (not(c), not(b)), b)

(or: [
	(not: [ b ]),
	(and: [ 
		(or: [
			(not: [ c ]),
			(not: [ b ])
		]),
		b
	])
])


and( not( not( a ) ), not( and(a, b) ) )

~gep.at(1).asSymbols.clump(~gep.geneSize).first

[ and, or, a, and, and, not, or, b, and, c, and, d, e, f, g, h, i, j, k, l, m, n, o ]


and( or, a ) 			[0]
or( and[3], and[4] ) 	[1]
and( not, or ) 		[3]
and( b, and ) 		[4]
not( c ) 				[5]
or( and, d )			[6]
and( e, f )			[8]
and( g, h )			[10]

and(
	or(
		and(
			not( c ),
			or( 
				and( g, h ),
				d
			)
		),
		and(
			b,
			and( e, f )
		)
	),
	a
)


~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });

~methods.collect(_.name)

~gene = [ ~methods[1], ~methods[2], \a, ~methods[1], ~methods[1], ~methods[0], ~methods[2], \b, ~methods[1], \c, ~methods[1], \d, \e, \f, \g, \h, \i, \j, \k, \l, \m, \n, \o]

~gene = ~code.clump(~gep.geneSize).first

~gene = ~gep.maxScoreORFs.first.code.clump(~gep.geneSize).first

~gene = ~gep.at(1).code.clump(~gep.geneSize).first



(
~argindex = 1;

~array = ~gene.collect({|codon, i|
	var indices;
	if (codon.isKindOf(Method)) {
		var event = ();
		indices = (~argindex..~argindex+codon.argNames.size-1);
		~argindex = ~argindex + indices.size;
		event[i] = indices;
		
	}
}).select(_.notNil);

~appendArgs = {|ev, array|
	var nodes;
	ev.postln;
	nodes = ev.values.pop.collect({|ind| 
		if (~gene[ind].isKindOf(Method)) {
			~appendArgs.(array.select({|sev| sev.keys.pop == ind }).first, array ) 
		} {
			GepNode(~gene[ind])
		}
	}); 
	
	GepNode(~gene[ev.keys.pop], nodes)
};

~root = ~appendArgs.(~array.first, ~array)

)

~root.nodes.first.value

~array.select({|ev| ev.keys.pop == 1 }).first

(
// depth-first
~addNext = {|codon|
	var indices;
	if (codon.isKindOf(Method)) {
		var event = ();
		indices = (~argindex..~argindex+codon.argNames.size-1);
		~argindex = ~argindex + indices.size;
		event[codon.name] = indices.collect({|ind| ~addNext.(~gene[ind]) }) 
	}
	{
		codon
	}
}
)

(
//breadth-first
~addNext = {|list, depth=0|
	list.collect({|codon|
		if (codon.isKindOf(Method)) {
			var list, indices, event = ();
			indices = (~argindex..~argindex+codon.argNames.size-1);
			~argindex = ~argindex + indices.size;
			list = indices.collect({|ind|
				~gene[ind]
			});
			event[codon.name] = ~addNext.(list, depth + 1)
		}
		{
			codon
		}		
	})
	
}
)

(
~argindex = 1;
~tree=~addNext.(List.with(~gene.first))
)
