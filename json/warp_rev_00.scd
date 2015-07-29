(
~bufs = ();

5.do({|i|
	var seconds = (i+1) * 2;
 	~bufs[("b" ++ seconds.asString).asSymbol] = Buffer.alloc(
 		Server.default, Server.default.sampleRate * seconds, 2
 	);
});

~defrev = SynthDef('wrprev', {|out, in, wrp, freq, wsize, dens, randr, 
		room, rtime, ramp, damp, iamp, buf, id, amp |
	var input, warpsig, revsig, freeTrig;
	input = In.ar(in, 2) * amp;
	freeTrig = CheckBadValues.kr(input, 0, 0);
	Free.kr(freeTrig, id);
	FreeSelf.kr(freeTrig);
	warpsig = WarpIn.ar(
		in: input, 
		buffer: buf, 
		warpFactor: [wrp, wrp*15/16], 
		freqScale: freq, 
		windowSize: wsize, 
		overlaps: dens, 
		windowRandRatio: randr,
		loop: 1
	);
	revsig = GVerb.ar(warpsig[0], room, rtime, 
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp)
		+ 
		GVerb.ar(warpsig[1], room, rtime, 
			drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	Out.ar(out, revsig + (input * iamp)); 
});

~defwrp = SynthDef('revwrp', {|out, in, wrp, freq, wsize, dens, randr, 
		room, rtime, ramp, damp, iamp, buf, id, amp |
	var input, warpsig, revsig, freeTrig;
	input = In.ar(in, 2) * amp;
	freeTrig = CheckBadValues.kr(input, 0, 0);
	Free.kr(freeTrig, id);
	FreeSelf.kr(freeTrig);
	revsig = GVerb.ar(input[0], room, rtime, 
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp)
		+ 
		GVerb.ar(input[1], room, rtime, 
			drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	warpsig = WarpIn.ar(
		in: revsig, 
		buffer: buf, 
		warpFactor: [wrp, wrp*15/16], 
		freqScale: freq, 
		windowSize: wsize, 
		overlaps: dens, 
		windowRandRatio: randr,
		loop: 1
	);
	Out.ar(out, warpsig + (input * iamp)); 
});

)


~decoder = FoaDecoder(false)

~decoder.test

~decoder.stopTest

~player = JGepPlayer(~decoder, dbname: "ges_00")


~player.getDefNamesByHeader(14, 4)



~player.defnames.size

~decoder.start

~foa = #[focus,press];


~player.startManual(~foa)

~player.setFoa('focus', 1.0)
~player.setFoa('press', 1.0);


~indices = [16, 24, 42, 45, 56, 61, 63, 69, 70, 73, 76, 81, 101, 104, 111, 115, 119, 122, 123, 125, 126, 127, 128, 130, 143, 145, 153, 156, 157, 158, 159, 160, 164, 165, 176, 183, 186, 188, 189, 191, 192, 193, 196, 206, 212, 216, 220, 221, 222, 224, 226, 234, 236, 238, 248, 253, 257, 259]


Tdef('evolver').clear

~ind = 259;



~foakind = 'focus'

~args = [ \wrp, 0.1, \freq, 1.0, \wsize, 0.1, \dens, 10, \randr, 0.01, \room, 300,
 	\rtime, 6, \ramp, 0.2, \damp, 0.3, \iamp, 0.0, \buf, ~bufs['b4']];

~player.procplay(~ind, 0.0, ~foakind, 0, ~defrev, ~args)

~player.set(~ind, 0.0)

~player.free(~ind)


~player.synths[~ind].proc.set('iamp', 0.3, 'ramp', 0.2, 'wrp', 0.3, 'freq', 1.0)

~player.foaSynths[("foa" ++ ~foakind).asSymbol].set('angle', 0.5pi, 'theta', pi)

Routine({
	var val, step = 2pi / 100;
	val = 0;
	100.do({
		val = val + step;
		~player.foaSynths[("foa" ++ ~foakind).asSymbol].set('rox', val);
		0.1.wait;	
	})
}).play

Pdef('foa',
	Pbind(
		\type, \set, 
		\id, ~player.foaSynths[("foa" ++ ~foakind).asSymbol].nodeID,
		\angle, Pseg(Pseq([0, 0.5pi, 0]), Pseq([6, 6]), \linear, inf), 
		\theta, Pseg(Pseq([0, 0.5pi, 0]), Pseq([5, 5]), \linear, inf), 
		\phi, Pseg(Pseq([0, 0.25pi, -0.25pi, 0]), Pseq([4, 4, 4]), \linear, inf), 
		\rox, Pseg(Pseq([0, 2pi, 0]), Pseq([6, 6]), \linear, inf), 
		\roy, Pseg(Pseq([0, 2pi, 0]), Pseq([7, 7]), \linear, inf), 
		\roz, Pseg(Pseq([0, 2pi, 0]), Pseq([7, 6]), \linear, inf), 
		\delta, 0.2
	)
)

Pdef('foa').play

Pdef('foa').clear

Env([0.01, 0.4, 0.01], [0.5, 0.5], \sine).plot


(
Pdef('xfrm', 
	Pbind(
		\type, \set, 
		\id, ~player.synths[~ind].proc.nodeID, 
		\damp, Pseg(Pseq([0.01, 0.4, 0.01]), Pseq([4, 4]), \sine, inf),
		\ramp, Pseg(Pseq([0.01, 0.2, 0.01]), Pseq([6, 6]), \sine, inf),
		\iamp, Pseg(Pseq([0.01, 0.3, 0.01]), Pseq([5, 5]), \sine, inf),
		\delta, 0.1
	)
);

)

Pdef('xfrm').play

Pdef('xfrm').clear




~args1 = [ \wrp, 0.4, \freq, 1.0, \wsize, 0.1, \dens, 4, \randr, 0.01, \room, 300,
 	\rtime, 6, \ramp, 0.2, \damp, 0.3, \iamp, 0.1, \buf, ~bufs['b2']];


~ind1 = 56

~player.procplay(~ind1, 0.0, 'press', 0, ~defwrp, ~args1)

~player.set(~ind1, 0.3)

~player.free(~ind1)

~player.synths[~ind1].proc.set('wrp', 0.4, 'freq', 1.0, 'iamp', 0.1)



~args1 = [ \wrp, 0.4, \freq, 1.0, \wsize, 0.1, \dens, 4, \randr, 0.01, \room, 300,
 	\rtime, 6, \ramp, 0.2, \damp, 0.3, \iamp, 0.1, \buf, ~bufs['b6']];


~ind1 = 69

~player.procplay(~ind1, 0.0, 'press', 0, ~defwrp, ~args1)

~player.set(~ind1, 0.01)

~player.free(~ind1)

~player.synths[~ind1].proc.set('wrp', 0.2, 'freq', 1.0, 'iamp', 0.0)


s.scope

MasterEQ(4)

s.queryAllNodes

s.sendMsg("/n_free", 1007)


~player.synths[16].set('iamp', 0.3, 'ramp', 0.1)


~amp = 0.1

(
Tdef('playSynths', {
	~player.defnames.do({|name, i|
		i.postln;
		~player.play(i, 0, 'zoom', 0);
		1.wait;
		~player.set(i, ~amp);
		8.wait;
		~player.free(i);
		1.wait
	})
})
)

s.scope
 
 
Tdef('playSynths').play

Tdef('playSynths').stop

~indices = [16, 24, 25, 40, 42, 45, 48, 56, 61, 63, 65, 69, 70, 73, 76, 81, 101, 104, 111, 115, 119, 122, 123, 125, 126, 127, 128, 130, 143, 145, 153, 156, 157, 158, 159, 160, 164, 165, 176, 183, 186, 188, 189, 191, 192, 193, 195, 196, 206, 212, 216, 220, 221, 222, 224, 226, 234, 236, 238, 248, 253, 257, 259];

~indices.size



~indices.collect({|ind| ~player.defnames[ind] }).postcs

[
'gep_gen001_016_141002_132750', 'gep_gen001_063_141027_100718', 'gep_gen002_000_141027_103017', 'gep_gen002_031_141027_103114', 'gep_gen002_033_141027_103120', 'gep_gen002_039_141027_103131', 'gep_gen002_049_141002_140652', 'gep_gen003_006_141027_104555', 'gep_gen003_025_141002_143026', 'gep_gen003_030_141002_143032', 'gep_gen003_033_141002_143043', 'gep_gen003_053_141027_104624', 'gep_gen003_056_141027_104630', 'gep_gen004_000_141002_144447', 'gep_gen004_009_141027_150121', 'gep_gen004_038_141027_150144', 'gep_gen005_035_141002_145809', 'gep_gen005_054_141002_145825', 'gep_gen006_023_141002_152023', 'gep_gen006_038_141002_152045', 'gep_gen006_048_141002_152107', 'gep_gen006_053_141002_152129', 'gep_gen006_055_141002_152135', 'gep_gen006_060_141002_152146', 'gep_gen006_063_141002_152151', 'gep_gen007_007_141002_154238', 'gep_gen007_015_141002_154244', 'gep_gen007_026_141002_154255', 'gep_gen008_060_141002_160539', 'gep_gen009_007_141002_163403', 'gep_gen011_007_141002_171157', 'gep_gen011_049_141002_171213', 'gep_gen011_056_141002_171219', 'gep_gen012_010_141002_172746', 'gep_gen012_026_141002_172752', 'gep_gen012_053_141002_172757', 'gep_gen013_027_141002_173753', 'gep_gen013_029_141002_173758', 'gep_gen004_010_150303_091402', 'gep_gen004_022_150303_091442', 'gep_gen005_023_150305_190652', 'gep_gen005_043_150305_190703', 'gep_gen004_002_150601_102322', 'gep_gen004_011_150601_102333', 'gep_gen004_013_150601_102339', 'gep_gen004_015_150601_102344', 'gep_gen004_019_150601_102356', 'gep_gen004_025_150601_102402', 'gep_gen005_009_150601_220926', 'gep_gen005_025_150602_100148', 'gep_gen005_041_150602_100211', 'gep_gen005_013_150602_120957', 'gep_gen005_014_150602_121003', 'gep_gen005_015_150602_121008', 'gep_gen005_023_150602_121020', 'gep_gen005_002_150602_122445', 'gep_gen005_047_150602_122531', 'gep_gen005_004_150602_131537', 'gep_gen005_019_150602_131548', 'gep_gen005_046_150602_133318', 'gep_gen005_017_150602_160831', 'gep_gen005_026_150602_171104', 'gep_gen005_056_150602_171115' 
]


// time stretch tested:

[ 'gep_gen001_016_141002_132750', 'gep_gen001_063_141027_100718', 'gep_gen002_033_141027_103120', 'gep_gen002_039_141027_103131', 'gep_gen003_006_141027_104555', 'gep_gen003_025_141002_143026', 'gep_gen003_030_141002_143032', 'gep_gen003_053_141027_104624', 'gep_gen003_056_141027_104630', 'gep_gen004_000_141002_144447', 'gep_gen004_009_141027_150121', 'gep_gen004_038_141027_150144', 'gep_gen005_035_141002_145809', 'gep_gen005_054_141002_145825', 'gep_gen006_023_141002_152023', 'gep_gen006_038_141002_152045', 'gep_gen006_048_141002_152107', 'gep_gen006_053_141002_152129', 'gep_gen006_055_141002_152135', 'gep_gen006_060_141002_152146', 'gep_gen006_063_141002_152151', 'gep_gen007_007_141002_154238', 'gep_gen007_015_141002_154244', 'gep_gen007_026_141002_154255', 'gep_gen008_060_141002_160539', 'gep_gen009_007_141002_163403', 'gep_gen011_007_141002_171157', 'gep_gen011_049_141002_171213', 'gep_gen011_056_141002_171219', 'gep_gen012_010_141002_172746', 'gep_gen012_026_141002_172752', 'gep_gen012_053_141002_172757', 'gep_gen013_027_141002_173753', 'gep_gen013_029_141002_173758', 'gep_gen004_010_150303_091402', 'gep_gen004_022_150303_091442', 'gep_gen005_023_150305_190652', 'gep_gen005_043_150305_190703', 'gep_gen005_009_150606_172657', 'gep_gen005_013_150606_172708', 'gep_gen005_017_150606_172714', 'gep_gen005_023_150606_172719', 'gep_gen005_033_150606_172737', 'gep_gen004_005_150601_102327', 'gep_gen004_025_150601_102402', 'gep_gen005_020_150601_154435', 'gep_gen005_036_150601_155306', 'gep_gen005_055_150601_155311', 'gep_gen005_009_150601_220926', 'gep_gen005_048_150601_220937', 'gep_gen005_024_150602_094838', 'gep_gen005_060_150602_100222', 'gep_gen005_013_150602_120957', 'gep_gen005_015_150602_121008', 'gep_gen005_038_150602_122519', 'gep_gen005_016_150602_131543', 'gep_gen005_012_150602_133238', 'gep_gen005_024_150602_133250' ]



gep_gen007_026_141002_154255
gep_gen005_054_141002_145825
gep_gen002_059_141002_140703
gep_gen002_055_141027_103143
gep_gen001_040_141027_100701
gep_gen001_063_141027_100718
