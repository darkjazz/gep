~loader = UGepLoader().loadNames(['gep_gen000_002_141027_092507'])

~chr = ~loader.first

~chr.args.constants
~chr.args.code.collect({|codon| 
	if (codon.isKindOf(Method)) { codon.name } { codon }  
}).postcs

.do(_.postln)

~chr.args.extraDomains.do({|spec|  
	#[unipolar, bipolar, freq, lofreq, midfreq, widefreq][~maps.indexOf(spec)].postln
})



~chr.args.args

#[unipolar, bipolar, freq, lofreq, midfreq, widefreq].collect({|name|
	name.post; " -> ".post; ControlSpec.specs[name].postln
});

#[unipolar, bipolar, freq, lofreq, midfreq, widefreq].
~maps.do(_.postln)


//individual ugens as owl classes, subclassed from ugen
~rdfstr = "";

~chr.data.methods.do({|method|
	~rdfstr = ~rdfstr ++ "sc:" ++ method.name ++ " a owl:Class ;\n";
	~rdfstr = ~rdfstr ++ "\t" ++ "rdfs:subClassOf ges:UGen ;\n";
	~rdfstr = ~rdfstr ++ "\tges:name \"" ++ method.name ++ "\" ;\n";
	~rdfstr = ~rdfstr ++ "\tvs:term_status \"testing\"@en . \n\n";
})

~rdfstr


//ugens typed as owl ugens
~rdfstr = "";

~chr.data.methods.do({|method|
	~rdfstr = ~rdfstr ++ "sc:" ++ method.name ++ " a ges:UGen ;\n";
	~rdfstr = ~rdfstr ++ "\tges:name \"" ++ method.name ++ "\" ;\n";
	~rdfstr = ~rdfstr ++ "\tvs:term_status \"testing\"@en . \n\n";
})

~rdfstr

// control specs as owl objects

~rdfstr = "";

#[unipolar, bipolar, freq, lofreq, midfreq, widefreq].do({|name|
	~rdfstr = ~rdfstr ++ "sc:" ++ name ++ "Spec a ges:ControlSpec ;\n";
	~rdfstr = ~rdfstr ++ "\tges:name \"" ++ name ++ "\" ;\n";
	~rdfstr = ~rdfstr ++ "\tvs:term_status \"testing\"@en . \n\n";	
});
