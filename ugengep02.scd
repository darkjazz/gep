// GEP with a target sound analysis

(

// ANALYZER

SynthDef(\analyze, {|in, rate|
	var input, fft, mfcc, flat, cent, amp, error, trig;
	trig = Impulse.kr(rate);
	input = In.ar(in);
	fft = FFT(LocalBuf(1024), input);
	mfcc = MFCC.kr(fft);
	flat = SpecFlatness.kr(fft);
	cent = SpecCentroid.kr(fft);
	amp = Amplitude.kr(input);
	error = CheckBadValues.kr(input + amp);
	SendReply.kr(trig, '/mfcc', mfcc);
	SendReply.kr(trig, '/flat', flat);
	SendReply.kr(trig, '/cent', cent);
	SendReply.kr(trig, '/amp', amp);
	SendReply.kr(trig, '/err', error);	
}).add;

// UGENS

~headsize = 9;
~numgenes = 3;
~populationSize = 40;

~ugens = [LFTri, LFCub, LFPar, LFSaw, SinOsc, Pulse, MostChange, LeastChange, LFClipNoise, LFDNoise3, LFDNoise1, LFNoise1, LFDNoise0, LFNoise2, LFDClipNoise, LFNoise0, FSinOsc, SyncSaw, SinOscFB, GaussTrig, SawDPW, Dust, Dust2, PinkNoise, BrownNoise, GrayNoise, ClipNoise, WhiteNoise, Crackle, Blip, Perlin3, StkPluck, Saw, SinTone, Impulse];

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
~gep.recombinationRate = 0.3;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;


~paramheadsize = 3;
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

~paramgep.mutationRate = 0.1;
~paramgep.recombinationRate = 0.3;
~paramgep.transpositionRate = 0.1;
~paramgep.rootTranspositionRate = 0.1;
~paramgep.geneRecombinationRate = 0.1;
~paramgep.geneTranspositionRate = 0.1;


)

(
// create target statistics

~targetBuffer = Buffer.read(s, "/Users/alo/sounds/fxchck.aif");

SynthDef(\targetBuf, {|out, buf|
	Out.ar(out, PlayBuf.ar(1, buf, BufRateScale.kr(buf), doneAction: 2))
}).add;


~targetStats = (
	mfcc: Array.fill(13, { RunningStat() }),
	flat: RunningStat(),
	cent: RunningStat(),
	amp: RunningStat(),
	err: RunningStat()
);

~oscfncs = [
	OSCFunc({|msg|
		msg.postln;
		~targetStats[\mfcc].do({|stat, i|
			stat.push(msg[i+3])
		})
	}, '/mfcc', s.addr),
	
	OSCFunc({|msg|
		msg.postln;
		~targetStats[\flat].push(msg[3])
	}, '/flat', s.addr),

	OSCFunc({|msg|
		msg.postln;
		~targetStats[\cent].push(msg[3])
	}, '/cent', s.addr),
	
	OSCFunc({|msg|
		msg.postln;
		~targetStats[\amp].push(msg[3])
	}, '/amp', s.addr),
	
	OSCFunc({|msg|
		msg.postln;
		~targetStats[\err].push(msg[3])
	}, '/err', s.addr)	
];	

Routine({
	var analyzer, bus;
	s.sync;
	bus = Bus.audio;
	s.sync;
	analyzer = Synth(\analyze, [\in, bus, \rate, 10]);
	
	OSCFunc({|msg|
		msg.postln;
		analyzer.free;
		analyzer = nil;
		bus.free;
		bus = nil;
		~oscfncs.do(_.disable);
		~oscfncs = nil;
		"resources freed...".postln;
	}, '/n_end', s.addr).oneShot;
	
	s.sync;

	Synth(\targetBuf, [\out, bus, \buf, ~targetBuffer])
	
}).play

)


~targetStats.mfcc.collect(_.mean)
~targetStats.mfcc.collect(_.stdDev)

~targetStats.flat.mean;
~targetStats.flat.stdDev;

~targetStats.cent.mean;
~targetStats.cent.stdDev;

~targetStats.amp.mean;
~targetStats.amp.stdDev;

~targetStats.err.mean

