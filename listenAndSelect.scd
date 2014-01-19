Server.local.boot;

(
~ncoef = 20;
~rate = 20;
~headsize = 7;
~numgenes = 4;

~decoder = FoaDecoder(decoderType:'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikrofunkt/*");
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/eclambone_samples/*");

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromLibrary(~numgenes, ~headsize, ~linker, ~excludeUGenList);

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics);

)

~genetic.prepareAnalyzers;

~genetic.defs.collect(_.name).do(_.postln)


~input.mainamp_(0.0);

s.queryAllNodes

(
~def = '000_171';

~genetic.play(~def, 8.0, 4.0, 7.0);

~genetic.fade(~def, 0.0, 0.4, 4)
)

~genetic.fade(~def, 0.4, 0.0, 2)

~genetic.set(~def, 0.2)

~genetic.free(~def)

~genetic.tag(~def)

~genetic.tag(~def, 2)

~genetic.postTags

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


MasterEQ(2)

s.queryAllNodes
s.sendMsg("/n_free", 1784)