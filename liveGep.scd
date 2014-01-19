(
~ncoef = 20;
~rate = 20;
~headsize = 7;
~numgenes = 4;
~populationSize = 32;

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newRandomFromLibrary(~populationSize, ~numgenes, ~headsize, ~linker, ~excludeUGenList);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~paramheadsize = 3;
~paramnumgenes = ~gep.terminals.size;
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

~paramgep.mutationRate = 0.3;
~paramgep.recombinationRate = 0.5;
~paramgep.transpositionRate = 0.1;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;

)

(
// create target statistics

~gepAnalyzer = UGepAnalyzer(
	SynthDef(\targetBuf, {|out, buf|
		Out.ar(out, PlayBuf.ar(1, buf, BufRateScale.kr(buf), doneAction: 2))
	}).add, 
	~ncoef
);

~resetInterval = 10;

~statrout = Routine({
	
	~postStats = {
		Post << "MFCC" << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].mfcc.collect(_.mean) << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].mfcc.collect(_.stdDev) << Char.nl;
		Post << "Flatness" << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].flat.mean << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].flat.stdDev << Char.nl;
		Post << "Centroid" << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].cent.mean << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].cent.stdDev << Char.nl;
		Post << "Amplitude" << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].amp.mean << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].amp.stdDev << Char.nl;
		Post << "Error" << Char.nl;
		Post << ~gepAnalyzer.stats[\targetBuf].err.mean << Char.nl;
		Post << "Count: " << ~gepAnalyzer.stats[\targetBuf].amp.count << Char.nl
	};	
	
	s.sync;
	
	~gepAnalyzer.currentDef = \targetBuf;
	
	~targetBuffer = Buffer.read(s, "/Users/alo/sounds/input/shellylivecode.aiff");
	
	s.sync;
	
	~gepAnalyzer.run(rate: ~rate);
		
	~targetBufSynth = Synth.before(~gepAnalyzer.synth, \targetBuf, [\out, ~gepAnalyzer.bus, \buf, ~targetBuffer]);
	
	loop({
		~gepAnalyzer.resetStats;
		~resetInterval.wait;
		~postStats.();
	})

}).play;

)


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
					score = 0
				}{
					if (ev[\amp].mean > 1.0) {
						score = 0 
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


~usedefs = Array();
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

~statrout.stop

s.queryAllNodes

~targetAnalyzer.freeSynth
~targetAnalyzer.clear

~targetBufSynth.free;

s.reboot