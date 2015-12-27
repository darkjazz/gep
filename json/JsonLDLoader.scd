JsonLDLoader : JsonLoader {
	getDocumentByDefName{|defname|
		var result, doc, data, argchrom, operators;
		operators = ['*', '/', '+', '-'];
		result = db.get("docByDefName?key=\"#\"".replace("#", defname));
		doc = result.subStr((result.find("\"value\":") + 8), result.size - 7)
			.replace(${.asString, $(.asString).replace($}.asString, $).asString).replace("\n", "").replace("\"", "'")
			.interpret;
		data = ();
		data.id = doc['_id'];
		data.defname = doc['ges:defname'];
		data.date = doc['ges:environment']['ges:date'];
		data.time = doc['ges:environment']['ges:time'];
		data.generation = doc['ges:generation'].asInteger;
		data.headsize = doc['ges:headsize'].asInteger;
		data.numgenes = doc['ges:numgenes'].asInteger;
		data.code = doc['ges:genome'].collect({|it|
			if (it.asString.size == 1) { it.asSymbol } { it.asString.interpret }
		});
		data.linker = AbstractFunction.methods.select({|method|
			method.name == doc['ges:environment']['ges:linker']['ges:name']
		}).first;
		data.methods = doc['ges:environment']['ges:methods'].collect(_.asString).collect(_.interpret);
		data.terminals = doc['ges:environment']['ges:terminals'];
		data.stats = doc['ges:features'];
		data.args = doc['ges:parameters']['ges:literals'];
		data.params = ();
		data.params.literals = doc['ges:parameters']['ges:literals'];
		data.params.code = doc['ges:parameters']['ges:genome'].collect({|it|
			if (operators.includes(it)) {
				AbstractFunction.methods.select({|method| method.name.asSymbol == it }).first
			} { it.asSymbol }
		});
		data.params.constants = doc['ges:parameters']['ges:constants'];
		data.params.extraDomains = doc['ges:parameters']['ges:extra_domains'].collect({|domain|
			ControlSpec(*domain)
		});
		^data
	}

}