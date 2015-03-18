~loader = UGepLoader(12, 3).loadByDate(from:"141001")

~loader.size

~data = ~loader

~data.size

~decoder = FoaDecoder(decoderType: 'stereo');
~player = GepPlayer(~data, ~decoder, ~graphics);

~decoder.start

~player.setBPM(140);

~player.start(~foa)

~player.setFoa('zoom', 0.5);
~player.setFoa('focus', 0.5)


// 3, 11, 18, 20

// 22, 27, 28, 29, 33, 36

// 38, 46 // 61, 75 // 46, 93

~ind0 = 46


~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.2)

~player.free(~ind0)


s.queryAllNodes




// headsize = 12, numgenes = 3

// 0

~ind0 = 0


~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.5)

~player.free(~ind0)

