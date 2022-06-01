(
~ev = EvolverEnvir(
	(
		ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 1.0, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.1, geneTranspositionRate: 0.0
	)
);


[ 'gep_gen000_040_160829_103156', 'gep_gen000_047_160829_103202' ].do({|name|
	~ev.addChromosomeByDefname(name)
});
)


~ev.initializePopulation


(
// evolve 5 generations, each doubling in size
4.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

)

Delay


~buf = Buffer.read(s, "/Users/alo/snd/gep/atak.aiff")


{PlayBuf.ar(1, ~buf.bufnum, doneAction: 2)}.play

~ev.extractTargetFeatures("/Users/alo/snd/gep/atak.aiff")

SinO

~ev.defineFitnessFunction

~gep.updateScores

~gep.chromosomes[0].code

~gep.drawDistanceMatrix(14)

~gep.draw

~gep.drawScroll

~gep.drawCompare(0, 1)

~gep.drawUGenTree(7, ~ugens);
~gep.drawUGenTree(28, ~ugens);

~defs[2].name

~th = 7.0



~ev.play

~ev.playOne(16)

Ndef('rerout', {
	Out.ar(2, In.ar(0, 2))
}).play

~indices = [6]

~ev.save(~indices, false, 8)


s.scope(2)


~gep.chromosomes[0].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes[0].asUgenExpressionTree.asSynthDefString('whatever_00', Pan2, Limiter, false)

(

SynthDef('whatever_00', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m|
	Out.ar(out,
		Pan2.ar(
			Limiter.ar(
				LeakDC.ar(
					(
						LFGauss.ar(
							Formant.ar(
								LFPar.ar(a, c, e, f ),
								LFPulse.ar(e, b, c, d, i ),
								c,  Dust2.ar(l, m, l ),
								c
							),
							f,
							Logist1.ar(d, g, h, g, c ),
							c,
							LFPar.ar(g, j, f, j )
						)
					) *
					(
						LFNoise0.ar(
							SinOscFB.ar(f,
								Formant.ar(m, k, c, h, g ),
								l,
								g
								),
							h,
							m
						)
					) *
					(
						Formant.ar(
							PMOsc.ar(
								SinOsc.ar(i, l, k, k ),
								f,
								LFGauss.ar(g, i, b, d, m ),
								c,
								l,
								k
							),
							l,
							m,
							c,
							LFTri.ar(d, l, m, a )
						)
					) *
					(
						LFNoise0.ar(
							m,
							e,
							Saw.ar(
								l,
								a,
								FBSineL.ar(
									LFNoise2.ar(i, e, k ),
									j,
									h,
									a,
									a,
									g,
									m,
									h,
									b

								)
							)
						)
					)
				)
			),
			0,
			amp)
	)
})

)