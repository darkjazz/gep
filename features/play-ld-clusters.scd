// ~start = "160801";
~start = "171201";
~loader = JsonLDLoader("ges_ld_00");
~result = ~loader.getIDsByDateRange(~start)
~defnames = ~result.collect({|thing| thing['value'].first })
~loader.loadDocumentsByDefNames(~defnames, { "Finished loading!".postln })

~defnames.size

~results = ~loader.results

~nclusters = ~results.size.sqrt.asInt + 1;

~kmeans = KMeans(~nclusters)

~coefs = ~results.collect({|event| event['stats']['ges:mfcc']['ges:mean'] ++ event['stats']['ges:mfcc']['ges:std_dev'] })

~coefs.do({|coef|
	~kmeans.add(coef)
})

~kmeans.update

~assignments = ~coefs.collect({|coef|
	(cluster: ~kmeans.classify(coef), distance: 0);
})

~nearest = ();
~clusters = ();
~nclusters.do({|num|
	~clusters[num] = []
});

~cosineSimilarity = {|arrA, arrB|
	(arrA*arrB).sum / (arrA.squared.sum.sqrt * arrB.squared.sum.sqrt)
}



(
~assignments.keysValuesDo({|key, val|
	var sim = ~cosineSimilarity.(~coefs[key], ~kmeans.centroids[val['cluster']]);
	val['distance'] = sim;
	~clusters[val['cluster']] = ~clusters[val['cluster']].add( (name: key, distance: sim) );
	if (~nearest.includesKey(val)) {
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
)

~clusters.keysValuesDo({|key, val|
	val.sort({|a, b| a['distance'] > b['distance'] })
})

~clusterDistances =  ()


(
~kmeans.centroids.do({|centA, i|
	~clusterDistances[i] = [];
	~kmeans.centroids.collect({|centB, j|
		~clusterDistances[i] = ~clusterDistances[i].add(
			('cluster': j, 'distance': ~cosineSimilarity.(centA, centB))
		)
	});
	~clusterDistances[i].sort({|a, b| a['distance'] > b['distance'] })
});
~clusterDistances = ~clusterDistances.collect(_.drop(1)).collect()
)

(
~removeCluster = {|cluster|
	~clusterDistances.keysValuesDo({|key, array|
		~clusterDistances[key] = ~clusterDistances[key].takeThese({|distance|
			distance['cluster'] == cluster
		})
	})
}
)

(
~current = 18;
~nclusters.do({
	var next = ~clusterDistances.first['cluster'];
	~removeCluster.(~current);
	~clusterDistances[~current];
	~current = next;
})
)

~clusterDistances.keysValuesDo({|key, val| Post << key << ": " << val << Char.nl })
~removeCluster.(18)

(
~meanCentroid = ~kmeans.centroids.flop.sum / ~kmeans.centroids.size;
~nearestCluster = 0;
~cossim = 0;
~kmeans.centroids.do({|centroid, i|
	var cossim;
	cossim = ~cosineSimilarity.(centroid, ~meanCentroid);
	if (cossim > ~cossim) {
		~nearestCluster = i;
		~cossim = cossim;
	}
})
)

~nearestCluster
~cossim


prepareForRecord

~player = JGepPlayer(FoaDecoder(decoderType: 'stereo'), CinderApp(), "ges_ld_00")

~player.decoder.start

~player.getDefNamesByDateRange(~start)

~foa = #[zoom,push]
~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)

~player.defnames.do({|name, i|
	{
		~player.loadData(i)
	}.try({
		Post << "No data for " << i << ": " << name << Char.nl
	})
})


~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, ~player.decoder.numChannels);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~player.decoder.synth, nil, \addAfter)

~rev.free

~rev.set('revamp', 0.1, 'revtime', 1.9, 'dry', 1.0)

s.record;



(
Tdef('playClusters', {
	~clusters.keysValuesDo({|key, array|
		Post << "Starting cluster " << key << Char.nl;
		array.do({|synth|
			var index = ~player.defnames.indexOf(synth['name']);
			if (~player.data[index].notNil) {
				Post << synth['name'] << ": " << synth['distance'] << Char.nl;
				~player.play(index, index, ['zoom', 'push'].choose, 0.25pi.rand);
				0.4.wait;
				~player.set(index, 0.5);
				rrand(2.0, 4.0).round(0.125).wait;
				SystemClock.sched(0.4, {~player.free(index);nil})
			}
		})
	})
}).play
)

