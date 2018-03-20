~player = JGepPlayer(FoaDecoder(decoderType: 'stereo'), CinderApp(), "ges_ld_00")

~player.decoder.start

~player.getDefNamesByDateRange("171201")

~foa = #[zoom]
~player.start(~foa)

~player.recordDir = "/Users/alo/snd/gestest"

~player.headerFormat = "wav"
~player.sampleFormat = "int24"

~player.setFoa('zoom', 0.3)

~player.foaSynths

~player.loadData(0)



~player.recordOne(0, 0.7, 5.0)

~player.defnames.do({|name, i|
	{
		~player.loadData(i)
	}.try({
		Post << "No data for " << i << ": " << name << Char.nl
	})
})

~player.recordAll(0.7, 3.0)
