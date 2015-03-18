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

~init = UGepLoader().loadNames(#[ 
	gep_gen001_016_141002_132750, 
	gep_gen002_048_141002_140646
]);

//~init = UGepLoader().loadNames(#[ 
//	gep_gen003_014_141002_143021, 
//	gep_gen003_030_141002_143032 
//]);

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


~rout.stop

~index = 1;

~gep.chromosomes[1].asUgenExpressionTree.asSynthDefString('gep_gen002_048_141002_140646', Pan2, Normalizer);

~args = [~terminals, ~params[~index]].lace(~terminals.size * 2)

~synth = Synth(~defs[~index].name, [\amp, 0.0] ++ ~args)

~synth.set('amp', 0.3)

~synth.free

~colors = nil


~gep.draw

~gep.colors

~gep.names

(
// DRAW
if (~colors.isNil) {
	~colors = ~ugens.collect({ Color( *{1.0.rand.round(0.1)} ! 3 ) })
};
~win = Window("GES", Rect(100, 100, 450, 800)).background_(Color.grey(0.1)).front;
~win.drawFunc = {
	var currentGen = 0;
	var posy = 10;
	~gep.chromosomes.do({|chrom, y|
		var colors, ugens = chrom.code.select({|codon| codon.isKindOf(Class) });
		colors = ugens.collect({|ugen| ~colors[~ugens.indexOf(ugen)] });
		if (currentGen == chrom.generation) 
		{ posy = posy + 10; } 
		{ posy = posy + 20; currentGen = chrom.generation};
		Pen.font = Font("Inconsolata", 8);
		colors.do({|color, x|
			Pen.fillColor = Color.grey(0.8);
			Pen.stringInRect(y.asString.padLeft(2), Rect(10, posy, 10, 7));
			color.set;
			Pen.fillRect(Rect(x*12+20, posy, 12, 7));
		})
	})	
};
)


~gep.chromosomes.do({|chrom, i|
	Post << i << " " << chrom.generation << " " << chrom.score.round(0.01) << " " << chrom.code.keep(4) << Char.nl;
})

~gep.chromosomes.collect(_.score).sum / 60



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

~maxSize = ~gep.chromosomes.collect({|chrm| chrm.code.select({|codon| codon.isKindOf(Class) }) }).collect(_.size).maxItem

(
~visualize = {|chromA, chromB|
	var ucodeA, ucodeB, maxLen, similarity;
	#ucodeA, ucodeB = [chromA, chromB].collect({|chrm| 
		chrm.code.select({|codon| codon.isKindOf(Class) }) 
	});
	maxLen = max(ucodeA.size, ucodeB.size);
	similarity = (~calculateSimilarity.(chromA, chromB)*100).round(1);
	Window("GES - compare", Rect(100, 100, 1000, 200)).background_(Color.grey(0.1)).front
	.drawFunc_({
		var size;
		size = (960 / maxLen).floor;
		[ucodeA, ucodeB].do({|code, y|
			Pen.font = Font("Inconsolata", 10);
			code.do({|ugen, x|
				var rect, index, color;
				index = ~ugens.indexOf(ugen);
				color = ~colors[index];
				color.set;
				rect = Rect(x*size+20, y*(size + 10)+20, size, size);
				Pen.fillOval(rect);
				Color.grey(0.7).set;
				Pen.strokeOval(rect);
				Pen.fillColor = Color.white;
				Pen.stringCenteredIn(~abbrev[index], rect);
			})			
		});
		Pen.font = Font("Lato Regular", 14);
		Pen.stringInRect("Similarity: " ++ similarity.asString ++ "%", Rect(20, 120, 200, 100));
	});	
}
)

(
~calculateSimilarity = {|chromA, chromB|
	var sameCount = 0, len = min(chromA.code.size, chromB.code.size);
	len.do({|i|
		if (chromA.code[i] == chromB.code[i]) 
		{
			sameCount = sameCount + 1
		}
	});
	sameCount / max(chromA.code.size, chromB.code.size)
}
)

