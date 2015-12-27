// SAVE SYNTHS IN COUCHDB AS JSON-LD

(
// UGENS

~ncoef = 20;
~rate = 20;
~headsize = 24;
~numgenes = 1;
~populationSize = 8;

~ugens = [LFCub, LFPar, LFSaw, SinOsc, LFTri, LFGauss, SinOscFB, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, Blip, Saw, PMOsc, FBSineN, FBSineL, GbmanL, CuspN, LatoocarfianN];

~methods = ~ugens.collect({|ugen|
	var ar;
	ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first;
	if (ar.isNil) {
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar
});

/*
~terminals = (~methods.collect(_.argNames).collect(_.size).maxItem + ~headsize).collect({|i|
	var str = "";
	((i / 26).asInt + 1).do({|j|
		str = str ++ (i % 26 + 97).asAscii;
	});
	str.asSymbol;
});
*/

~terminals = 26.collect({|i|
	(i + 97).asAscii.asSymbol
});

~gep = UGEP.newValid(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals,
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first, methodRatio: 0.9
);

~gep.mutationRate = 0.2;
~gep.recombinationRate = 1.0;
~gep.transpositionRate = 0.2;
~gep.rootTranspositionRate = 0.2;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.0;

~gep.dbname = "ges_ld_00";

~paramheadsize = 5;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
});

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals,
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);

~maps = #[unipolar, bipolar, lofreq, midfreq].collect({|name|
	ControlSpec.specs[name]
}) ++ [
	ControlSpec(16.0, 256.0, 'exp', 0, 55.0),
	ControlSpec(8.0, 1024.0, 'exp', 0, 110.0),
	ControlSpec(4096.0, 16384.0, 'exp', 0, 8192.0),
	ControlSpec(32.0, 512.0, 'exp', 0, 256.0)
];

~paramgep.chromosomes.do({|chrom|
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) });
	~terminals.size.do({ chrom.addExtraDomain(~maps.choose) })
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

Routine({

	~targetBuffer = Buffer.read(s, "/Users/alo/snd/gep/gepsynth02.aif");

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


~targetAnalyzer.currentStats
~targetAnalyzer.currentErrors.mean
~targetAnalyzer.calculateCPUsage

~gep.removeFitnessFunc(0)

(
// fitness function based on target

~makeGepDef = {|name, func, nargs = 8|
	SynthDef(name, {|out, dur = 0.1, amp = 1.0, rotx = 0.0, roty = 0.0, rotz = 0.0|
		var sig;
		sig = SynthDef.wrap(func, prependArgs: ArrayControl.kr('gepargs', nargs, 0.0) )
			* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
		Out.ar(out, FoaTransform.ar(
			FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
		)
	});
};

~env = Env(#[0.001, 1.0, 1.0, 0.001], #[0.1, 0.8, 0.1], \exp);

~gep.addFitnessFunc({

	if (~defs.notNil) {
		~defs.do({|def| if (def.notNil) { SynthDef.removeAt(def.name) } })
	};

	~depths = Array.newClear(~gep.chromosomes.size);

	~defs = ~gep.chromosomes.collect({|chrom, i|
		var defname, defstr, tree, fnc;
		defname = ("gep_gen" ++ ~gep.generationCount.asString.padLeft(3, "0")
			++ "_" ++ i.asString.padLeft(3, "0")).asSymbol;
		tree = chrom.asUgenExpressionTree;
		~depths[i] = tree.maxDepth;
		defstr = tree.asSynthDefWrapString(Normalizer);
		fnc = defstr.interpret;
		{
			~makeGepDef.(defname, fnc, ~terminals.size).add
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
					[\out, ~gepAnalyzer.bus, \amp, 1, \dur, fragdur]
				).setn('env', ~env).setn('gepargs', ~params[i].asInt.collect(_.nextPrime));
				fragdur.wait;
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

~env

// run first time
~gep.updateScores

~decoder = FoaDecoder(decoderType: 'stereo');

~decoder.start

(
// for each next generation
~paramgep.nextGeneration;
~gep.nextGeneration;
)

[~gep.meanScore, ~gep.maxScore]
[~gep.meanScore, ~gep.maxScore, ~gep.chromosomes.collect(_.score).stdDev].postln

~th = 6.0;
~gep.chromosomes.collect(_.score).select({|sc| sc > ~th })
~gep.chromosomes.collect(_.score).select({|sc| sc > ~th }).size

(~gep.chromosomes.collect(_.score).select({|sc| sc == 0 }).size / ~populationSize)

~gep.chromosomes.collect(_.score).select({|sc| sc > ~th }).size

(
~rt = Routine({
	var fragdur = ~targetBuffer.duration;
	~defs.do({|def, i|
		if (~gep.at(i).score > ~th) {
			var synth, args;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree
				.asSynthDefWrapString(Normalizer).postln;
			Post << "SCORE: " << ~gep.at(i).score << Char.nl;
			synth = Synth.before(~decoder.synth, def.name, [\out, ~decoder.bus,
				\amp, 0.0, \dur, fragdur]
				).setn('env', ~env).setn('gepargs', ~params[i].asInt.collect(_.nextPrime));
			s.sync;
			0.5.wait;
			synth.set('amp', 0.5);
			fragdur.wait;
			synth = nil;
			0.5.wait;
		}
	})
}).play
)

s.queryAllNodes

~rt.stop

~gep.jsonWriter.envirID

~params[253].collect({|num| if (num.isNaN) { 0 } { num }  })

(

var save = true;

Routine({
	var fragdur = 5, indices;
	indices = [0, 1, 2, 4, 6, 7];
	indices.do({|ind, i|
		var synth, args, def, savename, et, co, cospec;
		def = ~defs[ind];
		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		et = ~gep.at(ind).asUgenExpressionTree;
		et.asSynthDefWrapString(Normalizer).postln;
		args =  [~terminals, ~params[ind].collect({|num| if (num.isNaN) { 0 } { num }  })]
			.lace(~terminals.size * 2).postln;
		Post << "SCORE: " << ~gep.at(ind).score << Char.nl;
		synth = Synth.before(~decoder.synth, def.name, [\out, ~decoder.bus,
			\amp, 0.0, \dur, fragdur])
			.setn('env', ~env).setn('gepargs', ~params[ind].asInt.collect(_.nextPrime));
		s.sync;
		0.5.wait;
		synth.set('amp', 0.5);
		fragdur.wait;
		synth = nil;
		0.5.wait;
		if (save) {
			~gep.saveJson(ind, Pan2, Normalizer, args, ~paramgep.chromosomes[ind],
				~gepAnalyzer.stats[def.name.asSymbol]
			);
		}
	})
}).play

)

~def = ~defs[1]

~stats = ~gepAnalyzer.stats[~def.name.asSymbol]

~stats.last

s.scope
