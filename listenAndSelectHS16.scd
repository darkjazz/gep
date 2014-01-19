(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });
~data = ~meta.collect({|meta|
	var data, path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { 
		data = UGEP.loadData(path) 
	};
	data['defname'] = meta.defname;
	data['args'] = meta.args.args;
	data
});
~inds = ~data.selectIndices({|data| data.header.headsize == ~headsize  });
~meta = ~inds.collect({|index| ~meta[index] });
~data = ~inds.collect({|index| ~data[index] });
~list = ~data.collect(_.code);
)

/*
~defstr = ~data.collect({|data|  
	var chrom, defstr;
	chrom = GEPChromosome(data.code, data.terminals, 
			data.header.numgenes, data.linker);
	defstr = chrom.asUgenExpressionTree.asSynthDefString(data.defname, Pan2, Normalizer);
})

~defstr.collect(_.size).maxItem

~meta.do({|data|
	data.args.extraDomains.postln
})
*/

~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp();

~graphics.open

~graphics.sendCodeTitle("lambda.code")

~decoder.start

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.3);


~player = GepPlayer(~data, ~decoder, ~graphics)

~player.start(#[zoom,focus,push,press])

s.record

s.stopRecording

// zoom 0 //
~ind0 = 26

~player.play(~ind0, 'zoom')

~player.setFoa('zoom', 0.6)

~player.free(~ind0)


// focus 1 //

~ind1 = 6

~player.play(~ind1, 'focus')

~player.setFoa('focus', 0.8)

~player.free(~ind1)


// push 2 //

~ind2 = 7

~player.play(~ind2, 'push')

~player.setFoa('push', 1.0)

~player.free(~ind2)



// press 3 //

~ind3 = 28

~player.play(~ind3, 'press')

~player.setFoa('press', 1.0)

~player.free(~ind3)


~decoder.free

Server.default.queryAllNodes

s.sendMsg("/n_free", 1033)

//Document.themes.put(\livecode,
//Ê Ê (
//Ê Ê Ê Ê classColor: Color.new255(53, 74, 187),
//Ê Ê Ê Ê textColor: Color.new255(200, 200, 200),
//Ê Ê Ê Ê stringColor: Color.new255(96, 129, 158),
//Ê Ê Ê Ê commentColor: Color.new255(206, 27, 28),
//Ê Ê Ê Ê symbolColor: Color.new255(57, 154, 20),
//Ê Ê Ê Ê numberColor: Color.new255(157, 80, 65)
//Ê Ê )
//);
//Document.setTheme(\default)
~doc = Document()
~doc.background_(Color.grey(0.0, 0.8))
~doc.stringColor_(Color.grey(0.9))
~doc.prSetBounds(Rect(0, 0, 800, 600))
~doc.front



~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.3);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 1, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);


~graphics.setPattern(18, 0, 1.0, 1, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(19, 0, 1.0, 1, 0, 0.5, 0.75, 0.9);

~graphics.setPattern(20, 1, 1.0, 0, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.5, 0.5, 0.5);

~graphics.setPattern(22, 0, 1.0, 1, 1, 0.9, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.7, 0.9, 1.0);

~graphics.setPattern(24, 0, 0.1, 0, 0, 0.3, 1.0, 0.8);

~graphics.setPattern(25, 0, 0.1, 0, 0, 0.6, 0.7, 0.9);


~graphics.activateSwarm(16, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);

~graphics.sendBoidPattern(4, 1, 4);

~graphics.setViewpoint(50.0,50.0,50.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.8, 50.0, 8.0, 15.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(false, false)


~rot = Rotation(140.0, 0.03, 80.0, 60.0, 0.0, 0.061, 0.0, 0.04);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~graphics.mapCodePanel

~graphics.setFrameRate(24.0)
