~loader = JsonLDLoader("ges_ld_00")

~headers = ~loader.db.getParsed("headerByDate")

~dates = ();
~headers["rows"].do({|row|
	var gens, key;
	key = row["key"].asSymbol;
	gens = row["value"][0].split($_)[1].subStr(3).asInt;
	if (~dates.includesKey(key).not) { ~dates[key] = ('count': 0, 'gens': 0) };
	~dates[key]['count'] = ~dates[key]['count'] + 1;
	if (~dates[key]['gens'] < gens) { ~dates[key]['gens'] = gens }
})


~dates.keysValuesDo({|key, val|
	Post << key << ": " << val['count'] << ": " << val['gens'] << Char.nl
})

"gen003".subStr(3).asInt

~dates.collect(_.at('gens')).values.asArray.select({|num| num > 4 }).size