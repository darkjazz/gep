~ncoef = 20;
~rate = 20;


(
// create target statistics

~targetAnalyzer = UGepTimeAnalyzer(
	SynthDef(\targetBuf, {|out, buf|
		Out.ar(out, Mix(PlayBuf.ar(2, buf, BufRateScale.kr(buf), doneAction: 2)))
	}).add, 
	~ncoef
);

Routine({

	s.sync;
	
	~targetAnalyzer.currentDef = \targetBuf;
	
	~targetBuffer = Buffer.read(s, "/Users/alo/sounds/gep/random.aif");
	
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
// compare statistics

~compareAnalyzer = UGepTimeAnalyzer(
	SynthDef(\targetBuf, {|out, buf|
		Line.kr(dur: ~targetBuffer.duration, doneAction: 2);
		Out.ar(out, Mix(PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1)))
	}).add, 
	~ncoef,
	~targetAnalyzer.stats[~targetAnalyzer.currentDef]
);

Routine({

	s.sync;
	
	~compareAnalyzer.currentDef = \targetBuf;

	~compareBuffer = Buffer.read(s, "/Users/alo/sounds/gep/fxchck.aif");
				
	s.sync;
	
	OSCFunc({|msg|
		~compareAnalyzer.freeSynth;
 		~compareAnalyzer.clear;
 		"resources freed...".postln;
	}, '/n_end', s.addr).oneShot;

	
	~compareAnalyzer.run(rate: ~rate);
		
	Synth.before(~compareAnalyzer.synth, \targetBuf, [\out, ~compareAnalyzer.bus, \buf, ~compareBuffer]);

}).play;

)

~targetBuffer.duration

~compareBuffer.duration

~stats = ~compareAnalyzer.stats[~compareAnalyzer.currentDef]
~target = ~targetAnalyzer.stats[~targetAnalyzer.currentDef]

~stats.size
~target.size

~distances = (
	'mfcc': Array.newClear(~target.size),
	'flat': Array.newClear(~target.size),
	'cent': Array.newClear(~target.size),
	'amp': Array.newClear(~target.size)
);

~target.do({|targetEvent, i|
	~distances.mfcc[i] = (targetEvent[1].keep(20) - ~stats[i][1].keep(20)).abs;
	~distances.flat[i] = (targetEvent[1][20] - ~stats[i][1][20]).abs;
	~distances.cent[i] = (targetEvent[1][20] - ~stats[i][1][20]).abs;
	~distances.amp[i] = (targetEvent[1][20] - ~stats[i][1][20]).abs;
});

~max = (
	'mfcc': Array.newClear(~ncoef),
	'flat': 0,
	'cent': 0,
	'amp': 0
);

~max.mfcc = ~distances.mfcc.collect(_.maxItem);
~max.flat = ~distances.flat.maxItem;
~max.cent = ~distances.cent.maxItem;
~max.amp = ~distances.amp.maxItem;

~normalized = ();

~normalized.mfcc = ~distances.mfcc.collect({|mfcc, i| [0, ~max.mfcc[i]].asSpec.unmap(mfcc) });
~normalized.flat = [0, ~max.flat].asSpec.unmap(~distances.flat);
~normalized.cent = [0, ~max.cent].asSpec.unmap(~distances.cent);
~normalized.amp = [0, ~max.amp].asSpec.unmap(~distances.amp);

~normalized.mfcc = ~normalized.mfcc.select({|array| array.includes(0/0).not })
~normalized.flat = ~normalized.flat.select({|item| item > 0 })
~normalized.cent = ~normalized.cent.select({|item| item > 0 })
~normalized.amp = ~normalized.amp.select({|item| item > 0 })

[
1.0 - (~normalized.mfcc.flop.collect(_.mean).mean) * 0.4,
1.0 - ~normalized.flat.mean * 0.2,
1.0 - ~normalized.cent.mean * 0.2,
1.0 - ~normalized.amp.mean * 0.2
].sum


~compareAnalyzer.currentDef 

~normalized = ~compareAnalyzer.calculateDistances

~normalized.mfcc = ~normalized.mfcc.select({|array| array.includes(0/0).not })
~normalized.flat = ~normalized.flat.select({|item| item > 0 })
~normalized.cent = ~normalized.cent.select({|item| item > 0 })
~normalized.amp = ~normalized.amp.select({|item| item > 0 })

~score = [
1.0 - (~normalized.mfcc.flop.collect(_.mean).mean) * 0.4,
1.0 - ~normalized.flat.mean * 0.2,
1.0 - ~normalized.cent.mean * 0.2,
1.0 - ~normalized.amp.mean * 0.2
].sum

