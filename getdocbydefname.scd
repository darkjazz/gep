~loader = JsonLoader("ges_00");
~defnames = ~loader.getDefNamesByHeader(16, 1).collect({|def| def['value'] });


~doc = ~loader.getDocumentByDefName(~defnames.first)


~data.keys

~data.args.keys(Array).remove('literals').code.collect()

~data.args.extraDomains.collect({|domain|
	ControlSpec(*domain)
})

~data.stats.amp.mean.class

~data.args.keys