(
~dir = "2013-03-11";
// load prepared chromosomes
~data = UGEP.loadDataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/data");
~meta = UGenExpressionTree.loadMetadataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/metadata/");

~listIndices = ~meta.selectIndices({|meta| meta.stats == 2 });

~list = ~listIndices.collect({|index| ~data[index].code });

Server.local.boot;
)


(
~ncoef = 20;
~rate = 20;
~headsize = ~data.first.header.headsize;
~numgenes = ~data.first.header.numgenes;
~mode = 0; // CHANGE TO 1 FOR LIVE

~decoder = FoaDecoder(decoderType:'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikrofunkt/*");

//~graphics = CinderApp(1024, 768, mode: ~mode);
~graphics = CinderApp(800, 600, mode: ~mode);

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromList(~list, ~numgenes, ~headsize, ~linker);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics, 1, 'addToHead');

~argslist = ~listIndices.collect({|index| 
	var args = ~meta[index].args;
	GEPChromosome(args.code, ~genetic.cospecies.terminals, ~gep.terminals.size, ~genetic.cospecies.linker)
		.constants_(args.constants).extraDomains_(args.extraDomains)
});

~genetic.cospecies.replacePopulation(~argslist);

~genetic.convertArgs;

)

~gep.methods.collect(_.name).sort

(
~genetic.prepareAnalyzers;
~genetic.assignCodeWindow(Document.current);
~graphics.open;
)

~input.mainamp_(0.0)

~genetic.defs.collect(_.name)


MasterEQ(2)


/*
GRAPHICS
*/
~graphics.open

//~graphics.initWorld(20, 20, 20, ~ncoef);
//
//~graphics.initGenerations([4,6,8], [3,5,7,9], 16);
//
//~graphics.setSymmetry(11)
//
//~graphics.setViewpoint(-70.0, 70.0, 60.0, 0.0, 0.0, 0.0)
//
//~graphics.setPattern(12, 1, 0.4, 1, 1, 0.6, 0.8, 1.0);
//
//~graphics.setPattern(12, 1, 0.4, 1, 1, 0.6, 0.8, 1.0);
//
//
//~graphics.setPattern(13, 0, 0.6, 0, 0, 0.6, 0.8, 1.0);
//
//~graphics.setPattern(8, 0, 0.6, 1, 1, 0.6, 0.8, 1.0);

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.05);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 1, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 1, 0.5, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 1, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);

//
//~graphics.sendPredefined3DRule(\xtasy)
//
//~graphics.sendPredefined3DRule(\brain6)
//
//~graphics.sendPredefined3DRule(\cooties)
//
//~graphics.sendPredefined3DRule(\nova)
//
//~graphics.sendPredefined3DRule(\faders)


~graphics.sendGenRule([2],[3,4,5],6) // starwars with 6 states

~rot = Rotation(140.0, 0.1, 100.0, 20.0, 0.0, 0.011, 0.0, 0.013);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~ciapp.stopRotation

~graphics.mapCodePanel


~ciapp.setFrameRate(16.0)

s.record
s.queryAllNodes

(
~def00 = '000_000';
~genetic.play(~def00, 8.0, 4.0, 7.0);
~genetic.fade(~def00, 0.0, 0.4, 10)
)

~genetic.fade(~def00, 0.4, 0.0, 20)

~genetic.set(~def00, 0.5)

~genetic.free(~def00)

s.queryAllNodes


(
~def02 = '000_001';
~genetic.play(~def02, 8.0, 4.0, 7.0);
~genetic.fade(~def02, 0.0, 0.3, 8)
)

~genetic.fade(~def02, 0.3, 0.0, 15)

~genetic.set(~def02, 0.3)

~genetic.free(~def02)


s.queryAllNodes


(
~def03 = '000_002';
~genetic.play(~def03, 3.0, 1.5, 4.0);
~genetic.fade(~def03, 0.0, 0.4, 10)
)

~genetic.fade(~def03, 0.4, 0.0, 20)

~genetic.set(~def03, 0.1)

~genetic.free(~def03)


s.queryAllNodes


(
~def04 = '000_050';
~genetic.play(~def04, 2.0, 5.0, 4.0);
~genetic.fade(~def04, 0.0, 0.4, 8)
)

~genetic.fade(~def04, 0.4, 0.0, 1)

~genetic.set(~def04, 0.5)

~genetic.free(~def04)

s.stopRecording

s.queryAllNodes


(
~def05 = '000_051';
~genetic.play(~def05, 2.0, 5.0, 4.0);
~genetic.fade(~def05, 0.0, 0.3, 8)
)

~genetic.fade(~def05, 0.3, 0.0, 10)

~genetic.set(~def05, 0.0)

~genetic.free(~def05)


s.sendMsg("/n_free", 1293)

\banners -> [[3,4,5,7],[2,3,6,7],5],
\belzhab -> [[2,3],[2,3],8],
\belzhabsedi -> [[2,3],[1,4,5,6,7,8],8],
\bloomerang -> [[3,4,6,7,8],[2,3,4],24],
\bombers -> [[2,4],[3,4,5],25],
\brain6 -> [[2,4,6],[6],3],
\briansbrain -> [[2],[],3],
\burst -> [[3,4,6,8],[0,2,3,5,6,7,8],9],
\burstII -> [[3,4,6,8],[2,3,5,6,7,8],9],
\caterpillars -> [[3,7,8],[1,2,4,5,6,7],4],
\chenille -> [[2,4,5,6,7],[0,5,6,7,8],6],
\circuitgenesis -> [[1,2,3,4],[2,3,4,5],8],
\cooties -> [[2],[2,3],8],
\ebbandflow -> [[3,6],[0,1,2,4,7,8],18],
\ebbandflowII -> [[3,7],[0,1,2,4,6,8],18],
\faders -> [[2],[2],25],
\fireworks -> [[1,3],[2],21],
\flamingstarbow -> [[2,3],[3,4,7],8],
\frogs -> [[3,4],[1,2],3],
\frost -> [[1],[],25],
\frozenspirals -> [[2,3],[3,5,6],6],
\glisserati -> [[2,4,5,6,7,8],[0,3,5,6,7,8],7],
\glissergy -> [[2,4,5,6,7,8],[0,3,5,6,7,8],5],
\lava -> [[4,5,6,7,8],[1,2,3,4,5],8],
\lines -> [[4,5,8],[0,1,2,3,4,5],3],
\livingonedge -> [[3],[3,4,5],6],
\meteorguns -> [[3],[0,1,2,4,5,6,7,8],8],
\nova -> [[2,4,7,8],[4,5,6,7,8],25],
\orthogo -> [[2],[3],4],
\prairiefire -> [[3,4],[3,4,5],6],
\rainzha -> [[2,3],[2],8],
\rake -> [[2,6,7,8],[3,4,6,7],6],
\sedimental -> [[2,5,6,7,8],[4,5,6,7,8],4],
\snake -> [[2,5],[0,3,4,6,7],6],
\softfreeze -> [[3,8],[1,3,4,5,8],6],
\spirals -> [[2,3,4],[2],5],
\starwars -> [[2],[3,4,5],4],
\sticks -> [[2],[3,4,5,6],6],
\swirl -> [[3,4],[2,3],8],
\thrillgrill -> [[3,4],[1,2,3,4],48],
\transers -> [[2,6],[3,4,5],5],
\transersII -> [[2,6], [0,3,4,5],6],
\wanderers -> [[3,4,6,7,8],[3,4,5],5],
\worms -> [[2,5],[3,4,6,7],6],
\xtasy -> [[2,3,5,6],[1,4,5,6],16]
