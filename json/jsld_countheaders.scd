~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_ld_00", "application")

~dict=~db.getParsed("headerByDate", "000000", "999999")

~headers = ();
~dict["rows"].do({|dict|
	var key = dict["value"].drop(1).collect({|str| str.replace($".asString, "") }).join("_").asSymbol;
	if (~headers.includesKey(key).not)
	{
		~headers.add(( key -> 1) )
	}
	{
		~headers[key] = ~headers[key] + 1
	}
})

~headers.keysValuesDo({|key, val| Post << key << ": " << val << Char.nl  })

~headers.add( ('10_4' -> 1))

~headers.includesKey('10_4')

[ 10, 4 ].join("_")

a = [[1,2]]
a.includes([1,2])

a.includesEqual([1, 2])

