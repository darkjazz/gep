(
s.loadDirectory("/Users/alo/Data/gep/synthdefs/");

~defnames = Array();
~data = Array();

"/Users/alo/Data/gep/metadata/*".pathMatch.collect(_.basename).collect({|name| name.split($.).first }).do({|name|
	var data = UGExpressionTree.loadMetadata(name);
	if (data.stats.mfcc.collect(_.mean).sum.isNaN.not) {
		if (data.stats.mfcc.size == 13) {
			~data = ~data.add( data );
			~defnames = ~defnames.add( name );	
		}
	}
});

~vectors = ~data.collect(_.stats).collect({|stat| stat.mfcc.collect({|mfc| [mfc.mean, mfc.stdDev] }).flop.flat });

~nclusters = 8;

~kmeans = KMeans(~nclusters);

~vectors.do({|vec|  ~kmeans.add(vec) });

~nclusters.do({|i| ~kmeans.assignments.occurrencesOf(i).postln });

~kmeans.update

)

(

SynthDef(\proc, {|in|
	var input, sig;
	input = In.ar(in, 2);
	sig = Limiter.ar( LeakDC.ar(input) );
	Out.ar(0, sig)
}).add;

~record = true;

if (~record) { s.record };

~totaldur = 256;
~density = 2;

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
		~sectiondur.wait
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