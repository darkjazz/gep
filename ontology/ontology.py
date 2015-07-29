from ontogen import *

ontogen = OntoGen(Namespace("http://geen.tehis.net/ontology/"), "ges")
ontogen.addNamespace("xsd", "http://www.w3.org/2001/XMLSchema#")
ontogen.addNamespace("af", "http://sovarr.c4dm.eecs.qmul.ac.uk/af/")

ontogen.writeHeader(
 	"Gene expression synthesis ontology", 
 	"Ontology for gene expression synthesis",
 	"1.0"
)

ontogen.addOwlClass("Environment", "a GES environment")
ontogen.addOwlObjectProperty("methods", ("ges", "Environment"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("terminals", ("ges", "Environment"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("linker", ("ges", "Environment"), ("xsd", "string"))
ontogen.addOwlObjectProperty("head_size", ("ges", "Environment"), ("xsd", "integer"))
ontogen.addOwlObjectProperty("number_of_genes", ("ges", "Environment"), ("xsd", "integer"))

ontogen.addOwlClass("Generation", "a GES generation")
ontogen.addOwlObjectProperty("number", ("ges", "Generation"), ("xsd", "integer"))

ontogen.addOwlClass("Synth", "a GES synth")
ontogen.addOwlObjectProperty("guid", ("ges", "Synth"), ("xsd", "string"))
ontogen.addOwlObjectProperty("date", ("ges", "Synth"), ("dc", "date"))
ontogen.addOwlObjectProperty("defname", ("ges", "Synth"), ("xsd", "string"))
ontogen.addOwlObjectProperty("genome", ("ges", "Synth"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("generation", ("ges", "Synth"), ("ges", "Generation"))
ontogen.addOwlObjectProperty("audio_features", ("ges", "Synth"), ("ges", "AudioFeature"))
ontogen.addOwlObjectProperty("arguments", ("ges", "Synth"), ("ges", "Arguments"))
ontogen.addOwlObjectProperty("environment", ("ges", "Synth"), ("ges", "Environment"))

ontogen.addOwlClass("Arguments", "GES synth arguments")
ontogen.addOwlObjectProperty("literals", ("ges", "Arguments"), ("rdf", "Dictionary"))
ontogen.addOwlObjectProperty("genome", ("ges", "Arguments"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("constants", ("ges", "Arguments"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("extra_domains", ("ges", "Arguments"), ("rdf", "Seq"))

ontogen.addOwlClass("ControlSpec", "a GES synth argument control spec")
ontogen.addOwlObjectProperty("minimum_value", ("ges", "ControlSpec"), ("xsd", "float"))
ontogen.addOwlObjectProperty("maximum_value", ("ges", "ControlSpec"), ("xsd", "float"))
ontogen.addOwlObjectProperty("warp", ("ges", "ControlSpec"), ("xsd", "string"))

ontogen.addOwlClass("AudioFeature", "GES synth audio feature", ("af", "AudioFeature"))
ontogen.addOwlObjectProperty("mean", ("ges", "AudioFeature"), ("xsd", "float"))
ontogen.addOwlObjectProperty("standard_deviation", ("ges", "AudioFeature"), ("xsd", "float"))
