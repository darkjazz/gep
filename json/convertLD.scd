~reader = JsonLoader("ges_00")

~ldwriter = JsonWriter("ges_ld_00")

~ldwriter.putViewsFromFile

~defname = 'gep_gen006_044_141002_152056'

~result = ~reader.getDocumentByDefName(~defname)

~result = ~reader.getDefNamesByHeader()

~defnames = ~result.collect({|ev| ev['value'] })

~defnames.drop(~defnames.indexOf(~defname))

~defnames = ~defnames.drop(~defnames.indexOf(~defname) + 1)

Tdef('convertToLd', {
	~defnames.do({|defname|
		var data = ~reader.getDocumentByDefName(defname);
		0.5.wait;
		~ldwriter.writeSynthDef(data, data.id);
		0.5.wait;
	})
}).play


~data = ~reader.getDocumentByDefName(~defname)

~data.id


~data.methods.first.name

~ldwriter.writeSynthDef(~data, ~data.id)

~reader