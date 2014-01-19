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

~headsize = 7;
~numgenes = 3;
~populationSize = 40;

~ugens = [LFTri, LFCub, LFPar, LFSaw, PSinGrain, SinOsc, Pulse, MostChange, LeastChange, LFClipNoise, LFDNoise3, LFDNoise1, LFNoise1, LFDNoise0, LFNoise2, LFDClipNoise, LFNoise0, FSinOsc, SyncSaw, SinOscFB, GaussTrig, SawDPW, Dust, Dust2, PinkNoise, BrownNoise, GrayNoise, ClipNoise, WhiteNoise, Crackle, Blip, Perlin3, StkPluck, Saw, SinTone, Impulse];

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
// fitness function

~gep.addFitnessFunc({
	~deflib = ();
	~defs = ~gep.chromosomes.collect({|chrom, i|
		var defname, defstr;
		defname = ("gep_gen" ++ ~gep.generationCount.asString.padLeft(3, "0") 
			++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
		defstr = chrom.asUgenExpressionTree.asSynthDefString(defname);
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
			var synth, score=0, ev, analyzer;
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
					score = score + stat.stdDev;
//					score = score + (0.25 - stat.mean).abs
				};
				[i, stat.mean, (0.25 - stat.mean).abs, stat.stdDev].postln;
			});
			["flatness", ev[\flat].mean, ev[\flat].stdDev].postln;
			if ((ev[\flat].mean.isNaN).or(ev[\flat].stdDev.isNaN)) {
				score = 0
			}
			{
				score = score + (0.5 - (0.5 - ev[\flat].mean));
				score = score + ev[\flat].stdDev;
			};
			["centroid", ev[\cent].mean, ev[\cent].stdDev].postln;
			if ((ev[\cent].mean.isNaN).or(ev[\cent].stdDev.isNaN)) {
				score = 0
			};
			["amp", ev[\amp].mean, ev[\amp].stdDev].postln;
			if ((ev[\amp].mean.isNaN).or(ev[\amp].stdDev.isNaN)) {
				score = 0
			}{
				if (ev[\amp].mean > 1.0) {
					score = 0 
				}
				{
					score = score + ev[\amp].stdDev;
				}				
			};
			["error", ev[\err].mean, ev[\err].stdDev].postln;
			if (ev[\err].mean > 0) { score = 0 };
			~gep.at(i).score = (score * 10).round(1);
			~paramgep.at(i).score = (score * 10).round(1);
		});
		~oscfncs.do(_.disable);
		~oscfncs = nil;
		bus.free;
		Post << " ------- analysis finished ------- " << Char.nl;
	}).play
})

)

~gep.updateScores

(
~paramgep.nextGeneration;
~gep.nextGeneration;
)

[~gep.meanScore, ~gep.maxScore].postln

~gep.chromosomes.collect(_.score)

~deflib[~defs[13].name.asSymbol].amp.mean
~deflib[~defs[13].name.asSymbol].amp.stdDev

[~terminals, ~params[2]].lace(~terminals.size * 2)

(
Routine({
	var fragdur = 5;
	~defs.do({|def, i|
		if (~gep.at(i).score > 0) {
			var synth, args;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree.asSynthDefString(def.name.asSymbol).postln;
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
var index = 3, args;
~gep.at(index).asExpressionTree.asSynthDefString(~defs[index].name).postln;
args = [\out, 0] ++ [~terminals, ~params[index]].lace(~terminals.size * 2).postln;
x = Synth(~defs[index].name, args)
)

x.free

