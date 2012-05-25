(
s.loadDirectory("/Users/alo/Data/gep/synthdefs/");

~defnames = "/Users/alo/Data/gep/synthdefs/*".pathMatch.collect({|path|
	path.split($.).first.drop(path.find("gep_")).asSymbol
});

//load metadata
~args = (); 

~defnames.do({|name|
	var args, arch = ZArchive.read("/Users/alo/Data/gep/metadata/" ++ name.asString ++ ".gepmeta");
	args = arch.readItem;
	arch.close;
	~args[name] = args
});

~defnames.sort({|a, b| a.asString.split($_).last < b.asString.split($_).last });

)