~coll = UGenGraphGEP();

~methods = ~coll.ugenCollection.select({|ugen| 
	var argNames;
	if (ugen.class.methods.notNil) {
		if (ugen.class.methods.select({|mth| mth.name == 'ar' }).size > 0 ) {
			argNames = ugen.class.methods.select({|mth| mth.name == 'ar' }).first.argNames
		}
		{
			argNames = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first.argNames
		}
	}
	{
		argNames = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first.argNames
	};
	(argNames.drop(1) == SymbolArray[\freq, \mul, \add]).or(argNames.drop(1) == SymbolArray[\freq, \phase, \mul, \add])
	.or(argNames.drop(1) == SymbolArray[\freq, \iphase, \mul, \add])
}).collect({|ugen|  
	var ar;
	if (ugen.class.methods.notNil) {
		if (ugen.class.methods.select({|mth| mth.name == 'ar' }).size > 0 ) {
			ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first
		}
		{
			ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
		}
	}
	{
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar	
});

~terminals = [\freq, \mul, \add, \phase, \iphase];
~gep = GEP(40, 1, 20, ~methods, ~terminals);

~gep.chromosomes.do({|ch| ch.code.postln })

~gep.chromosomes.do({|ch| ch.translate.postln })