(
~dir = "2013-03-11";
// load prepared chromosomes
~data = UGEP.loadDataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/data");
~meta = UGenExpressionTree.loadMetadataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/metadata/");

//~file = File.open("/Users/alo/SuperCollider/gep/selected.scd", "r");
//~str = ~file.readAllString.split(Char.nl);
//~file.close;
//
//~map = ();
//
//~str.do({|it| var key, val; #key, val = it.split($:); ~map[key.asSymbol] = val });
//
//~map = ~map.collect(_.asInt);
//
//~listIndices = ~meta.selectIndices({|meta| ~map[meta.defname.asSymbol] == 2 });

~listIndices = ~meta.selectIndices({|meta| meta.stats == 2 })

~list = ~listIndices.collect({|index| ~data[index].code });
)

Server.local.boot;

(
~ncoef = 20;
~rate = 20;
~headsize = ~data.first.header.headsize;
~numgenes = ~data.first.header.numgenes;

~decoder = FoaDecoder(decoderType:'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikrofunkt/*");
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/eclambone_samples/*");

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromList(~list, ~numgenes, ~headsize, ~linker);

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics);

~argslist = ~listIndices.collect({|index| 
	var args = ~meta[index].args;
	GEPChromosome(args.code, ~genetic.cospecies.terminals, ~gep.terminals.size, ~genetic.cospecies.linker)
		.constants_(args.constants).extraDomains_(args.extraDomains)
});

~genetic.cospecies.replacePopulation(~argslist);

~genetic.convertArgs;

)


~genetic.prepareAnalyzers;

~input.mainamp_(0.0)

~genetic.defs.collect(_.name)

s.sendMsg("/n_free", 1050)

~genetic.generateNewDefs(~gep.chromosomes[0], ~gep.chromosomes[30])

(
~def00 = '000_051';
~genetic.play(~def00, 8.0, 4.0, 7.0);
~genetic.fade(~def00, 0.0, 0.3, 3)
)

~genetic.fade(~def00, 0.3, 0.0, 25)

~genetic.set(~def00, 0.0)

~genetic.free(~def00)

MasterEQ(2)

s.queryAllNodes

(
~def01 = '000_050';

~genetic.play(~def01, 20.0, 14.0, 22.0);

~genetic.fade(~def01, 0.0, 0.2, 7)
)

~genetic.fade(~def01, 0.3, 0.0, 10)

~genetic.set(~def01, 0.2)

~genetic.free(~def01)


s.queryAllNodes


(
~def02 = '000_048';

~genetic.play(~def02, 8.0, 4.0, 7.0);

~genetic.fade(~def02, 0.0, 0.3, 3)
)

~genetic.fade(~def02, 0.3, 0.0, 10)

~genetic.set(~def02, 0.3)

~genetic.free(~def02)


s.queryAllNodes


(
~def03 = '000_047';

~genetic.play(~def03, 3.0, 1.5, 4.0);

~genetic.fade(~def03, 0.0, 0.4, 8)
)

~genetic.fade(~def03, 0.4, 0.0, 10)

~genetic.set(~def03, 0.2)

~genetic.free(~def03)


s.queryAllNodes


(
~def04 = '000_049';

~genetic.play(~def04, 2.0, 5.0, 4.0);

~genetic.fade(~def04, 0.0, 0.4, 8)
)

~genetic.fade(~def04, 0.3, 0.0, 15)

~genetic.set(~def04, 0.2)

~genetic.free(~def04)


s.queryAllNodes


