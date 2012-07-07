(
s.loadDirectory("/Users/alo/Data/gep/synthdefs/");

~defnames = Array();
~data = Array();

"/Users/alo/Data/gep/metadata/*".pathMatch.collect(_.basename).collect({|name| name.split($.).first }).do({|name|
	var data = UGenExpressionTree.loadMetadata(name);
	if (data.stats.mfcc.collect(_.mean).sum.isNaN.not) {
		if (data.stats.mfcc.size == 20) {
			~data = ~data.add( data );
			~defnames = ~defnames.add( name );	
		}
	}
});

~vectors = ~data.collect(_.stats).collect({|stat| stat.mfcc.collect({|mfc| [mfc.mean, mfc.stdDev] }).flat });

~nclusters = 32;

~kmeans = KMeans(~nclusters);

~vectors.do({|vec| 
	~kmeans.add(vec)
});

~nclusters.do({|i|
	~kmeans.assignments.occurrencesOf(i).postln;
});

~kmeans.update

)


(

SynthDef(\proc, {|in|
	var input, sig;
	input = In.ar(in, 2);
	sig = Limiter.ar( LeakDC.ar(input), 0.95 );
	Out.ar(0, sig)
}).add;

~record = true;

if (~record) { s.record };

~totaldur = 512;
~density = 4;

~sectiondur = ~totaldur / (~nclusters * ~density.reciprocal);

~assignments = Array.fill(~nclusters, {|i|
	~kmeans.assignments.selectIndices({|cluster| cluster == i })
});

Routine({
	var proc, bus;
	bus = Bus.audio(s, 2);
	s.sync;
	proc = Synth(\proc, [\in, bus]);
	s.sync;
	~assignments.scramble.clump(~density).do({|layers|
		layers.do({|layer|
			Routine({
				var layerdur = ~sectiondur / layer.size;
				layer.do({|index|
					var synth;
					synth = Synth(~defnames[index], [\out, bus] ++ ~data[index].args);
					layerdur.wait;
					synth.free;
					synth = nil
				})
			}).play
		});
		(~sectiondur + rrand(1, 4)).wait
	});
	1.wait;
	proc.free;
	proc = nil;
	bus.free;
	bus = nil;
	if (~record) {
		s.stopRecording
	}
}).play

)