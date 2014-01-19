Server.local.boot;

(
~ncoef = 20;
~rate = 20;
~headsize = 7;
~numgenes = 4;
~populationSize = 32;

~mode = 1;

~decoder = FoaDecoder();
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/input/shellylivecode.aiff");
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/input/mykola.aiff");
~input = MikroFoaInput(~decoder);

~graphics = CinderApp(1024, 768, mode: ~mode);

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newRandomFromLibrary(~populationSize, ~numgenes, ~headsize, ~linker, ~excludeUGenList);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics);
 
)

(
~genetic.prepareAnalyzers;
~graphics.open;
)

~input.synth.set(\mamp, 0.0);


~genetic.assignCodeWindow(Document.current);

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 20.0, 50.0, 0.0, 0.0, 0.0);

Tdef(\sendWeights, {
	loop({
		~graphics.sendWeights(*~genetic.inputAnalyzer.currentCoefficients);
//		~genetic.inputAnalyzer.currentCoefficients.postln;
		0.1.wait;	
	})
}).play


Tdef(\sendWeights).clear

(
~genetic.evaluateCurrentPopulation(3, {|genetic|
	~genetic.meanStats;
	Post << "Analysis completed!" << Char.nl;
})

)

s.queryAllNodes
s.sendMsg("/n_free", 1016)

~genetic.distances.do(_.postln)

~genetic.distances.keysValuesDo({|key, val| Post << key << ": " << val << Char.nl  })


~genetic.selectWeightedRandom

~genetic.generateNewDefs(*~genetic.selectWeightedRandom)

~genetic.generateNewDefs(~gep.chromosomes[1], ~gep.chromosomes[3])


~genetic.defs.collect(_.name)

~genetic.args.size

~genetic.defs.do({|def| def.name.postln  })


~genetic.play('000_000')

~genetic.fade('000_000', 0.0, 0.2, 3)

~genetic.fade('000_000', 0.1, 0.5, 3)

~genetic.set('000_000', 1.0)

~genetic.free('000_005')

~genetic.tag('000_000')




~genetic.play('000_007')

~genetic.set('000_007', 1.0)

~genetic.fade('000_003', 0.0, 0.2, 2)

~genetic.free('000_006')

~genetic.tag('000_001')



~genetic.play('000_002')

~genetic.set('000_002', 0.6)

~genetic.fade('000_002', 0.0, 0.3, 10)

~genetic.free('000_002')

~genetic.tag('000_002')


~genetic.play('000_003')

~genetic.set('000_003', 1.0)

~genetic.fade('000_024', 0.2, 0.8, 10)

~genetic.free('000_003')

~genetic.tag('000_012')



~genetic.play('000_001')

~genetic.set('000_009', 0.0)

~genetic.fade('000_001', 0.0, 0.3, 10)

~genetic.free('000_009')

~genetic.tag('000_009')




~genetic.play('000_015')

~genetic.set('000_015', 0.7)

~genetic.fade('000_007', 0.1, 0.4, 4)

~genetic.free('000_007')

~genetic.tag('000_007')




~genetic.postTags

s.queryAllNodes

~genetic.play('000_020')

~genetic.set('000_020', 1.0)

~genetic.free('000_020')


~genetic.play('000_021')

~genetic.set('000_021', 0.5)

~genetic.free('000_021')


~genetic.play('000_023')

~genetic.set('000_023', 1.0)

~genetic.free('000_022')


~genetic.play('000_020')

~genetic.set('000_020', 0.2)

~genetic.free('000_020')


~genetic.play('000_024')

~genetic.set('000_024', 1.0)

~genetic.free('000_024')


~genetic.play('000_024')

~genetic.set('000_024', 0.0)

~genetic.free('000_030')


s.queryAllNodes



~genetic.play('000_042')

~genetic.set('000_042', 0.5)

~genetic.free('000_042')


~genetic.play('000_043')

~genetic.set('000_043', 0.5)

~genetic.free('000_043')






~genetic.set('000_058', 0.7)

~genetic.set('000_037', 0.5)

~genetic.free('000_002')

~genetic.free('000_031')


~genetic.play('000_009')

~genetic.play('000_044')

~genetic.set('000_003', 0.0)

~genetic.set('000_010', 0.0)

~genetic.set('000_034', 0.9)


~genetic.free('000_034')

~genetic.synths






//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 1, 1.0, 0, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 1, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);


~rot = Rotation(40.0, 0.01, 20.0, 60.0, 0.0, 0.08, 0.0, 0.07);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


"FUCK THE IDE"
"THANKS FOR RUINING MY SO CALLED LIFE"