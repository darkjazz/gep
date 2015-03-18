~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_00")


~view = "{\"views\":{\"argsByDefname\":{\"map\":\"function(doc){emit(doc.defname,doc.args.literals);}\"},\"dataByHeaderAndDate\":{\"map\":\"function(doc){emit([doc.numgenes,doc.headsize,doc.date],doc);}\"}}}";

~view = "{\"views\": {\"argsByDefname\": {\"map\": \"function(doc) {emit(doc.defname, doc.args.literals); }\"},\"docByHeaderAndDate\": {\"map\": \"function(doc) { emit ([doc.headsize, doc.numgenes, doc.date]}, { \"defname\": doc.defname }); }\"}}}"


~db.put("'" ++ ~view ++ "'", "_design/application")

~db.get("argsByDefname")

~db.get("argsByDefname?key=%22gep_gen008_060_141107_145000%22")

~db.get("argsByDefname?key=%22gep_gen008_060_141107_145000%22")


~db.get("docByHeaderAndDate?startkey=[\"12\",\"3\",\"141105\"]&endkey=[\"12\",\"3\",\"141106\"]")

// FUNCTIONAL!!!!
~str = ~db.get("headerByDate?key=\"141106\"")



~str = ~str.subStr((~str.find("\"rows\":")+10),~str.size-6) ++ ",,"

~ids = ~str.split(Char.nl)

~ids.first

~ids.first.replace("{", "(").replace("}", ")").replace("\"", "'").keep(~ids.first.size-2).postcs

~headers = ~ids.collect({|str| 
	str.replace("{", "(").replace("}", ")").replace("\"", "'")
		.keep(str.size-2).replace("\\", "")
})


~headers.first.keys(Array).first == "key"

~headers.first.keys.do(_.postcs)

~ev = ~headers.first


~ev.collect({|it| it })

a = ("a": 2)

a.at("a".asSymbol)

Event

"\"value\"".interpret

a=("a": 1)

a[a.keys(Array).first]

~arr = ~str.split(Char.nl)

~arr[2]

~db.encodeURI("docByDate?key=\"141105\"")

// PUT VIEWS

~db.putViewsFromDoc("/Users/alo/SuperCollider/gep/json/views_00.js")

~storeView = {|path|
	var viewstr, file;
	file = File(path, "r");
	viewstr = file.readAllString;
	file.close;
	viewstr = viewstr.replace("\n", "").replace("\t", "");
	viewstr.postln;
	~db.put("'" ++ viewstr ++ "'", "_design/application");
}

~storeView.("/Users/alo/SuperCollider/gep/json/views.js")

$".ascii

(
~enc = {|request|
	var dict, ret = "";
	dict = ("\"": "%22");
	dict.keysValuesDo({|key, val|
		request = request.replace(key, val)
	});
	request
}
)
~enc.("argsByDefname?key=\"gep_gen008_060_141107_145000\"")

["\""].includes2("\"")

a = ("\"": "%22")

a.keys(Array).first.class

UGepLoader

"abc\"hsgd".replace("\"", "%22")


GepPlayer



~loader = JsonLoader("ges_dev")

~defs = ~loader.getIDsByDate("141106")

~defs = ~loader.getIDsByDateRange("141105", "141106")

~defs.size

~defs.first['value'].first

504fdbea746aaa7f832b6b5271c0444d


~rsp = ~db.get("playerDataByDefName?key=\"#\"".replace("#", "gep_gen001_000_141106_151317"))

~rsp = ~db.get("playerDataByDefName?key=\"#\"".replace("#", "gep_gen001_002_141106_151322"))


~data = ~rsp.subStr((~rsp.find("\"value\":")+8), ~rsp.size - 7)
	.replace("\"", "'").replace("\n", "").interpret




~data[3].collect({|it| 
	if (it.asString.size == 1) {it.asSymbol} { it.asString.interpret }  
})



~ids = ~loader.getIDsByDate("141106");

~ids.collect({|it| it['value'].first })

AbstractFunction.methods.select({|method| method.name == ~data[5] })

AbstractFunction.methods.collect(_.name).do(_.postln)


~decoder = FoaDecoder(decoderType:'stereo');

~loader = JsonLoader("ges_00");

~loader.getPlayerDataByDefName('gep_gen001_022_141106_151339')

~loader.loadPlayerDataByDate("141106", ~data)


~defs = ~loader.getDefNamesByHeader(14, 4)

~defs.last

~db.get("defnamesByHeader?key=\"144\"")

