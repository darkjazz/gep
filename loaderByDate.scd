~loader = UGepLoader().loadByDate(from:"141001")

~loader.size

~data = ~loader

~chr = ~data.first

~chr.args.keys
 

~data = ~loader.select({|data| 
	(data.data.header.numgenes == 4).and(data.data.header.headsize == 14)
})

~data.size

~decoder = FoaDecoder(decoderType: 'stereo');
~foa = #[zoom,push];
~player = GepPlayer(~data, ~decoder, ~graphics);

~decoder.start

~player.setBPM(140);

~player.start(~foa)

~player.setFoa('zoom', 1.0);
~player.setFoa('push', 1.0)


// 3, 11, 18, 20

// 22, 27, 28, 29, 33, 36

~ind0 = 55


~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.2)

~player.free(~ind0)


s.queryAllNodes


~data[[3, 11, 18, 20]].collect(_.defname)


~data = UGepLoader().loadNames(#[ 
	gep_gen001_016_141002_132750, 
	gep_gen002_048_141002_140646, 
	gep_gen003_014_141002_143021, 
	gep_gen003_030_141002_143032 
])

