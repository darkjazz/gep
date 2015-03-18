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

		"dataByHeaderAndDate": {
			"map": "function(doc) {
				emit([doc.headsize, doc.numgenes, doc.date], 
					{
						"code": doc.code, 
						"args": doc.args.literals, 
						"linker": doc.linker, 
						"terminals": doc.terminals,
						"numgenes": doc.numgenes, 
						"headsize": doc.headsize, 
						"time": doc.time, 
						"date": doc.date
					}
				);
			}"
		},

		"statsByHeaderAndDate": {
			"map": "function(doc) {
				emit([doc.headsize, doc.numgenes, doc.date], 
					{ 
						"code": doc.code, 
						"args": doc.args.literals, 
						"linker": doc.linker, 
						"terminals": doc.terminals,
						"numgenes": doc.numgenes, 
						"headsize": doc.headsize, 
						"time": doc.time, 
						"date": doc.date,
						"stats": doc.stats
					}
				);
			}"
		},

		"docByHeaderAndDate": {
			"map": "function(doc) {
				emit([doc.headsize, doc.numgenes, doc.date], doc);
			}"
		}
	}
}