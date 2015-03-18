~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_00")


~db.get("defname?key=\"gep_gen000_001_141105_185336\"")


~db.put("'{\"test\":\"json\"}'")

~db.info

~db.allDbs

~guid = ~db.requestGuid

// write GES json

~data = UGepLoader(12, 3).load

~data.size


~data.first.defname
~templ = ~data.first.keys(Array)
~templargs = ~data.first.args.keys(Array)
~templstats = ~data.first.stats.keys(Array)
~templdata = ~data.first.data.keys(Array)
~templheader = ~data.first.data.header.keys(Array)

~stats = ~data.first.stats

~args = ~converter.lib.first.args
~args.keys

~args.extraDomains.flat

~stats.flat
~stats.cent
~stats.amp
~stats.mfcc.collect(_.mean)

~data.first.data.methods.collect(_.name)

~diff = ~data.select({|data|
	data.data.keys(Array) != ~templdata
})

~diff.size

~data.first.data.code.first.name

~str = ~buildJson.(~data.first)

~data.first.defname.drop(15)

~str.postcs


~converter = GepDataJsonConverter(
	CouchDB(NetAddr("127.0.0.1", 5984), "ges_00"), 
	UGepLoader()
)


~json = ~converter.build(~converter.lib[1])

~converter.db.put("'" ++ ~json ++ "'")

~converter.convert

~converter.lib[1]



// dev
~converter = GepDataJsonConverter(
	CouchDB(NetAddr("127.0.0.1", 5984), "ges_dev"), 
	UGepLoader(12, 3)
)


~converter.convert
