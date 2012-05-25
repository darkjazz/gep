(
SynthDef(\analyze, {|in, rate|
	var input, fft, mfcc, flat, cent, amp, error, trig;
	trig = Impulse.kr(rate);
	input = In.ar(in);
	fft = FFT(LocalBuf(1024), input);
	mfcc = MFCC.kr(fft);
	flat = SpecFlatness.kr(fft);
	cent = SpecCentroid.kr(fft);
	amp = Amplitude.kr(input);
	error = CheckBadValues.kr(input);
	SendReply.kr(trig, '/mfcc', mfcc);
	SendReply.kr(trig, '/flat', flat);
	SendReply.kr(trig, '/cent', cent);
	SendReply.kr(trig, '/amp', amp);
	SendReply.kr(trig, '/err', error);	
}).add;

)


(
~defs = [
	SynthDef(\sine, {|out|
		Out.ar(out, SinOsc.ar(440) * 0.5)
	}),
	SynthDef(\saw, {|out|
		Out.ar(out, LFSaw.ar(110) * 0.5)
	}),
	SynthDef(\noise, {|out|
		Out.ar(out, WhiteNoise.ar * 0.5)
	}),
	SynthDef(\pulse, {|out|
		Out.ar(out, LFPulse.ar(55) * 0.5)
	})
];

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
	var bus, analyzer, fragdur=5;
	bus = Bus.audio;
	~defs.do(_.add);
	s.sync;
	analyzer = Synth(\analyze, [\in, bus, \rate, 10]);
	~defs.do({|def|	
		var synth;
		Post << "-------------  START " << def.name << " --------------" << Char.nl;
		synth = Synth.before(analyzer, def.name, [\out, bus]);
		s.sync;
		~currentKey = def.name.asSymbol;
		fragdur.wait;
		synth.free;
	});
	~oscfncs.do(_.disable);
	~oscfncs = nil;
	bus.free;
	analyzer.free;
}).play
)

(
~deflib.collect({|ev, name|
	var score = 0;
	Post << "----------    " << name << "    -----------" << Char.nl; 
	~deflib[name][\mfcc].do({|stat, i|
//		score = score + (0.25 - stat.mean).abs;
		score = score + stat.stdDev; 
		[i, stat.mean, (0.25 - stat.mean).abs, stat.stdDev].postln
	});
	["flatness", ev[\flat].mean, ev[\flat].stdDev].postln;
	score = score + (0.5 - (0.5 - ev[\flat].mean));
	score = score + ev[\flat].stdDev;
	["centroid", ev[\cent].mean, ev[\cent].stdDev].postln;
	["amp", ev[\amp].mean, ev[\amp].stdDev].postln;
	if (ev[\amp].mean > 1) {
		score = score - ev[\amp].mean 
	};
	score = score + ev[\amp].stdDev;
	["error", ev[\err].mean, ev[\err].stdDev].postln;
	score = score - ev[\err].mean;
	score
})
)



