~methods = True.methods.select({|meth| [\or, \and, \not].includes(meth.name)  });
~terminals = [\a, \b, \c];
~gep = GEP(20, 1, 3, ~methods, ~terminals);

~gep.tailsize


~gep.maxNumberOfArgs

~gep.chromosomes.first

~gep.translateORF(0)

c = Array.fill(20, {
	var indv;
	indv = ORF.with(~methods.choose);
	indv ++ ORF.fill(2, { [~methods, ~terminals].choose.choose });
})

o = ~gep.chromosomes[9]
o.collect({|it| if (it.isKindOf(Method)) { it.name } { it }  })


o.do({|item, i|
	if (item.isKindOf(Method)) {
		
	}
})

~gep.chromosomes.do({|chrm|
	~addNext.(chrm).postln;
	chrm.collect({|it| if (it.isKindOf(Method)) { it.name } { it }  }).postln;
	"".postln;
})

(
// index 1
o = ~gep.chromosomes[3];
~depth = 0;
~str = ~addNext.(o);
o.collect({|it| if (it.isKindOf(Method)) { it.name } { it }  }).postln;
~str;
)


(
~addNext = {|orf, index=0, argindex=1|
	var str = "", indices;
	if (orf[index].isKindOf(Method)) {
		("adding method: " ++ orf[index].name.asString ++ " at index: " ++ index.asString).postln;
		str = str + orf[index].name.asString ++ "( ";
		indices = (argindex..argindex+orf[index].argNames.size-1); 
		argindex = argindex + indices.size;
		[index, indices].postln;
		indices.do({|ind, i|
			("adding arg " ++ i.asString ++ " to method: " ++ orf[index].name.asString).postln;
			str = str ++ ~addNext.(orf, ind, argindex + ~depth);
			if (i < indices.lastIndex) { str = str ++ ", " }
		});		
		str = str ++ " )";
	}
	{
		~depth = ~depth + 1;
		("adding terminal: " ++ orf[index].asString ++ " at index: " ++ index.asString).postln;
		str = str ++ orf[index].asString
	};
	str
}

)


~code = 

~addNext = {|index=0, argindex=1|
	
}