// evolve a population from 2 initial chromosomes
(
// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;
~populationSize = 4;

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Dust2, Crackle, Blip, Saw, PMOsc, Logist0, CML0, QuadL, CuspL, GbmanL, HenonL, StandardL, LFClipNoise, LFDNoise0, LFDNoise1];

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

~init = UGepLoader().loadNames(#[ 
	gep_gen001_016_141002_132750, 
	gep_gen002_048_141002_140646, 
	gep_gen003_014_141002_143021, 
	gep_gen003_030_141002_143032 
]);

~init.do({|data, i|
	~gep.chromosomes[i] = GEPChromosome.fromData(~init[i].data)
});

~gep.mutationRate = 1.0;
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

~paramgep.chromosomes.do({|chrom| 
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	~terminals.size.do({ chrom.addExtraDomain(~maps.choose) })
});

~paramgep.mutationRate = 1.0;
~paramgep.recombinationRate = 1.0;
~paramgep.transpositionRate = 0.25;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;

)

(
4.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
})
)

~gep.chromosomes.size

(
// create target statistics

Routine({

	~targetBuffer = Buffer.read(s, "/Users/alo/sounds/gep/ctronics01.aif");
	
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





// PLAY BY LINEAGE 
~lineage0 = ~gep.chromosomes[[0, 1] ++ [4, 5] ++ (8..11) ++ (16..23) ++ (32..47)];
~params0 = ~params[[0, 1] ++ [4, 5] ++ (8..11) ++ (16..23) ++ (32..47)];
~defs0 = ~defs[[0, 1] ++ [4, 5] ++ (8..11) ++ (16..23) ++ (32..47)];

~lineage1 = ~gep.chromosomes[[2, 3] ++ [6, 7] ++ (12..15) ++ (24..31) ++ (48..63)];
~params1 = ~params[[2, 3] ++ [6, 7] ++ (12..15) ++ (24..31) ++ (48..63)];
~defs1 = ~defs[[2, 3] ++ [6, 7] ++ (12..15) ++ (24..31) ++ (48..63)];


~defs0.first.name

(
~routn0 = Routine({
	~defs0.do({|def, i|
		if (~lineage0[i].score > 0) {
			var synth, args, fragdur;
			Post << "---  START " << def.name << " ---" << Char.nl;
			~lineage0[i].code.select({|codon| codon.isKindOf(Class) }).collect(_.name).postln;
			fragdur = ~lineage0[i].score;
			args =  [~terminals, ~params0[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~lineage0[i].score << " | GEN: " << ~lineage0[i].generation << Char.nl;
			synth = Synth(def.name, [\amp, 0.0] ++ args);
			0.5.wait;
			synth.set('amp', 0.2);
			fragdur.wait;
			synth.free;
			synth = nil;
		}
	})
}).play;

~routn1 = Routine({
	~defs1.do({|def, i|
		if (~lineage1[i].score > 0) {
			var synth, args, fragdur;
			Post << "---  START " << def.name << " ---" << Char.nl;
			~lineage1[i].code.select({|codon| codon.isKindOf(Class) }).collect(_.name).postln;
			fragdur = ~lineage1[i].score;
			args =  [~terminals, ~params1[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~lineage1[i].score << " | GEN: " << ~lineage1[i].generation << Char.nl;
			synth = Synth(def.name, [\amp, 0.0] ++ args);
			0.5.wait;
			synth.set('amp', 0.2);
			fragdur.wait;
			synth.free;
			synth = nil;				
			s.sync;
			0.5.wait;
		}
	})
}).play
)


~class = ~lineage0.first.code.size

~ugens.indexOf

(
~colors0 = ~ugens.collect({ Color.rand });

~win = Window("GES", Rect(100, 100, 400, 400)).background_(Color.black).front;
~win.drawFunc = {
	var currentGen = 0;
	var posy = 10;
	~lineage0.do({|chrom, y|
		var colors, ugens = chrom.code.select({|codon| codon.isKindOf(Class) });
		colors = ugens.collect({|ugen| ~colors0[~ugens.indexOf(ugen)] });
		if (currentGen == chrom.generation) 
		{ posy = posy + 8; } 
		{ posy = posy + 16; currentGen = chrom.generation};
		colors.do({|color, x|
			color.set;
			Pen.fillRect(Rect(x*10+10, posy, 10, 5));
		})
	})	
};

~colors1 = ~ugens.collect({ Color.rand });

~win = Window("GES", Rect(100, 100, 400, 400)).background_(Color.black).front;

~win.drawFunc = {
	var currentGen = 0;
	var posy = 10;
	~lineage1.do({|chrom, y|
		var colors, ugens = chrom.code.select({|codon| codon.isKindOf(Class) });
		colors = ugens.collect({|ugen| ~colors1[~ugens.indexOf(ugen)] });
		if (currentGen == chrom.generation) 
		{ posy = posy + 8; } 
		{ posy = posy + 16; currentGen = chrom.generation};
		colors.do({|color, x|
			color.set;
			Pen.fillRect(Rect(x*10+10, posy, 10, 5));
		})
	})	
}

)






// PLAY ALL
(
Routine({
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


(
~decoder = FoaDecoder(decoderType:'stereo');
~foa = #[zoom,push];
~player = GepPlayer(~data, ~decoder);
)

~player.start(~foa)

~player.setFoa('zoom', 1.0);
~player.setFoa('push', 1.0)
















~gep.chromosomes[0].code.do({|codonA, i|
	var codonB = ~gep.chromosomes[2].code[i];
	[codonA, codonB, codonA == codonB].postln
})

~gep.chromosomes[1].code.do({|codonA, i|
	var codonB = ~gep.chromosomes[3].code[i];
	[codonA, codonB, codonA == codonB].postln
})



~gep.chromosomes.collect(_.generation)

~gep.chromosomes.collect(_.code).collect({|code| code.select({|codon| codon.isKindOf(Class) }) }).do({|code|
	Post << code.size << Char.nl;
	Post << [code[0], code[1], code[code.lastIndex-1], code[code.lastIndex]] << Char.nl;
	"----".postln
})

