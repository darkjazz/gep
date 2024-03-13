~buffers = "/Users/alo/snd/evolver_to_convert/*".pathMatch.collect({|path|
	Buffer.readChannel(s, path, channels: [0, 1])
});

Tdef('write', {
	~buffers.do({|buf|
		var path = buf.path.replace("_to_convert", "/sinosc");
		buf.write(path);
		s.sync;
		Post << path << Char.nl;
	})
}).play


x = { LFPulse.ar(31) * 0.1 }.play

x.free
