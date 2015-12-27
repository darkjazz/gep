// evolve a population from 2 initial chromosomes
(
~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;
~populationSize = 2;

// UGENS
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

~loader = JsonLoader("ges_00");

~init = [ 'gep_gen005_024_150602_171058', 'gep_gen005_056_150602_171115' ].collect({|name|
	~loader.getDocumentByDefName(name)
});

/*
gep_gen004_024_150601_094339, gep_gen004_022_150601_094333
gep_gen004_011_150601_102333, gep_gen004_002_150601_102322
gep_gen005_016_150601_154429, gep_gen005_020_150601_154435
gep_gen005_036_150601_155306, gep_gen005_055_150601_155311
gep_gen005_009_150601_220926, gep_gen005_048_150601_220937
gep_gen005_024_150602_094838, gep_gen005_054_150602_094844
gep_gen005_025_150602_100148, gep_gen005_036_150602_100205
gep_gen005_013_150602_120957, gep_gen005_023_150602_121020
gep_gen005_034_150602_122508, gep_gen005_047_150602_122531
gep_gen005_016_150602_131543, gep_gen005_019_150602_131548
gep_gen005_012_150602_133238, gep_gen005_016_150602_133244
gep_gen005_012_150602_160820, gep_gen005_017_150602_160831
*/

~init.do({|data, i|
	~gep.chromosomes[i] = GEPChromosome.fromJsonData(~init[i])
});

~gep.mutationRate = 0.1;
~gep.recombinationRate = 1.0;
~gep.transpositionRate = 0.25;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

// parameters
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
	~paramgep.chromosomes[i] = GEPChromosome(data.params.code, ~paramterminals, ~paramnumgenes, ~paramgep.linker);
	~paramgep.chromosomes[i].constants = data.params.constants;
	~paramgep.chromosomes[i].extraDomains = data.params.extraDomains;
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
// evolve 5 generations, each doubling in size
4.do({
	~gep.growPopulation;
	~paramgep.growPopulation;
});

)



(
// create target statistics

Routine({

	~targetBuffer = Buffer.read(s, "/Users/alo/snd/gep/urtinduu.aif");

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
		rawargs = chrom.asExpressionTree(false).asFunctionString.interpret
			.value(*chrom.constants);
		rawargs.collect({|num, i|
			chrom.extraDomains[i].map(num.wrap(0.0, 1.0)).roundFreq
		})
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
				Post << "-------------  START " << def.name << " --------------"
					<< Char.nl;
				~gepAnalyzer.run(rate: ~rate);
				synth = Synth.before(~gepAnalyzer.synth, def.name,
					[\out, ~gepAnalyzer.bus, \amp, 1]
					++ [~terminals, ~params[i]].lace(~terminals.size * 2));
				fragdur.wait;
				synth.free;
				synth = nil;
				~gepAnalyzer.freeSynth;
				normalized = ~gepAnalyzer.calculateDistances;
				normalized.mfcc = normalized.mfcc.select({|array|
					array.includes(0/0).not
				});
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
				<< "; total change: " << (~gep[i].score - pscore).round(0.001)
					<< Char.nl;
			}
		});
		~gepAnalyzer.clear;
		Post << " ------- analysis finished ------- " << Char.nl;
		[~gep.meanScore, ~gep.maxScore].postln;
		~gep.chromosomes.collect(_.score).postln;
	}).play
})

)



// update scores for all chromosomes

~gep.updateScores


~gep.drawSimilarityMatrix(12)

~smatrix = ~gep.similarityMatrix.deepCopy

(
~current = 0;
~seq = [];
32.do({
	var sim;
	~smatrix[~current][~current] = 0;
	sim = ~smatrix[~current];
	~closest = sim.indexOf(sim.maxItem);
	~seq = ~seq.add((ind: ~current, sim: sim.maxItem));
	~smatrix.do({|arr| arr[~current] = 0 });
	~current = ~closest;
})
)
~inds = ~seq.collect(_.ind)


// ambisonic decoder start
~decoder = FoaDecoder(decoderType: 'stereo')


