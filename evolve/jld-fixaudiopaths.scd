/// fix audio paths

~start = "160801";
~loader = JsonLDLoader("ges_ld_00");
~result = ~loader.getIDsByDateRange(~start);
~defnames = ~result.collect({|thing| thing['value'].first }).collect(_.asString);

~audiopaths = "/Users/alo/snd/evolver/gep_gen*".pathMatch.collect({
	|path| path.split($/).last.split($.).first
}).select({|name|
	var date = name.split($_)[3];
	date.find("1609").notNil.or(date.find("1608").notNil)
});


~defnames.size
~audiopaths.do({|defname|
	var arr, new, findstr = defname[(0..25)];
	arr = ~defnames.select({|defname| defname[(0..25)] == findstr  });
	if (arr.size == 1)
	{
		Post << defname << "    |    " << arr.first << Char.nl
		// "mv /Users/alo/snd/evolver/%.aiff /Users/alo/snd/evolver/%.aiff".format(defname, arr.first).unixCmd;

	}
})

"".format

~merged.size

~merged.sort

~merged.do(_.postln)

