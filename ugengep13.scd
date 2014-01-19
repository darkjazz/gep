// GEP with a target sound analysis, dillinja as target

(

// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 4;
~populationSize = 128;

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, SawDPW, Dust2, Crackle, Blip, Saw, PMOsc, Resonz, BPF, HPF, LPF, Logist0, Gendy1, CML0];

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

~gep = UGEP.newValid(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;


~paramheadsize = 5;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
}) ++ ControlSpec.methods.select({|mth| mth.name == 'map' });

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals, 
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);

~maps = #[freq, lofreq, midfreq, widefreq, phase].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.chromosomes.do({|chrom| 
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	chrom.addExtraDomain(Array.with(~maps.choose))
});

~paramgep.mutationRate = 0.25;
~paramgep.recombinationRate = 1.0;
~paramgep.transpositionRate = 0.25;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;


)

(
// create target statistics

~targetAnalyzer = UGepAnalyzer(
	SynthDef(\targetBuf, {|out, buf|
		Out.ar(out, PlayBuf.ar(1, buf, BufRateScale.kr(buf), doneAction: 2))
	}).add, 
	~ncoef
);

Routine({

	s.sync;
	
	~targetAnalyzer.currentDef = \targetBuf;
	
	~targetBuffer = Buffer.read(s, "/Users/alo/sounds/gep/badklaat.aiff");
	
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


~targetAnalyzer.stats[\targetBuf].mfcc.collect(_.mean)
~targetAnalyzer.stats[\targetBuf].mfcc.collect(_.stdDev)

~targetAnalyzer.stats[\targetBuf].flat.mean;
~targetAnalyzer.stats[\targetBuf].flat.stdDev;

~targetAnalyzer.stats[\targetBuf].cent.mean;
~targetAnalyzer.stats[\targetBuf].cent.stdDev;

~targetAnalyzer.stats[\targetBuf].amp.mean;
~targetAnalyzer.stats[\targetBuf].amp.stdDev;

~targetAnalyzer.stats[\targetBuf].err.mean



(
// fitness function based on target

~gep.addFitnessFunc({
	
	if (~defs.notNil) {
		~defs.do({|def| if (def.notNil) { SynthDef.removeAt(def.name) } })
	};
	
	~defs = ~gep.chromosomes.collect({|chrom, i|
		var defname, defstr;
		defname = ("gep_gen" ++ ~gep.generationCount.asString.padLeft(3, "0") 
			++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
		defstr = chrom.asUgenExpressionTree.asSynthDefString(defname, Pan2, Normalizer);
		{
			defstr.interpret.add
		}.try({
			chrom.score = -1;
			nil	
		})
	});

	~params = ~paramgep.chromosomes.collect({|chrom, i|
		var spec;
		spec = chrom.extraDomains.first.first.asString.drop(2);
		chrom.asExpressionTree(false).asFunctionString
			.replace("map", spec ++ ".map").interpret.value(*chrom.constants)
	});
			
	Routine({
		var fragdur=3;
		
		~gepAnalyzer = UGepAnalyzer(~defs.select(_.notNil), ~ncoef);
		
		s.sync;
		
		~defs.do({|def, i|	
			var synth, score=0, ev, analyzer, mean=0, stddev=0;
			
			if (def.notNil) {
			
				~gepAnalyzer.currentDef = def.name.asSymbol;
				Post << "-------------  START " << def.name << " --------------" << Char.nl;
				~gepAnalyzer.run(rate: ~rate);
				synth = Synth.before(~gepAnalyzer.synth, def.name, [\out, ~gepAnalyzer.bus] 
					++ [~terminals, ~params[i]].lace(~terminals.size * 2));
				fragdur.wait;
				synth.free;
				synth = nil;
				~gepAnalyzer.freeSynth;	
				ev = ~gepAnalyzer.currentStats;
				ev[\mfcc].do({|stat, i|
					if ((stat.mean.isNaN).or(stat.mean.isNaN)) {
						score = 0;
					} 
					{
						score = score + ((1.0 - abs(stat.mean 
							- ~targetAnalyzer.stats[\targetBuf].mfcc[i].mean).clip(0.0, 1.0)) 
							* ~ncoef.reciprocal * 2);
						
						score = score + ((1.0 - abs(stat.stdDev 
							- ~targetAnalyzer.stats[\targetBuf].mfcc[i].stdDev).clip(0.0, 1.0))
							* ~ncoef.reciprocal * 2);
					};
				});
				if ((ev[\flat].mean.isNaN).or(ev[\flat].stdDev.isNaN)) {
					score = 0
				}
				{
					score = score + (1.0 - abs(ev[\flat].mean 
						- ~targetAnalyzer.stats[\targetBuf].flat.mean));
					score = score + (1.0 - abs(ev[\flat].stdDev 
						- ~targetAnalyzer.stats[\targetBuf].flat.stdDev));
				};
//				["centroid", ev[\cent].mean, ev[\cent].stdDev].postln;
				if ((ev[\cent].mean.isNaN).or(ev[\cent].stdDev.isNaN)) {
					score = 0
				}
				{
					score = score + (1.0 - ControlSpec.specs['freq'].unmap(abs(ev[\cent].mean 
						- ~targetAnalyzer.stats[\targetBuf].cent.mean)));
					score = score + (1.0 - ControlSpec.specs['midfreq'].unmap(abs(ev[\cent].stdDev 
						- ~targetAnalyzer.stats[\targetBuf].cent.stdDev)));
				};
//				["amp", ev[\amp].mean, ev[\amp].stdDev].postln;
				if ((ev[\amp].mean.isNaN).or(ev[\amp].stdDev.isNaN)) {
					score = 0;
				}{
					if (ev[\amp].mean > 1.0) {
						score = score * ev[\amp].mean.reciprocal; 
					}
					{
						score = score + (1.0 - abs(ev[\amp].mean 
							- ~targetAnalyzer.stats[\targetBuf][\amp].mean));
						score = score + (1.0 - abs(ev[\amp].stdDev 
							- ~targetAnalyzer.stats[\targetBuf][\amp].stdDev));
					}				
				};
//				["error", ev[\err].mean, ev[\err].stdDev].postln;
				if (ev[\err].mean > 0) { score = 0 };
				~gep.at(i).score = score.round(0.01);
				~paramgep.at(i).score = score.round(0.01);
				[ev[\amp].mean, ev[\amp].stdDev, ev[\flat].mean, ev[\flat].stdDev, 
					ev[\cent].mean, ev[\cent].stdDev
				].postln;
			}
			{
				~gep.at(i).score = 0
			};
			score.postln;
			0.5.wait
		});
		~gepAnalyzer.clear;
		Post << " ------- analysis finished ------- " << Char.nl;
		[~gep.meanScore, ~gep.maxScore].postln;
		~gep.chromosomes.collect(_.score).postln;
	}).play
})

)


// run first time
~gep.updateScores


(
// for each next generation
~paramgep.nextGeneration;
~gep.nextGeneration;
)

[~gep.meanScore, ~gep.maxScore]
[~gep.meanScore, ~gep.maxScore, ~gep.chromosomes.collect(_.score).stdDev].postln

~th = 7.5;
~gep.chromosomes.collect(_.score).select({|sc| sc > ~th })

~gep.chromosomes.collect(_.score).select({|sc| sc > ~th }).size

(
Routine({
	var fragdur = 3;
	~defs.do({|def, i|
		if (~gep.at(i).score > ~th) {
			var synth, args;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree.asSynthDefString(def.name.asSymbol, Pan2, Normalizer).postln;
			args =  [~terminals, ~params[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~gep.at(i).score << Char.nl;
			synth = Synth(def.name, args);
			s.sync;
			fragdur.wait;
			synth.free;
			synth = nil;
			s.sync
		}
	})
}).play
)


(

var save = true;

Routine({
	var fragdur = 5, indices;
	indices = [4, 6, 18, 19, 22, 32, 37, 47, 73, 95, 113, 118, 121];
	indices.do({|ind, i|
		var synth, args, def, savename, et, co, cospec;
		def = ~defs[ind];
		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		et = ~gep.at(ind).asUgenExpressionTree;
		et.asSynthDefString(def.name.asSymbol, Pan2, Normalizer).postln;
		args =  [~terminals, ~params[ind]].lace(~terminals.size * 2).postln;
		Post << "SCORE: " << ~gep.at(ind).score << Char.nl;
		synth = Synth(def.name, args);
		s.sync;
		fragdur.wait;
		synth.free;
		synth = nil;
		s.sync;
		if (save) {
			co = ~paramgep.chromosomes[ind];
			savename = ~gep.makeDefName(ind);
			cospec = ('code': co.code, 'args': args, 'constants': co.constants, 'extraDomains': co.extraDomains, 'defname': savename);
			et.saveAsSynthDef(savename, Pan2, Normalizer, cospec, ~gepAnalyzer.asEvents(def.name.asSymbol));
			~gep.saveData(ind, savename);
		}
	})
}).play

)


/*
gep_gen008_024_130501_211817
gep_gen008_057_130501_211838
*/
