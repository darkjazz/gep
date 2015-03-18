// evolve a population from 2 initial chromosomes
(
// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;
~populationSize = 2;

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Dust2, Crackle, Blip, Saw, PMOsc, Logist0, CML0, QuadL, CuspL, GbmanL, HenonL, StandardL, LFClipNoise, LFDNoise0, LFDNoise1];

~abbrev = ~ugens.collect({|ugen| ugen.name.asString.keep(4) });

~methods = ~ugens.collect({|ugen| 
	var ar;
	ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first;
	if (ar.isNil) {
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar
});

~terminals = (~methods.collect(_.argNames).collect(_.size).maxItem + ~headsize).collect({|i|
	(97 + i).asAscii.asSymbol
});


~gep = UGEP(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

//~init = UGepLoader().loadNames(#[ 
//	gep_gen001_016_141002_132750, 
//	gep_gen002_048_141002_140646
//]);

~init = UGepLoader().loadNames(#[ 
	gep_gen003_014_141002_143021, 
	gep_gen003_030_141002_143032 
]);

//~init = UGepLoader().loadNames(#[ 
//	gep_gen004_061_141002_144537,
//	gep_gen004_046_141002_144520
//]);

~init.do({|data, i|
	~gep.chromosomes[i] = GEPChromosome.fromData(~init[i].data)
});

~gep.mutationRate = 0.1;
~gep.recombinationRate = 1.0;
~gep.transpositionRate = 0.25;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~paramheadsize = 5;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
});

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals, 
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);


~init.do({|data, i|
	~paramgep.chromosomes[i] = GEPChromosome(data.args.code, ~paramterminals, ~paramnumgenes, ~paramgep.linker);
	~paramgep.chromosomes[i].constants = data.args.constants;
	~paramgep.chromosomes[i].extraDomains = data.args.extraDomains;
});

~maps = #[unipolar, bipolar, freq, lofreq, midfreq, widefreq].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.mutationRate = 0.1;
~paramgep.recombinationRate = 1.0;
~paramgep.transpositionRate = 0.25;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;

)

