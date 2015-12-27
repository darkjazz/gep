~decoder = FoaDecoder(decoderType: 'stereo')

~player = JGepPlayer(~decoder, dbname: "ges_00")

// if views have been updated
//~player.loader.putViewsFromFile
150601


~player.getDefNamesByDate("150601")

~player.getDefNamesByDateRange("150601", "150604")

~player.getDefNamesByHeader(12, 3)

~player.data

~player.defnames.includes('gep_gen005_056_150602_171115')

.size

~decoder.start

~foa = #[zoom,focus];


~player.start(~foa)

~player.setFoa('zoom', 1.0);
~player.setFoa('focus', 1.0)


~ind = 3;
~player.play(~ind, 0, 'zoom', 0)

~player.set(~ind, 0.2)

~player.free(~ind)


~indx = 7;
~player.play(~indx, 0, 'focus', 0)

~player.set(~indx, 0.5)

~player.free(~indx)

s.queryAllNodes


gep_gen007_026_141002_154255
gep_gen005_054_141002_145825
gep_gen002_059_141002_140703
gep_gen002_055_141027_103143
gep_gen001_040_141027_100701
gep_gen001_063_141027_100718
