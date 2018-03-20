~loader = JsonLDLoader("ges_ld_00")

~features = ~loader.db.getParsed("allValidFeatures")

~nclusters = (~features["rows"].size * 0.5).sqrt.asInt;

~kmeans = KMeans(~nclusters)

~features["rows"].first["value"]["ges:mfcc"]["ges:std_dev"]

~coefs = ~features["rows"].collect({|row|
	row["value"]["ges:mfcc"]["ges:mean"].collect(_.asFloat)
	++ row["value"]["ges:mfcc"]["ges:std_dev"].collect(_.asFloat)
})

~coefs.do({|coef|
	~kmeans.add(coef.keep(2))
})

~kmeans.update

~features.rows[~clusterIndices.first].key

~findNearestInCluster = {|index|
	var data, centroid, mindiff, closest = 0, clusterIndices;
	centroid = ~kmeans.centroids[index];
	data = ~kmeans.assignments.selectIndices({|it| it == index }).collect({|ind|
		~kmeans.data[ind]
	});
	clusterIndices = ~kmeans.assignments.selectIndices({|it| it == index });
	mindiff = centroid.mean;
	data.do({|vec, i|
		var diff;
		diff = (vec - centroid).abs.mean;
		if (diff < mindiff) {
			closest = i;
			mindiff = diff
		}
	});
	clusterIndices[closest].postln;
	~features.rows[clusterIndices[closest]].key;
}

~findNearestInCluster.(19)

~defnames = ~nclusters.collect({|num|
	~findNearestInCluster.(num)
})

Atk

~decoder = FoaDecoder(decoderType: 'stereo')

~player = JGepPlayer(~decoder, dbname: "ges_ld_00")
