(
~ev = EvolverEnvir(
	(
		populationSize: 37, numgenes: 3, headsize: 31, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 0.25, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.2, geneTranspositionRate: 0.2,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 11, recordPath: "/Users/alo/snd/evolver/"
	)
);

~ugens = [ SinOsc, Saw, LFSaw, VarSaw, LFTri, Pulse, LFPulse, LFNoise0, LFPar, Logist0, LFNoise1, LFNoise2, Formant, Blip, PMOsc, SyncSaw, Dust2 ];

~ev.initializeRandomDbPopulation;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/alo/snd/gep/gepsynth06.aif")
)

~ugens.includes(Resonz)


https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1

~cmd = "curl --location --request POST 'https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1/action/find' " ++
"--header 'Content-Type: application/json' " ++
"--header 'Access-Control-Request-Headers: *' " ++
"--header 'api-key: 629b75295ca69874e5e18f3d' ";

~query = "{\"collection\":\"ges_ld_00\", \"database\":\"gep\", \"dataSource\":\"gep\", \"filter\": {\"ges:defname\": \"gep_gen000_226_180413_172621\"}}";

~query = ("collection": "ges_ld_00", "database": "gep", "dataSource": "gep")
~query["projection"] = ("ges:environment.ges:headsize": 1, "ges:environment.ges:numgenes": 1, "ges:defname")

~query["filter"] = ("ges:defname": "gep_gen000_226_180413_172621")

~query["filter"] = ("ges:date": ("$gte": "231101", "$lte": "231201"))
~query["limit"] = 37


curl --location --request POST 'https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1/action/find' --header 'Content-Type: application/json' --header 'Access-Control-Request-Headers: *' --header 'api-key: 629b75295ca69874e5e18f3d' --data-raw '{ "collection": "ges_ld_00", "dataSource": "gep", "database": "ges", "filter": { "ges:date": { "$gte": "231101", "$lte": "231201" } }, "limit": 37 }'

curl --location --request POST 'https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1/action/find' --header 'Content-Type: application/json' --header 'Access-Control-Request-Headers: *' --header 'api-key: 629b75295ca69874e5e18f3d' --data-raw '{ "collection": "ges_ld_00", "dataSource": "gep", "database": "gep", "filter": { "ges:date": { "$gte": "231101", "$lte": "231201" } }, "limit": 37 }'



~query.asJSON

.escapeChar($")


~cmd = ~cmd ++ "--data-raw '%'".format(~query.asJSON);

~cmd

~cmd
~query


~re = ~cmd.unixCmdGetStdOut

~re =~re.replace(Char.nl.asString)

~re.size

~docs = ~re.parseJSON

~docs["documents"].size

~db = MongoDb()

~docs = ~db.getDefnames(headsize: 31, numgenes: 3);

~data = ~db.getDocuments("231101", "231201", limit: 128)

~data = ~db.getDocuments(headsize: 57, numgenes: 3, limit: 7)

~data.first.args[1]

~data.collect({|dt| dt.code.first })

UGEP

~trm.maxItem

~data.first.linker

~docs.size

~doc.size = ~docs

~doc = ~docs.first
~data = ~db.unpack(~docs.first)

~doc["ges:parameters"]["ges:constants"]
~doc["ges:environment"]["ges:numgenes"].asInteger

~doc["ges:genome"].collect({|it|
	if (it.asString.size == 1) { it.asSymbol } { it.asString.interpret }
});

AbstractFunction.methods.select({|method|
			method.name == ~doc["ges:environment"]["ges:linker"]["ges:name"].asSymbol
		}).first;

~methods = ~doc["ges:environment"]["ges:methods"].collect(_.asString).collect(_.interpret);

~operators = ['*', '/', '+', '-'];
~doc["ges:parameters"]["ges:genome"].collect({|it|
	if (~operators.includes(it.asSymbol)) {
		AbstractFunction.methods.select({|method| method.name.asSymbol == it.asSymbol }).first
	} { it.asSymbol }
});

~doc["ges:parameters"]["ges:extra_domains"].collect({|ev|
	ControlSpec(ev["ges:minimum_value"], ev["ges:maximum_value"], ev["ges:warp"].asSymbol)
});

~re = ~db.getDocumentByDefname("gep_gen005_258_220507_022153")

~re = ~db.getDocumentsByDate("231101", "231201", 37)

~re.parseJSON

~query.class

~res = ~query.unixCmdGetStdOut

curl --location --request POST 'https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1/action/find' --header 'Content-Type: application/json' --header 'Access-Control-Request-Headers: *' --header 'api-key: 629b75295ca69874e5e18f3d' --data-raw '{ "collection": "ges_ld_00", "dataSource": "gep", "database": "gep", "filter": { "ges:date": { "$gte": "231101", "$lte": "231201" } }, "limit": 37 }'

{ "ges:environment.ges:headsize": 31, "ges:environment.ges:numgenes": 3 }, "projection": { "ges:defname": 1 } }

(
~cmd = "curl --location --request POST 'https://data.mongodb-api.com/app/data-zolcv/endpoint/data/v1/action/find' " ++
"--header 'Content-Type: application/json' " ++
"--header 'Access-Control-Request-Headers: *' " ++
"--header 'api-key: 629b75295ca69874e5e18f3d' ";
~query = ("collection": "ges_ld_00", "database": "gep", "dataSource": "gep");
~query["filter"] = ("ges:environment.ges:headsize": 31, "ges:environment.ges:numgenes": 3); //("ges:date": ("$gte": "231101", "$lte": "231201"));
~query["projection"] = ("ges:defname": 1);
// ~query["limit"] = 37;
~cmd = ~cmd ++ "--data-raw '%'".format(~query.asJSON);
~re = ~cmd.unixCmdGetStdOut;
~defnames = ~re.replace(Char.nl.asString).parseJSON["documents"];
~defnames.size.postln;
~docs = [];
30.do({|i|
	var doc, defname = ~defnames.choose["ges:defname"];
	defname.postln;
	doc = ~db.getDocumentByDefname(defname);
})
)