(
// prepare data for ges player
~data = ~params.collect({|values, i|
	(
	defname: ~defs[i].name,
	args: (args: [~terminals, values].lace(~terminals.size * 2)),
	data: (code: ~gep.chromosomes[i].code, terminals: ~terminals, linker: ~gep.linker,
			header: (numgenes: ~numgenes)
		)
	)
})
)

~decoder.start

~player = GepPlayer(~data, ~decoder)

~player.start

~player.setFoa('zoom', 1.0)

~player.setFoa('focus', 1.0)

s.record

(
~rout = Routine({
	var meandur, mul = 10;
	meandur = (~gep.chromosomes.collect(_.score)*mul).mean;
	~seq.do({|item|
		var amp, score, dur;
		score = ~gep.chromosomes[item.ind].score;
		if (score > 0)
		{
			dur = score * mul;
			amp = rrand(0.3, 0.5);
			~player.play(item.ind, 0);
			~player.fade(item.ind, 0, amp, dur*0.2);
			SystemClock.sched(dur*0.8, { ~player.fade(item.ind, amp, 0, dur*0.2); nil });
			SystemClock.sched(dur, { ~player.free(item.ind); nil });
			(meandur*rrand(0.3, 0.5)).wait;
		}
	})
})

)

~inds

MasterEQ(2)

s.record

~rout.play

~rout.stop

s.queryAllNodes

s.stopRecording

~seq.collect(_.ind)

s.scope


/// SAVE DEFS

~th = 6.9

~gep.chromosomes.collect(_.score).select({|it| it > ~th }).size

[~gep.meanScore, ~gep.maxScore]

s.record

(
~rt = Routine({
	var fragdur = ~targetBuffer.duration;
	~defs.do({|def, i|
		if (~gep.at(i).score > ~th) {
			var synth, args;
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			~gep.at(i).asUgenExpressionTree
				.asSynthDefString(def.name.asSymbol, Pan2, Normalizer, false).postln;
			args =  [~terminals, ~params[i]].lace(~terminals.size * 2).postln;
			Post << "SCORE: " << ~gep.at(i).score << Char.nl;
			synth = Synth(def.name, [\amp, 0.0, \dur, fragdur+0.5] ++ args);
			0.2.wait;
			synth.set('amp', 0.5);
			(fragdur + rrand(0.5, 1.0)).wait;
			synth.free;
			synth = nil;
			s.sync;
			rrand(0.5, 1.0).wait;
		}
	})
}).play
)

s.stopRecording

s.queryAllNodes

~rt.stop

~inds.size

24, 56

(

var save = true;

Routine({
	var fragdur = 5, indices;
	indices = [7, 20, 24, 26, 52, 56];
	indices.do({|ind, i|
		var synth, args, def, savename, et, co, cospec;
		def = ~defs[ind];
		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		et = ~gep.at(ind).asUgenExpressionTree;
		et.asSynthDefString(def.name.asSymbol, Pan2, Normalizer, false).postln;
		args =  [~terminals, ~params[ind]].lace(~terminals.size * 2).postln;
		Post << "SCORE: " << ~gep.at(ind).score << Char.nl;
		synth = Synth(def.name, [\amp, 0, \dur, fragdur+0.5] ++ args);
		0.2.wait;
		synth.set('amp', 0.5);
		fragdur.wait;
		synth.free;
		synth = nil;
		s.sync;
		0.5.wait;
		if (save) {
			~gep.saveJson(ind, Pan2, Normalizer, args, ~paramgep.chromosomes[ind],
				~gepAnalyzer.stats[def.name.asSymbol]
			);
		}
	})
}).play

)


~decoder = FoaDecoder(decoderType: 'stereo')

~decoder.start


~player = JGepPlayer(~decoder, CinderApp(), "ges_00")

~player.getDefNamesByDate("150303")

~player.start

~player.setFoa('zoom', 1.0)


~player.setFoa('focus', 1.0)

~ind = 9;

~player.play(~ind, 0.2, 'zoom')

~player.free(~ind)



gep_gen004_019_150303_091430
gep_gen004_013_150303_091413