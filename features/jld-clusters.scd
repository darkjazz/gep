~loader = JsonLDLoader("ges_ld_00");
~result = ~loader.getIDsByDateRange("160801", "999999")
~defnames = ~result.collect({|thing| thing['value'].first })
~loader.loadDocumentsByDefNames(~defnames, { "Finished loading!".postln })

~results = ~loader.results

~nclusters = (~results.size * 0.5).sqrt.asInt;

~kmeans = KMeans(~nclusters)

~coefs = ~results.collect({|event| event['stats']['ges:mfcc']['ges:mean'] ++ event['stats']['ges:mfcc']['ges:std_dev'] })

~coefs.do({|coef|
	~kmeans.add(coef)
})

~kmeans.update

10.do({|i|
	~kmeans.assignments.occurrencesOf(i).postln
})


~assignments = ~coefs.collect({|coef|
	~kmeans.classify(coef);
})

~nearest = ();

~cosineSimilarity = {|arrA, arrB|
	(arrA*arrB).sum / (arrA.squared.sum.sqrt * arrB.squared.sum.sqrt)
}




~assignments.keysValuesDo({|key, val|
	if (~nearest.includesKey(val)) {
		var sim = ~cosineSimilarity.(~coefs[key], ~kmeans.centroids[val]);
		Post << key << ": " << val << " -- " << sim << Char.nl;
		if (sim < ~nearest[val])
		{
			~nearest[val] = key
		}
	}
	{
		~nearest[val] = key
	}
})

~coefs[~nearest[0]]

~distanceMatrix = ~nclusters.collect({|i|
	~nclusters.collect({|j|
		abs(~coefs[~nearest[i]] - ~coefs[~nearest[j]]).sum
	})
})

~distanceMatrix.do({|arr|
	arr.do({|val|
		if (val == 0) {
			"0.000".post
		}
		{
			val.round(0.001).asString.padRight(5, "0").post
		};
		" ".post
	});
	"".postln
})

~sqdist = ~distanceMatrix.collect({|arr| arr.collect({|val| 0.5.neg * val.squared }) })

~sqdist.do({|arr|
	arr.do({|val|
		if (val == 0) {
			"-0.0000".post
		}
		{
			val.round(0.001).asString.padRight(7, "0").post
		};
		" ".post
	});
	"".postln
});

~rowm = ~sqdist.collect(_.mean);
~colm = ~sqdist.flop.collect(_.mean);
~totm = ~rowm.mean;

~intr = ~sqdist.collect({|arr, i|
	arr.collect({|val, j|
		val + ~totm - ~rowm[i] - ~colm[j]
	})
})

~intr.do({|arr|
	arr.do({|val|
		if (val == 0) {
			"0.0000".post
		}
		{
			(val.round(0.001).asString.padRight(6, "0")).post
		};
		" ".post
	});
	"".postln
});

