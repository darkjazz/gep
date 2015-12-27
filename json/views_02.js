{
	"views": {
		"argsByDefname": {
			"map": "function(doc) {
				emit(doc[\"ges:defname\"], doc[\"ges:parameters\"	][\"ges:literals\"]); 
			}"
		},

		"docByHeaderAndDate": {
			"map": "function(doc) { 
				emit ([doc[\"ges:environment\"][\"ges:headsize\"], doc[\"ges:environment\"][\"ges:numgenes\"], doc[\"ges:date\"]], doc); 
			}"
		},

		"docByHeader": {
			"map": "function(doc) { 
				emit ([doc[\"ges:environment\"][\"ges:headsize\"], doc[\"ges:environment\"][\"ges:numgenes\"]], doc); 
			}"
		},

		"docByDate": {
			"map": "function(doc) { 
				emit (doc[\"ges:date\"], doc); 
			}"
		},

		"headerByDate": {
			"map": "function(doc) { 
				emit (doc[\"ges:date\"], [doc[\"ges:defname\"], doc[\"ges:environment\"][\"ges:headsize\"], doc[\"ges:environment\"][\"ges:numgenes\"]]); 
			}"
		},

		"defnamesByHeader": {
			"map": "function(doc) { 
				emit (doc[\"ges:environment\"][\"ges:headsize\"].toString() + doc[\"ges:environment\"][\"ges:numgenes\"].toString(), doc[\"ges:defname\"]); 
			}"
		},

		"playerDataByDefName": {
			"map": "function(doc) {
				if (doc[\"@type\"] === \"ges:Synth\") {
					emit (doc[\"ges:defname\"], [
						doc[\"ges:parameters\"][\"ges:literals\"], 
						doc[\"ges:environment\"][\"ges:headsize\"],
						doc[\"ges:environment\"][\"ges:numgenes\"],
						doc[\"ges:genome\"],
						doc[\"ges:environment\"][\"ges:terminals\"],
						doc[\"ges:environment\"][\"ges:linker\"][\"ges:name\"]
						]
					); 
				}
			}"
		},

		"featuresByDefName": {
			"map": "function(doc) { 
				if (doc[\"@type\"] === \"ges:Synth\")
				{
					emit (doc[\"ges:defname\"], doc[\"ges:features\"]);
				}
			}"
		},

		"docByDefName": {
			"map": "function(doc) { 
				emit (doc[\"ges:defname\"], doc); 
			}"
		},

		"allValidFeatures": {
			"map": "function(doc) { 
				if (doc[\"ges:features\"][\"ges:mfcc\"][\"ges:mean\"].length == 20)
				{
					emit (doc[\"ges:defname\"], doc[\"ges:features\"]);
				}
			}"
		},

	}	
}