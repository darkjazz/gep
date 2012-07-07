(
~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});


~datanames = "/Users/alo/Data/gep/data/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~data = ();

~defnames.do({|name|
	~data[name] = UGExpressionTree.loadMetadata(name)
});

~data = ~data.select({|data| data.stats.isNil  });

~defnames = ~defnames.reject({|name| ~data.includesKey(name).not });

~data = ~data.collect({|data, key|  
	var ev;
	ev = ();
	ev[\meta] = data;
	ev[\data] = UGEP.loadData("/Users/alo/Data/gep/data/" ++ key.asString ++ ".gepdata");
	ev
});

)


(

~defs = ~data.collect({|alldata, key|
	var orf, def, tree;
	orf = ORF(alldata.data.code, alldata.data.terminals, alldata.data.header.numgenes, alldata.data.linker);
	tree = orf.asUgenExpressionTree;
	def = tree.asSynthDefString(key, Pan2, Normalizer).interpret;	def
});
)


(

Routine({
	
	var fragdur=3, ncoef = 20, rate = 20;
	
	~gepAnalyzer = UGepAnalyzer(~defs, ncoef);
	
	s.sync;

	~data.keysValuesDo({|key, alldata|
		var def, synth, orf, tree;
		orf = ORF(alldata.data.code, alldata.data.terminals, alldata.data.header.numgenes, alldata.data.linker);
		tree = orf.asUgenExpressionTree;
		
		def = ~defs[key].add;
		
		~gepAnalyzer.currentDef = def.name.asSymbol;

		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		~gepAnalyzer.run(rate: rate);
		synth = Synth.before(~gepAnalyzer.synth, def.name, [\out, ~gepAnalyzer.bus] 
			++ alldata.meta.args);
		fragdur.wait;
		synth.free;
		synth = nil;
		~gepAnalyzer.freeSynth;	
		tree.saveAsSynthDef(def.name, Pan2, Normalizer, alldata.meta.args, 
			~gepAnalyzer.asEvents(def.name.asSymbol));
		
	});
	
	~gepAnalyzer.clear;
	
}).play

)
