from ontogen import *

ontogen = OntoGen("http://geen.tehis.net/ontology/", "ges")
ontogen.addNamespace("xsd", "http://www.w3.org/2001/XMLSchema#")
ontogen.addNamespace("afo", "http://sovarr.c4dm.eecs.qmul.ac.uk/af/ontology/1.0#")
ontogen.addNamespace("afv", "http://sovarr.c4dm.eecs.qmul.ac.uk/af/vocabulary/1.0#")

ontogen.writeHeader(
 	"Gene expression synthesis ontology", 
 	"Ontology for gene expression synthesis, an evolutionary algorithm for sound synthesis",
 	"0.4"
)

ontogen.addOwlClass("Context", "context of the gene expression synthesis environment")
ontogen.addOwlObjectProperty("system", ("ges", "Context"), ("ges", "System"))

ontogen.addOwlClass("System", "operating system")
ontogen.addOwlObjectProperty("type", ("ges", "System"), ("ges", "SystemType"))
ontogen.addOwlObjectProperty("os_name", ("ges", "System"), ("xsd", "string"))
ontogen.addOwlObjectProperty("version", ("ges", "System"), ("xsd", "string"))

ontogen.addIndividual(("ges", "sysMac"), ("ges", "SystemType"))
ontogen.addIndividual(("ges", "sysLinux"), ("ges", "SystemType"))
ontogen.addIndividual(("ges", "sysWin"), ("ges", "SystemType"))

ontogen.addOwlClass("Environment", "a GES environment")
ontogen.addOwlObjectProperty("methods", ("ges", "Environment"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("terminals", ("ges", "Environment"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("linker", ("ges", "Environment"), ("ges", "Function"))
ontogen.addOwlObjectProperty("head_size", ("ges", "Environment"), ("xsd", "integer"))
ontogen.addOwlObjectProperty("number_of_genes", ("ges", "Environment"), ("xsd", "integer"))
ontogen.addOwlObjectProperty("context", ("ges", "Environment"), ("ges", "Context"))

ontogen.addOwlClass("Function", "a SuperCollider function")
ontogen.addOwlObjectProperty("name", ("ges", "Function"), ("xsd", "string"))
ontogen.addOwlObjectProperty("class", ("ges", "Function"), ("xsd", "string"))

ontogen.addOwlClass("Synth", "a GES synth")
ontogen.addOwlObjectProperty("guid", ("ges", "Synth"), ("xsd", "string"))
ontogen.addOwlObjectProperty("date", ("ges", "Synth"), ("dc", "date"))
ontogen.addOwlObjectProperty("defname", ("ges", "Synth"), ("xsd", "string"))
ontogen.addOwlObjectProperty("genome", ("ges", "Synth"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("generation", ("ges", "Synth"), ("xsd", "integer"))
ontogen.addOwlObjectProperty("features", ("ges", "Synth"), ("rdf", "Dictionary"))
ontogen.addOwlObjectProperty("arguments", ("ges", "Synth"), ("ges", "Arguments"))
ontogen.addOwlObjectProperty("environment", ("ges", "Synth"), ("ges", "Environment"))

ontogen.addOwlClass("Parameters", "GES synth parameters")
ontogen.addOwlObjectProperty("literals", ("ges", "Parameters"), ("rdf", "Dictionary"))
ontogen.addOwlObjectProperty("genome", ("ges", "Parameters"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("constants", ("ges", "Parameters"), ("rdf", "Seq"))
ontogen.addOwlObjectProperty("extra_domains", ("ges", "Parameters"), ("rdf", "Seq"))

ontogen.addOwlClass("ControlSpec", "a GES synth argument control spec")
ontogen.addOwlObjectProperty("minimum_value", ("ges", "ControlSpec"), ("xsd", "float"))
ontogen.addOwlObjectProperty("maximum_value", ("ges", "ControlSpec"), ("xsd", "float"))
ontogen.addOwlObjectProperty("warp", ("ges", "ControlSpec"), ("xsd", "string"))

ontogen.addOwlObjectProperty("centroid", ("afo", "AudioFeature"), ("afv", "SpectralCentroid"))
ontogen.addOwlObjectProperty("mfcc", ("afo", "AudioFeature"), ("afv", "MelscaleFrequencyCepstralCoefficients"))
ontogen.addOwlObjectProperty("amplitude", ("afo", "AudioFeature"), ("afv", "Amplitude"))
ontogen.addOwlObjectProperty("flatness", ("afo", "AudioFeature"), ("afv", "SpectralFlatness"))
ontogen.addOwlObjectProperty("error", ("afo", "AudioFeature"), ("ges", "Error"))

ontogen.addOwlObjectProperty("number_of_coefficients", ("afv", "MelscaleFrequencyCepstralCoefficients"), ("xsd", "integer"))
ontogen.addOwlObjectProperty("number_of_frames", ("afv", "MelscaleFrequencyCepstralCoefficients"), ("xsd", "integer"))

ontogen.addOwlObjectProperty("mean", ("afo", "AudioFeature"), ("afv", "Mean"))
ontogen.addOwlObjectProperty("std_dev", ("afo", "AudioFeature"), ("afv", "StandardDeviation"))

ontogen.serialize("/Users/alo/dev/gep/ontology/", "gesonto")