(
// fitness function based on target

~gep.addFitnessFunc({
	~deflib = ();
	
	if (~defs.notNil) {
		~defs.do({|def| SynthDef.removeAt(def.name) })
	};
	
	~defs = ~gep.chromosomes.collect({|chrom, i|
		var defname, defstr;
		defname = ("gep_gen" ++ ~gep.generationCount.asString.padLeft(3, "0") 
			++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
		defstr = chrom.asUgenExpressionTree.asSynthDefString(defname, Pan2, Normalizer);
		defstr.interpret.add
	});
	~params = ~paramgep.chromosomes.collect({|chrom, i|
		var spec;
		spec = chrom.extraDomains.first.first.asString.drop(2);
		chrom.asExpressionTree(false).asFunctionString
			.replace("map", spec ++ ".map").interpret.value(*chrom.constants)
	});
	
	~deflib = ();
	
	~defs.do({|def|
		~deflib[def.name.asSymbol] = (
			mfcc: Array.fill(13, { RunningStat() }),
			flat: RunningStat(),
			cent: RunningStat(),
			amp: RunningStat(),
			err: RunningStat()
		)
	});

	~oscfncs = [
		OSCFunc({|msg|
			msg.postln;
			if (~currentKey.notNil) {
				~deflib[~currentKey][\mfcc].do({|stat, i|
					stat.push(msg[i+3])
				})
			}
		}, '/mfcc', s.addr),
		
		OSCFunc({|msg|
			msg.postln;
			if (~currentKey.notNil) {
				~deflib[~currentKey][\flat].push(msg[3])
			}
		}, '/flat', s.addr),
	
		OSCFunc({|msg|
			msg.postln;
			if (~currentKey.notNil) {
				~deflib[~currentKey][\cent].push(msg[3])
			}
		}, '/cent', s.addr),
		
		OSCFunc({|msg|
			msg.postln;
			if (~currentKey.notNil) {
				~deflib[~currentKey][\amp].push(msg[3])
			}
		}, '/amp', s.addr),
		
		OSCFunc({|msg|
			msg.postln;
			if (~currentKey.notNil) {
				~deflib[~currentKey][\err].push(msg[3])
			}
		}, '/err', s.addr)	
	];	
	
	Routine({
		var bus, fragdur=3;
		bus = Bus.audio;
		s.sync;
		~defs.do({|def, i|	
			var synth, score=0, ev, analyzer, mean=0, stddev=0;
			analyzer = Synth(\analyze, [\in, bus, \rate, 10]);
			s.sync;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			synth = Synth.before(analyzer, def.name, [\out, bus] 
				++ [~terminals, ~params[i]].lace(~terminals.size * 2));
			s.sync;
			~currentKey = def.name.asSymbol;
			fragdur.wait;
			synth.free;
			synth = nil;
			analyzer.free;
			analyzer = nil;
			ev = ~deflib[~currentKey];
			ev[\mfcc].do({|stat, i|
				if ((stat.mean.isNaN).or(stat.mean.isNaN)) {
					score = 0;
				} 
				{
					mean = mean + (1.0 - abs(stat.mean - ~targetStats.mfcc[i].mean).clip(0.0, 1.0));
					stddev = stddev + (1.0 - abs(stat.stdDev - ~targetStats.mfcc[i].stdDev).clip(0.0, 1.0));
				};
			});
			["mfcc", mean/13, stddev/13].postln;
			score = score + (mean/13);
			score = score + (stddev/13);
			["flatness", ev[\flat].mean, ev[\flat].stdDev].postln;
			if ((ev[\flat].mean.isNaN).or(ev[\flat].stdDev.isNaN)) {
				score = 0
			}
			{
				score = score + (1.0 - abs(ev[\flat].mean - ~targetStats.flat.mean));
				score = score + (1.0 - abs(ev[\flat].stdDev - ~targetStats.flat.stdDev));
			};
			["centroid", ev[\cent].mean, ev[\cent].stdDev].postln;
			if ((ev[\cent].mean.isNaN).or(ev[\cent].stdDev.isNaN)) {
				score = 0
			}
			{
				score = score + (1.0 - ControlSpec.specs['freq'].unmap(abs(ev[\cent].mean - ~targetStats.cent.mean)));
				score = score + (1.0 - ControlSpec.specs['midfreq'].unmap(abs(ev[\cent].stdDev - ~targetStats.cent.stdDev)));
			};
			["amp", ev[\amp].mean, ev[\amp].stdDev].postln;
			if ((ev[\amp].mean.isNaN).or(ev[\amp].stdDev.isNaN)) {
				score = 0
			}{
				if (ev[\amp].mean > 1.0) {
					score = 0 
				}
				{
					score = score + (1.0 - abs(ev[\amp].mean - ~targetStats[\amp].mean));
					score = score + (1.0 - abs(ev[\amp].stdDev - ~targetStats[\amp].stdDev));
				}				
			};
			["error", ev[\err].mean, ev[\err].stdDev].postln;
			if (ev[\err].mean > 0) { score = 0 };
			~gep.at(i).score = score.round(0.01);
			~paramgep.at(i).score = score.round(0.01);
		});
		~oscfncs.do(_.disable);
		~oscfncs = nil;
		bus.free;
		Post << " ------- analysis finished ------- " << Char.nl;
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

[~gep.meanScore, ~gep.maxScore].postln

~gep.chromosomes.collect(_.score)

[ 4.852, 6.61 ]
[ 4.99025, 6.47 ]



(
Routine({
	var fragdur = 5;
	~defs.do({|def, i|
		if (~gep.at(i).score > 0) {
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

Routine({
	var fragdur = 5, indices;
	indices = [3, 9, 13, 14, 16, 18, 20, 21, 24, 30, 31];
	indices.do({|ind, i|
		var synth, args, def;
		def = ~defs[ind];
		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		~gep.at(ind).asUgenExpressionTree.asSynthDefString(def.name.asSymbol, Pan2, Normalizer).postln;
		args =  [~terminals, ~params[ind]].lace(~terminals.size * 2).postln;
		Post << "SCORE: " << ~gep.at(ind).score << Char.nl;
		synth = Synth(def.name, args);
		s.sync;
		fragdur.wait;
		synth.free;
		synth = nil;
		s.sync
	})
}).play

)



// archive codes and synth descs

(
var run = 0, indices = [];
indices.do({|ind|
	~gep.saveCode(ind, run)
})
)

// close archive when done

~gep.closeCurrentArchive

