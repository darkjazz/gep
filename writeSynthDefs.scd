(
~paths = Pseq("/Users/alo/SuperCollider/gep/targetGepDefs*".pathMatch, 1).asStream;

~saveFunc = {|path|
	
	var file, str, nextpath, startDef, endDef, startArg, endArg;
	
	file = File.open(path, "r");
	
	str = file.readAllString;
	
	file.close;

	startDef = str.findAll("SynthDef");
	
	endDef = str.findAll("})\n[")+1;
	
	startArg = endDef + 2;
	
	endArg = str.findAll("]");
	
	~defs = startDef.size.collect({|i|
		var def, args;
		def = str.copyRange(startDef[i], endDef[i]).interpret;
		def.metadata = (args: str.copyRange(startArg[i],endArg[i]).insert(0, "#").interpret);
		def.add;
	});
	
	Post << "Starting analysis for file " << path << Char.nl; 

	Routine({
		
		var bus, fragdur = 5;
		var defdir = "/Users/alo/Data/gep/synthdefs/";
		var metadir = "/Users/alo/Data/gep/metadata/";	
		var arch;
				
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
		
		s.sync;
		
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
		
		bus = Bus.audio;
		
		s.sync;	
		
		~defs.do({|def, i|
			var synth, ev, analyzer, mean = 0, stddev = 0, stats;
	
			analyzer = Synth(\analyze, [\in, bus, \rate, 10]);
			s.sync;
			
			Post << "-------------  START " << def.name << " --------------" << Char.nl;
			synth = Synth.before(analyzer, def.name, [\out, bus] ++ def.metadata[\args]);
			s.sync;
			
			~currentKey = def.name.asSymbol;
			
			fragdur.wait;
	
			synth.free;
			synth = nil;
			analyzer.free;
			analyzer = nil;
			ev = ~deflib[~currentKey];
			
			stats = ();
			
			stats = ev.collect({|stat|
				if (stat.isKindOf(Array)) {
					stat.collect({|mfcc| (mean: mfcc.mean, stdDev: mfcc.stdDev)  })
				}
				{
					(mean: stat.mean, stdDev: stat.stdDev)
				}
			});
			
			def.metadata[\stats] = stats;

			def.name = def.name ++ "_" ++ Date.getDate.stamp;
			
			arch = ZArchive.write(metadir++def.name++".gepmeta");
			
			def.writeDefFile(defdir);
			
			Post << "Writing def " << def.name << " to " << defdir << Char.nl;
			
			arch.writeItem(def.metadata);
			
			arch.writeClose;
			
			arch = nil;
			
			Post << "Writing metadata " << def.name << " to " << metadir << Char.nl;
			
			1.wait;
			
			
		});
		
		1.wait;
		
		nextpath = ~paths.next;
		
		if (nextpath.notNil) {	
			~saveFunc.(nextpath)
		}
	
	}).play
};

~saveFunc.(~paths.next)

)

~defs[0].metadata.stats.mfcc

(
Routine({
	var defdir = "/Users/alo/Data/gep/synthdefs/";
	var metadir = "/Users/alo/Data/gep/metadata/";
	~defs.do({|def|
		var arch;
		def.name = def.name ++ "_" ++ Date.getDate.stamp;
		arch = ZArchive.write(metadir++def.name++".gepmeta");
		def.writeDefFile(defdir);
		Post << "Writing def " << def.name << " to " << defdir << Char.nl;
		arch.writeItem(def.metadata);
		arch.writeClose;
		arch = nil;
		Post << "Writing metadata " << def.name << " to " << metadir << Char.nl;
		1.wait;
	});
	"finished writing synthdefs".postln;
}).play
)