~clusters.keys(Array)

~clusters.collect(_.size).do(_.postln)

Tdef('playClusters').stop



~assignments

s.sendMsg("/n_free", 3480)

~invAssignments = ~assignments.invert

~ind0 = ~player.defnames.indexOf(~invAssignments[0])

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.5)

~player.free(~ind0)

s.queryAllNodes

s.scope(2)


Server.killAll


~reducedMeans = KMeans(~nclusters);

~coefs.do({|coef|
	~reducedMeans.add(coef.keep(2))
})

~reducedMeans.update


~limits = ('dim0': ('lo': 1.0, 'hi': 0.0), 'dim1': ('lo': 1.0, 'hi': 0.0));

(
~coefs.do({|coef|
	var min, max;
	min = coef[0];
	max = coef[0];
	if (min < ~limits.dim0.lo) { ~limits.dim0.lo = min };
	if (max > ~limits.dim0.hi) { ~limits.dim0.hi = max };
	min = coef[1];
	max = coef[1];
	if (min < ~limits.dim1.lo) { ~limits.dim1.lo = min };
	if (max > ~limits.dim1.hi) { ~limits.dim1.hi = max };
});
)

~index = ~player.defnames.indexOf('gep_gen002_027_160902_165949')
~player.free(~index)


(
~playCluster = {|cluster|
	Tdef('play', {
		~clusters[cluster].do({|synth|
			var index = ~player.defnames.indexOf(synth['name']);
			if (~player.data[index].notNil) {
				Post << synth['name'] << ": " << synth['distance'] << Char.nl;
				~player.play(index, index, ['zoom', 'push'].choose, 0.25pi.rand);
				0.4.wait;
				~player.set(index, 0.5);
				rrand(2.0, 4.0).round(0.125).wait;
				SystemClock.sched(0.4, {~player.free(index);nil})
			}
		});
		AppClock.sched(0.5, { ~btn.value = 0 })
	}).play;
};
~stopCluster = {
	Tdef('play').clear;
	~player.synths.keys(Array).do({|index|
		~player.free(index)
	})
}
)

~clusterColors = ~nclusters.collect({|cluster|
	Color.hsv(  0.999 / ~nclusters * cluster, rrand(0.7, 1.0), rrand(0.7, 1.0) )
})

(
~size = 650;
~win = Window("..kmeans..", Rect(100, 100, ~size, ~size)).front;
~win.view.background_(Color.grey(0.2));
~mnu = PopUpMenu(~win, Rect(10, 10, 75, 20));
~mnu.items_(["all - " ++ ~defnames.size.asString] ++ (0..~nclusters-1).collect({|cluster|
	cluster.asString ++ " - " ++ ~clusters[cluster].size.asString
}));
~mnu.action_({|menu|
	~win.refresh
});
~btn = Button(~win, Rect(90, 10, 50, 20));
~btn.states_([[">", Color.black, Color.grey],["[]", Color.black, Color.green]]);
~btn.action = {|btn|
	if (btn.value == 1) {
		~playCluster.(~mnu.value - 1)
	}
	{
		~stopCluster.();
	}
};
~mnu.font_(Font("Helvetica", 8));
~win.drawFunc = {
	~coefs.keysValuesDo({|key, coef|
		var color, cluster = ~assignments[key]['cluster'];
		color = ~clusterColors[cluster];
		if ((~mnu.value != 0).and(~mnu.value - 1 != cluster)) {
			color.alpha = 0.1;
		} {
			color.alpha = 1.0;
		};
		color.set;
		Pen.fillOval(Rect(
			coef[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * (~size-10),
			coef[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * (~size-10),
			5, 5
		));
	});

	~kmeans.centroids.do({|cent, i|
		~clusterColors[i].set;
		Pen.fillOval(Rect(
			cent[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * (~size-10),
			cent[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * (~size-10),
			10, 10
		));
		Color.black.set;
		Pen.strokeOval(Rect(
			cent[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * (~size-10),
			cent[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * (~size-10),
			10, 10
		));
	});
}
)

s.stopRecording


~player.synths