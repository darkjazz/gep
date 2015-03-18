(
// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 4;
~populationSize = 8;

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Dust2, Crackle, Blip, Saw, PMOsc];

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

~maps = #[unipolar, bipolar, freq, lofreq, midfreq, widefreq].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.chromosomes.do({|chrom| 
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	~terminals.size.do({ chrom.addExtraDomain(~maps.choose) })
});

~paramgep.mutationRate = 0.1;
~paramgep.recombinationRate = 1.0;
~paramgep.transpositionRate = 0.25;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;

)


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

Ndef('play', { PlayBuf.ar(1, ~targetBuffer).dup }).play

Ndef('play').clear

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

s.scope



(
~paramgep.nextGeneration;
~gep.nextGeneration;
)


~gep.draw

~gep.drawCompare(0, 1)


~gep.chromosomes[0].asUgenExpressionTree.draw(~ugens, ~gep.colors)

(
~index = 0;
~args = [~terminals, ~params[~index]].lace(~terminals.size * 2);
~synth = Synth(~defs[~index].name, [\amp, 0.0] ++ ~args)
)

~synth.set('amp', 0.3)

~synth.free




