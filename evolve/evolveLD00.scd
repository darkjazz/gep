(
~ev = EvolverEnvir(
	(
		ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 1.0, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0
	)
);


[ 'gep_gen003_000_141027_104544', 'gep_gen002_024_141026_003337' ].do({|name|
	~ev.addChromosomeByDefname(name)
});

~recordPath = "/Users/alo/snd/evolver/"
)



~ev.initializePopulation


(
// evolve n generations, each doubling in size
7.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

)
Server.killAll

~gep.chromosomes.size


~ev.extractTargetFeatures("/Users/alo/snd/evolver/gep_gen006_006_220507_030358.aiff")


~ev.defineFitnessFunction

~gep.updateScores



~th = 6.5
~gep.chromosomes.collect(_.score).select({|sc| sc > ~th }).size

~inds = Pseq(~gep.chromosomes.collect(_.score).selectIndices({|sc| sc > ~th }), 1).asStream
2.do({ ~index.next })


~ev.playOne(~inds.next)


~ev.play


~indices = [ ]


~ev.save(~indices, true, 11, true)

~player.stop

(
// for each next generation
~paramgep.nextGeneration;
~gep.nextGeneration;
)



~gep.headsize
.updateScores

~gep.chromosomes.size

.code.size
.select(_.isKindOf(Class)).size

~gep.drawDistanceMatrix(10)

~gep.draw

~gep.drawScroll

~gep.drawCompare(0, 1)

~gep.drawUGenTree(6, ~ugens);
~gep.drawUGenTree(0, ~ugens);

~defs[2].name

~th = 7.0



~ev.play

~ev.playOne(8)

Ndef('rerout', {
	Out.ar(2, In.ar(0, 2))
}).play

~indices = [6]

~ev.save(~indices, false, 8)


s.scope(2)


~gep.chromosomes[8].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes[0].asUgenExpressionTree.asSynthDefString('synth_47', Pan2, Limiter, false)


SynthDef('synth_47', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k|  Out.ar(out,Pan2.ar(Limiter.ar(LeakDC.ar((  SyncSaw.ar( Saw.ar( LFNoise2.ar(f, e,  Formant.ar(g, c, g, e, i ) ),  Saw.ar(d, i,  Blip.ar(c, c, i, c ) ), h ),  Formant.ar( Formant.ar(a,  Formant.ar(e, e, i, j, g ),  Dust2.ar(c, d, h ),  SyncSaw.ar(a, b, a, j ),  SyncSaw.ar(g, b, a, e ) ),  LFPar.ar(a, i, j, b ),  Saw.ar(h, b, e ),  LFPar.ar(d, a, g, b ),  Dust2.ar(j, i, i ) ),  LFTri.ar(k, k,  LFPar.ar(a, g, f, h ),  Blip.ar(e, d, d, e ) ), e ))+( LFPulse.ar( LFPar.ar(c,  LFPar.ar( Dust2.ar(a, g, e ),  LFNoise2.ar(d, g, e ), g,  LFPulse.ar(b, k, e, b, b ) ), c, e ),  PMOsc.ar( Saw.ar(h,  Logist0.ar(h, k, j, k, h ), f ), j,  SinOsc.ar(k, f, b, k ), e,  Blip.ar(f, g, a, c ), d ),  LFTri.ar( LFNoise1.ar(f, c, b ), k,  Formant.ar(j, j, f, i, i ), d ), g,  Blip.ar( LFPulse.ar(b, k, e, j, f ), i,  LFPar.ar(c, a, f, a ), i ) ))+( Blip.ar(i, c,  SinOsc.ar(i,  LFTri.ar( SinOsc.ar(k, e, j, a ), b, a,  LFSaw.ar(g, k, d, h ) ), k, b ),  LFNoise0.ar( LFPulse.ar( SinOsc.ar(c, d, f, d ),  LFTri.ar(i, k, e, e ), g, i,  LFNoise0.ar(h, a, k ) ),  SyncSaw.ar( LFSaw.ar(e, k, b, c ), f, d,  LFTri.ar(b, h, c, j ) ),  Dust2.ar( Logist0.ar(g, h, b, j, e ), j,  LFNoise0.ar(b, a, g ) ) ) ) ))),0,amp)) })
