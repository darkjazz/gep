~start = "160801";
~player = JGepPlayer(FoaDecoder(decoderType:'stereo'), CinderApp(), "ges_ld_00");

~player.getDefNamesByDateRange(~start)

~player.decoder.start

~player.start

~player.setFoa('zoom', 1.0)
~player.setFoa('focus', 1.0)


~idx = 3;
~player.play(~idx)
~player.set(~idx, 0.3)
~player.free(~idx)

~player.defnames[~idx]

