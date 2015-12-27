{
	"views": {
		"argsByDefname": {
			"map": "function(doc) {
				emit(doc.defname, doc.args.literals); 
			}"
		},

		"docByHeaderAndDate": {
			"map": "function(doc) { 
				emit ([doc.headsize, doc.numgenes, doc.date], doc); 
			}"
		},

		"docByHeader": {
			"map": "function(doc) { 
				emit ([doc.headsize, doc.numgenes], doc); 
			}"
		},

		"docByDate": {
			"map": "function(doc) { 
				emit (doc.date, doc); 
			}"
		},

		"headerByDate": {
			"map": "function(doc) { 
				emit (doc.date, [doc.defname, doc.headsize, doc.numgenes]); 
			}"
		},

		"defnamesByHeader": {
			"map": "function(doc) { 
				emit (doc.headsize + doc.numgenes, doc.defname); 
			}"
		},

		"playerDataByDefName": {
			"map": "function(doc) {
				emit (doc.defname, [doc.args.literals, doc.headsize, doc.numgenes, doc.code, doc.terminals, doc.linker]);
			}"
		},

		"statsByDefName": {
			"map": "function(doc) { 
				emit (doc.defname, doc.stats); 
			}"
		},

		"docByDefName": {
			"map": "function(doc) { 
				emit (doc.defname, doc); 
			}"
		}

	}	
}