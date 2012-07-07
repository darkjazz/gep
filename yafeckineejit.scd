(
~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});


~datanames = "/Users/alo/Data/gep/data/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~data = ();

~defnames.do({|name|
	var meta, path, data, arch, defname;
	defname = name.asString;
	arch = ZArchive.read("/Users/alo/Data/gep/metadata/" ++ defname ++ ".gepmeta");
	meta = arch.readItem;
	arch.close;
	if (defname.size == 40) {
		defname = defname.keep(defname.size - 13)
	};
	path = "/Users/alo/Data/gep/data/" ++ defname ++ ".gepdata";
	if (path.pathMatch.size == 1) {
		data = ();
		data[\meta] = meta;
		data[\data] = UGEP.loadData("/Users/alo/Data/gep/data/" ++ defname ++ ".gepdata");
		~data[defname.asSymbol] = data
	};
});

)


(

~defs = ~data.collect({|alldata, key|
	var name, orf, def, tree;
	name = key.asString.insert(14, "_").asSymbol;
	orf = ORF(alldata.data.code, alldata.data.terminals, alldata.data.header.numgenes, alldata.data.linker);
	tree = orf.asUgenExpressionTree;
	def = tree.asSynthDefString(name, Pan2, Normalizer).interpret;	def
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
		
		("mv" + (UGEP.archDir +/+ key.asString ++ "." ++ UGEP.fileExt) 
			+ (UGEP.archDir +/+ def.name.asString ++ "." ++ UGEP.fileExt) ).unixCmd;
		
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
			~gepAnalyzer.asEvents(key));
		
	});
	
	~gepAnalyzer.clear;
	
}).play

)




// AND DELETE THE OLD CRAP

~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	(path: path, filename: path.split($.).first.drop(path.find("gep_")))
});

~defnames = ~defnames.select({|ev| ev.filename.size != 28 })

~defnames.do({|ev|
	("rm" + ev.path).unixCmd;
	("rm" + "/Users/alo/Data/gep/metadata/" ++ ev.filename ++ ".gepmeta").unixCmd
})