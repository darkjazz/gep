~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~datanames = "/Users/alo/Data/gep/data/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~namelenghts = ~defnames.collect(_.asString).collect(_.size)
~defnames[2]
~datanamelengths = ~datanames.collect(_.asString).collect(_.size)

~metadata = (); 
~data = ();

~defnames[0].asString.keep(~defnames[0].asString.size - 13)

~defnames.do({|name|
	var args, path, data, arch, defname;
	defname = name.asString;
	arch = ZArchive.read("/Users/alo/Data/gep/metadata/" ++ defname ++ ".gepmeta");
	args = arch.readItem;
	arch.close;
	~metadata[defname.asSymbol] = args;
	if (defname.size == 40) {
		defname = defname.keep(defname.size - 13)
	};
	path = "/Users/alo/Data/gep/data/" ++ defname ++ ".gepdata";
	if (path.pathMatch.size == 1) {
		data = UGEP.loadData("/Users/alo/Data/gep/data/" ++ defname ++ ".gepdata");
		~data[name] = data
	}
});

~metadata

~datanames.do({|name|
	
})

~data.size


~data.keys(Array).do(_.postln)

~item = ~data[\gep_gen003_069120524_211011120524_211011];

~chrom = GEPChromosome(~item.code, ~item.terminals, ~item.header.numgenes, ~item.linker)

~chrom.asUgenExpressionTree.asSynthDefString(\gep_gen003_069120524_211011120524_211011, Pan2, Normalizer)

~metadata[\gep_gen003_069120524_211011120524_211011].args

~metadata.size



(
~datanames = "/Users/alo/Data/test/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

~paths = (archDir: "/Users/alo/Data/test", fileExt: "gepdata");

~datanames.do({|key|
	var name = key.asString.insert(14, "_").asSymbol;
	("mv" + (~paths.archDir +/+ key.asString ++ "." ++ ~paths.fileExt) 
		+ (~paths.archDir +/+ name ++ "." ++ ~paths.fileExt) ).unixCmd;

})
)