(
~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 4;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });
~data = ~meta.collect({|meta|
	var path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { UGEP.loadData(path) }
});
~inds = ~data.selectIndices({|data| data.header.headsize == ~headsize  });
~meta = ~inds.collect({|index| ~meta[index] });
~data = ~inds.collect({|index| ~data[index] });
~list = ~data.collect(_.code);
)


~meta.first.args

~data.first.keys

Server.local.boot;

(

~decoder = FoaDecoder(decoderType:'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikrofunkt/*");

~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromList(~list, ~numgenes, ~headsize, ~linker);

~graphics = CinderApp();

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics);

~argslist = ~meta.collect({|meta|
	var args = meta.args;
	GEPChromosome(args.code, ~genetic.cospecies.terminals, ~gep.terminals.size, ~genetic.cospecies.linker)
		.constants_(args.constants).extraDomains_(args.extraDomains)
});

~genetic.cospecies.replacePopulation(~argslist);

~genetic.convertArgs;

~data = ~data.select({|it, i| ~genetic.nilIndices.includes(i) })

)

~genetic.prepareAnalyzers;

~genetic.defs.collect(_.name).do(_.postln)


~input.mainamp_(0.0);

s.queryAllNodes

~task.clear

(
~task = Tdef(\play, {
	~genetic.defs.collect(_.name).drop(50).do({|defname|
		defname.postln;
		~genetic.play(defname, rrand(1.0, 8.0), rrand(1.0, 8.0), rrand(1.0, 8.0));
		0.5.wait;
		~genetic.set(defname, 0.2);
		5.wait;
		~genetic.free(defname);
		0.5.wait;
	})
}).play
)

(
~def = '000_002';

~genetic.play(~def, 8.0, 4.0, 7.0);

)

~genetic.set(~def, 0.0)

~genetic.free('000_001')


~genetic.fade(~def, 0.0, 0.4, 4)

~genetic.fade(~def, 0.4, 0.0, 2)




~genetic.tag(~def)

~genetic.tag(~def, 2)

~genetic.store.keys(Array).sort.do(_.postln)

~genetic.store.select({|it| it == 2 }).size

~genetic.store['000_075'] = nil

~genetic.store['000_166'] 

~genetic.store.keys(Array).sort.

"000_131".drop(4).asInt

~genetic.store.select({|it| it == 2 }).keys(Array).sort.collect({|key|
	var index, co;
	index = key.asString.drop(4).asInt;
	co = ~genetic.cospecies.chromosomes[index];
	~gep.chromosomes[index].asUgenExpressionTree.saveAsSynthDef(key, Pan2, Normalizer, 
		('code': co.code, 'tag': 2, 'constants': co.constants, 'extraDomains': co.extraDomains, 'defname': key),
		2
	);
	~gep.saveData(index, key)
})


~genetic.store.select({|it| it == 1 }).keys(Array).sort.collect({|key|
	var index, co;
	index = key.asString.drop(4).asInt;
	co = ~genetic.cospecies.chromosomes[index];
	~gep.chromosomes[index].asUgenExpressionTree.saveAsSynthDef(key, Pan2, Normalizer, 
		('code': co.code, 'tag': 1, 'constants': co.constants, 'extraDomains': co.extraDomains, 'defname': key), 
		1
	);
	~gep.saveData(index, key)
})