~chrA = ~gep.chromosomes[5];
~chrB = ~gep.chromosomes[6];

~visualize.(~chrA, ~chrB)

~calculateSimilarity.(~gep.chromosomes[1], ~gep.chromosomes[4])


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



(
~drawdict = [];

~drawExpressionTree = {|chrom|
	var tree, win, view, dict, layers, size;
	~drawdict = [];
	size = 34;
	tree = chrom.asUgenExpressionTree;
	~getNodes.(tree.root, 0);
	layers = tree.maxDepth.collect({|y| 
		~drawdict.select({|ev| ev.depth == y }).size 
	});
	win = Window("tree", Rect(100, 100, 800, 600))
		.background_(Color.grey(0.1)).front;
	view = UserView(win, Rect(0, 0, win.view.bounds.width, win.view.bounds.height));
	view.clearOnRefresh = false;
	view.drawFunc = {
		var linrect;
		tree.maxDepth.do({|y|
			var step, nextstep, childno = 0;
			step = view.bounds.width - 40 / layers[y];
			if (y < layers.lastIndex)
			{
				nextstep = view.bounds.width - 40 / layers[y + 1];
			};
			~drawdict.select({|ev|
				ev.depth == y
			}).do({|ev, x|
				var color, rect, index, from, to;
				if (ev.depth == 0)
				{
					Pen.color = Color.grey(0.7);
					from = Point(x*(size+(step-size))+(step*0.5) + (size*0.5), y*110+100 + (size*0.5));
					to = Point(view.bounds.width*0.5, 10 + (size*0.5));
					Pen.line(from, to);
					Pen.perform(\stroke);
				};
				if (ev.children > 0)
				{
					Pen.color = Color.grey(0.7);
					ev.children.do({|cx|
						from = Point(x*(size+(step-size))+(step*0.5) + (size*0.5), y*110+100 + (size*0.5));
						to = Point(childno*(size+(nextstep-size))+(nextstep*0.5)+(size*0.5),(y+1)*110+100+(size*0.5));
						Pen.line(from, to);
						childno = childno + 1;
					});
					Pen.perform(\stroke);
				};
				index = ~ugens.indexOf(ev.ugen);
				rect = Rect(x*(size+(step-size))+(step*0.5), y*110+100, size, size);
				~colors[index].set;
				Pen.fillOval(rect);
				Color.grey(0.7).set;
				Pen.strokeOval(rect);		
				Pen.font = Font("Inconsolata", 10);
				Pen.fillColor = Color.white;
				Pen.stringCenteredIn(~abbrev[index], rect);
			})
		});
		linrect = Rect(view.bounds.width*0.5-(size*0.5), 10, size, size);
		Color.black.set;
		Pen.fillOval(linrect);
		Color.grey(0.7).set;
		Pen.strokeOval(linrect);
		Pen.fillColor = Color.white;
		Pen.stringCenteredIn("*", linrect);
		
	}
};

~getNodes = {|node, depth|
	if (node.nodes.notNil)
	{
		node.nodes.do({|subnode|
			if(subnode.isFunction) { 
				var numins = subnode.nodes.select({|it| it.isFunction });
				~drawdict = ~drawdict.add(
					('ugen': subnode.value, 'depth': depth, 'children': numins.size)
				);
				Post << (($\t)!depth).toString << subnode.value << Char.nl;
				~getNodes.(subnode, depth+1)
			}
		})
	}
};

)


~gep.chromosomes.keep(4).do({|chrom|
	~drawExpressionTree.(chrom)
})

~drawExpressionTree.(~gep.chromosomes[6])

~drawdict.select({|ev| ev.depth == 0 }).do(_.postln)

~drawdict.do(_.postln)

~gep.chromosomes[0].asUgenExpressionTree.asSynthDefString('00_00', Pan2, Normalizer);