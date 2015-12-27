{
	"views": {

		"playerDataByDefName": {
			"map": "function(doc) {
				if (doc['@type'] === 'ges:Synth') {
					emit (doc['ges:defname'], [doc['ges:parameters].literals, doc['ges:genome']]); 
				}
			}"
		},

		"docByDefName": {
			"map": "function(doc) { 
				emit (doc['ges:defname'], doc); 
			}"
		}

	}	
}