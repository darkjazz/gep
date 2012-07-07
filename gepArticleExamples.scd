(
~headsize = 5;
~numgenes = 2;
~populationSize = 20;

~ugens = [SinOsc, LFSaw, LFNoise2, Dust2];

~methods = ~ugens.collect({|ugen| 
	var ar;
	ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first;
	if (ar.isNil) {
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar
});

~terminals = (~methods.collect(_.argNames).collect(_.size).maxItem + ~headsize).collect({|i|
	(97 + i).asAscii.asSymbol
});

~gep = UGEP(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

)

~et = ~gep.chromosomes.collect({|orf|
	orf.asUgenExpressionTree
});

~et.do({|et, i|
	i.post; "   ".post;
	et.asFunctionString.postln;
	"----".postln
})

~gep.headsize

~gep.geneSize

~gep.at(10).code

~asCharString.(~gep.at(5).code)

~gep.recombinationRate = 1.0

~newcodes = ~gep.recombineMultiple(~gep.at(1).code, ~gep.at(5).code)

~asCharString.(~newcodes.last)

~orfA = ORF(~newcodes.first, ~terminals, ~numgenes, AbstractFunction.methods.select({|meth| meth.name == '*' }).first)


~orfB = ORF(~newcodes.last, ~terminals, ~numgenes, AbstractFunction.methods.select({|meth| meth.name == '*' }).first)

~orfA.asUgenExpressionTree.asFunctionString

~orfB.asUgenExpressionTree.asFunctionString


~asCharString = {|code|
	var name, string = "";
	code.do({|codon|
		if (codon.isKindOf(Symbol)) {
			string = string ++ codon.asString;
		}
		{
			codon.name.asSymbol.switch
				{\SinOsc} { name = "O" }
				{\LFSaw} { name = "S" }
				{\LFNoise2} { name = "N" }
				{\Dust2} { name = "D" };
			string = string ++ name.asString
		}
	});
	string
}

{|a,b,c,d,e,f,g,h| (  LFNoise2.ar( SinOsc.ar(a, d, c, c ),  SinOsc.ar(d, h, e, c ), g ))*( LFSaw.ar( Dust2.ar(h, f, b ), f, d, a ) )}

[ LFNoise2, SinOsc, SinOsc, \g, \a, \d, \c, \c, \d, \h, \e, \c, \c, LFSaw, Dust2, \f, \d, \a, \h, \f, \b, \b, \h, \a, \h, \e ]


SODOOdefadjfahffggffaODSNOhbddjceedaecihii

{|a,b,c,d,e,f,g,h,i,j| (  LFSaw.ar( SinOsc.ar(d, e, f, a ),  Dust2.ar(d, j, f ),  SinOsc.ar(a, h, f, f ),  SinOsc.ar(g, g, f, f ) ))*( SinOsc.ar( Dust2.ar(h, b, d ),  LFSaw.ar(d, j, c, e ),  LFNoise2.ar(e, d, a ),  SinOsc.ar(e, c, i, h ) ) )}


DDDNSajijgiabegidddeeSgiOSadebggbjjgdjieeb

{|a,b,c,d,e,f,g,h,i,j| (  Dust2.ar( Dust2.ar( LFSaw.ar(e, g, i, d ), a, j ),  Dust2.ar(i, j, g ),  LFNoise2.ar(i, a, b ) ))*( LFSaw.ar(g, i,  SinOsc.ar(a, d, e, b ),  LFSaw.ar(g, g, b, j ) ) )}



DDDNSajijgifahffggffaODSNOhbddjgbjjgdjieeb

{|a,b,c,d,e,f,g,h,i,j| (  Dust2.ar( Dust2.ar( LFSaw.ar(h, f, f, g ), a, j ),  Dust2.ar(i, j, g ),  LFNoise2.ar(i, f, a ) ))*( SinOsc.ar( Dust2.ar(h, b, d ),  LFSaw.ar(d, j, g, b ),  LFNoise2.ar(j, j, g ),  SinOsc.ar(d, j, i, e ) ) )}


SODOOdefadjabegidddeeSgiOSadebgceedaecihii

{|a,b,c,d,e,f,g,h,i,j| (  LFSaw.ar( SinOsc.ar(d, e, f, a ),  Dust2.ar(d, j, a ),  SinOsc.ar(b, e, g, i ),  SinOsc.ar(d, d, d, e ) ))*( LFSaw.ar(g, i,  SinOsc.ar(a, d, e, b ),  LFSaw.ar(g, c, e, e ) ) )}