(
5.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

~defs = ~gep.chromosomes.collect({|chrom, i|
	var defname, defstr, tree;
	defname = ("gep_gen" ++ chrom.generation.asString.padLeft(3, "0") 
		++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
	tree = chrom.asUgenExpressionTree;
	defstr = tree.asSynthDefString(defname, Pan2, Normalizer);
	{
		defstr.interpret.add
	}.try({
		chrom.score = -1;
		nil	
	})
});

~params = ~paramgep.chromosomes.collect({|chrom, i|
	var rawargs;
	rawargs = chrom.asExpressionTree(false).asFunctionString.interpret.value(*chrom.constants);
	rawargs.collect({|num, i| chrom.extraDomains[i].map(num.wrap(0.0, 1.0)).roundFreq })
});

)

~gep.chromosomes.size

~gep.chromosomes.collect(_.generation)


(
// create target statistics

Routine({

	~targetBuffer = Buffer.read(s, "/Users/alo/sounds/gep/urtinduu.aif");
	
	s.sync;

	~targetAnalyzer = UGepTimeAnalyzer(
		SynthDef(\targetBuf, {|out, buf|
			Out.ar(out, Mix(PlayBuf.ar(~targetBuffer.numChannels, buf, BufRateScale.kr(buf), doneAction: 2)))
		}).add, 
		~ncoef
	);

	s.sync;
	
	~targetAnalyzer.currentDef = \targetBuf;
		
	s.sync;
	
	OSCFunc({|msg|
		~targetAnalyzer.freeSynth;
 		~targetAnalyzer.clear;
 		"resources freed...".postln;
	}, '/n_end', s.addr).oneShot;

	
	~targetAnalyzer.run(rate: ~rate);
		
	Synth.before(~targetAnalyzer.synth, \targetBuf, [\out, ~targetAnalyzer.bus, \buf, ~targetBuffer]);

}).play;

)

Ndef('playbuffer', { PlayBuf.ar(1, ~targetBuffer, loop: 0.0).dup * 0.4 }).play

Ndef('playbuffer').clear


(
// fitness function based on target

~gep.addFitnessFunc({
	
	if (~defs.notNil) {
		~defs.do({|def| if (def.notNil) { SynthDef.removeAt(def.name) } })
	};
	
	~depths = Array.newClear(~gep.chromosomes.size);
		
	~defs = ~gep.chromosomes.collect({|chrom, i|
		var defname, defstr, tree;
		defname = ("gep_gen" ++ chrom.generation.asString.padLeft(3, "0") 
			++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
		tree = chrom.asUgenExpressionTree;
		~depths[i] = tree.maxDepth;
		defstr = tree.asSynthDefString(defname, Pan2, Normalizer);
		{
			defstr.interpret.add
		}.try({
			chrom.score = -1;
			nil	
		})
	});
	
	~minDepth = ~depths.minItem;
	~maxDepth = ~depths.maxItem;
	~depthSpec = [~minDepth, ~maxDepth].asSpec;
	~normalizedDepthScores = ~depths.collect({|depth|  
		~depthSpec.unmap(depth)
	});

	~params = ~paramgep.chromosomes.collect({|chrom, i|
		var rawargs;
		rawargs = chrom.asExpressionTree(false).asFunctionString.interpret.value(*chrom.constants);
		rawargs.collect({|num, i| chrom.extraDomains[i].map(num.wrap(0.0, 1.0)).roundFreq })
	});
			
	Routine({
		var cpu;
		var fragdur=~targetBuffer.duration;
		
		~gepAnalyzer = UGepTimeAnalyzer(~defs.select(_.notNil), ~ncoef, 
			~targetAnalyzer.currentStats);
		
		s.sync;
		
		~defs.do({|def, i|	
			var synth, score=0, normalized, analyzer, mean=0, stddev=0, scaled;
			
			if (def.notNil) {
			
				~gepAnalyzer.currentDef = def.name.asSymbol;
				Post << "-------------  START " << def.name << " --------------" << Char.nl;
				~gepAnalyzer.run(rate: ~rate);
				synth = Synth.before(~gepAnalyzer.synth, def.name, 
					[\out, ~gepAnalyzer.bus, \amp, 1] 
					++ [~terminals, ~params[i]].lace(~terminals.size * 2));
				fragdur.wait;
				synth.free;
				synth = nil;
				~gepAnalyzer.freeSynth;	
				normalized = ~gepAnalyzer.calculateDistances;
				normalized.mfcc = normalized.mfcc.select({|array| array.includes(0/0).not });
				normalized.flat = normalized.flat.select({|item| item > 0 });
				normalized.cent = normalized.cent.select({|item| item > 0 });
				normalized.amp = normalized.amp.select({|item| item > 0 });
				scaled = [
				1.0 - (normalized.mfcc.flop.collect(_.mean).mean) * 0.4,
				1.0 - normalized.flat.mean * 0.2,
				1.0 - normalized.cent.mean * 0.2,
				1.0 - normalized.amp.mean * 0.2
				];
				score = scaled.sum;
				if ((~gepAnalyzer.currentErrors.mean > 0).or
					(score < 0).or(score.isNaN)) { score = 0 };
				~gep.at(i).score = score.round(0.01) * 10;
				~paramgep.at(i).score = score.round(0.01) * 10;
				(scaled * 10).postln;
			}
			{
				~gep.at(i).score = 0
			};
			~gep.at(i).score.postln;
			0.5.wait
		});
		cpu = ~gepAnalyzer.calculateCPUsage;
		~defs.do({|def, i|
			var pscore;
			if (def.notNil) {
				Post << def.name << " - peak CPU: " 
					<< ~gepAnalyzer.cpu[def.name.asSymbol].collect(_.peak).mean
					<< "; CPU score: " << cpu[def.name.asSymbol] << Char.nl;
				pscore = ~gep[i].score;
				// multiply cpu score by 10 as well, makes cpu * 2.0 to account for 10%, 
				// multiply depth score by 0.5 to get 5%
				if (~gep[i].score > 0) {
					~gep[i].score = [
						~gep[i].score * 0.85, 
						~normalizedDepthScores[i] * 0.5, 
						cpu[def.name.asSymbol]
					].sum;
				};
				Post << def.name 
				<< " new score: " << ~gep[i].score << "; original: " << pscore 
				<< "; depth: " << (~normalizedDepthScores[i] * 0.5).round(0.001)
				<< "; cpu: " << cpu[def.name.asSymbol].round(0.001)
				<< "; total change: " << (~gep[i].score - pscore).round(0.001) << Char.nl;
			}
		});
		~gepAnalyzer.clear;
		Post << " ------- analysis finished ------- " << Char.nl;
		[~gep.meanScore, ~gep.maxScore].postln;
		~gep.chromosomes.collect(_.score).postln;
	}).play
})

)

~gep.updateScores


// PLAY ALL
(
~rout = Routine({
	var fragdur = ~targetBuffer.duration;
	~defs.do({|def, i|
		if (~gep.at(i).score > 0) {
			var synth, args;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree
				.asSynthDefString(def.name.asSymbol, Pan2, Normalizer).postln;
			args =  [~terminals, ~params[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~gep.at(i).score << Char.nl;
			synth = Synth(def.name, [\amp, 0.0, \dur, fragdur+0.5] ++ args);
			0.5.wait;
			synth.set('amp', 0.7);
			8.wait;
			synth.free;
			synth = nil;				
			s.sync;
			0.5.wait;
		}
	})
}).play
)


~decoder = FoaDecoder(decoderType: 'stereo')



~data = ~params.collect({|values, i|
	(defname: ~defs[i].name, args: (args: [~terminals, values].lace(~terminals.size * 2)), 
		data: (code: ~gep.chromosomes[i].code, terminals: ~terminals, linker: ~gep.linker, 
			header: (numgenes: ~numgenes)
		)
	)
})

~decoder.start

~player = GepPlayer(~data, ~decoder)

~player.start

~player.setFoa('zoom', 1.0)

~player.setFoa('focus', 1.0)

~ind = 57

~player.play(~ind, 0.0)


~player.set(~ind, 0.2)

~player.free(~ind)



s.queryAllNodes

s.sendMsg("/n_free", 1138)

MasterEQ(2)

~rout.stop

~gep.chromosomes.keep(8).collect(_.score)

~index = 5;

~args = [~terminals, ~params[~index]].lace(~terminals.size * 2)

~synth = Synth(~defs[~index].name, [\amp, 0.0] ++ ~args)

~synth.set('amp', 0.3)

~synth.free

~colors = nil


~gep.draw

~gep.drawCompare(1, 2)

~gep.drawSimilarityMatrix

(
Routine({
	~defs.do({|def, i|
		if (~gep.at(i).score > 0) {
			var synth, args, fragdur;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree
				.asSynthDefString(def.name.asSymbol, Pan2, Normalizer).postln;
			fragdur = ~gep.at(i).score;
			args =  [~terminals, ~params[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~gep.at(i).score << " | GEN: " << ~gep.at(i).generation << 				Char.nl;
			synth = Synth(def.name, [\amp, 0.0] ++ args);
			0.5.wait;
			synth.set('amp', 0.5);
			(fragdur-1).wait;
			SystemClock.sched(0.5, { synth.free; nil; })
		}
	})
}).play
)

MasterEQ(2)

~gep.

(
var win, size = 5;
var winsize = size*~similarityMatrix.size + 20;
~similarityMatrix = [];
~gep.chromosomes.do({|chromA|
	var array;
	array = ~gep.chromosomes.collect({|chromB|
		~calculateSimilarity.(chromA, chromB)
	});
	~similarityMatrix = ~similarityMatrix.add(array)
});

win = Window("GES", Rect(100, 100, winsize, winsize)).background_(Color.grey(0.1)).front;
win.drawFunc = {
	~similarityMatrix.do({|row, y|
		row.do({|val, x|
			Color.grey(val).set;
			Pen.fillRect(Rect(x*size+10, y*size+10, size, size))
		})
	})
};

)

~similarityMatrix.first.drop(2).clumps([2, 4, 8, 16, 32]).do({|array|
	array.mean.postln
})



~tree = ~gep.chromosomes[0].asUgenExpressionTree;

~tree.root.nodes.size

~tree.maxDepth.collect({|y| ~drawdict.select({|ev| ev.depth == y }).size }).maxItem



~gep.chromosomes[3].asUgenExpressionTree.draw(~ugens, ~gep.colors)

~gep.chromosomes.keep(4).do({|chrom|
	~drawExpressionTree.(chrom)
})

~drawExpressionTree.(~gep.chromosomes[1])

~drawdict.select({|ev| ev.depth == 0 }).do(_.postln)

~drawdict.do(_.postln)

~gep.chromosomes[0].asUgenExpressionTree.asSynthDefString('00_00', Pan2, Normalizer);



~bpm = 140;
~bps = ~bpm / 60;
~beatdur = ~bps.reciprocal;
~alldur = ~beatdur * 8;


~gep.chromosomes.selectIndices({|ch| ch.score == 0 })


~durs = [5,2,3,2]*(~alldur/12)

~amps = ~durs.collect({|dur, i|
		[0.0, 1.0, 0.0]
});

~player.setFoa('zoom', 0.2)


~amps.do({|amp, i|
	~player.stopRoutine(i+8)
});

~amps.do({|amp, i|
	~player.playRoutine(i+8, Pseq(amp, inf), Pseq(~durs[i], inf), 'zoom')
});


~amps.do({|amp, i|
	~player.stopRoutine(i)
})

MasterEQ(2)

s.queryAllNodes
