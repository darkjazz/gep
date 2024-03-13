~loader = JsonLDLoader("ges_ld_00");
~results = ();
~loadDocumentsByDefNames = {|defnamearray, doneAction|
	var current, namestream;
	namestream = Pseq(defnamearray, 1).asStream;
	current = namestream.next;
	~results[current] = ~loader.getDocumentByDefName(current.asString);
	SystemClock.sched(0.05, {
		if (~results.includesKey(current)) {
			current = namestream.next;
			if (current.notNil) { ~results[current] = ~loader.getDocumentByDefName(current.asString) };
		};
		if (current.notNil) { 0.05 } { doneAction.(); nil }
	});
}


~result = ~loader.getIDsByDateRange("160801", "999999")

~defnames = ~result.collect({|item| item['value'].first })

~results

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

~dims = ~kmeans.data.flop;
~dimvar = ~dims.collect({|dim| dim.variance })

~dimvar.indexOf(~dimvar.maxItem)

~limits = ('dim0': ('lo': 1.0, 'hi': 0.0), 'dim1': ('lo': 1.0, 'hi': 0.0));

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


(
~size = 510;
~win = Window("..kmeans..", Rect(100, 100, ~size, ~size)).front;
~win.view.background_(Color.black);
~win.drawHook = {
	~coefs.do({|coef|
		var cluster = ~kmeans.classify([coef[0], coef[1]]);
		Color.hsv(0.999 / ~nclusters * cluster, 1.0, 1.0).set;
		Pen.fillOval(Rect(
			coef[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * 500,
			coef[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * 500,
			5, 5
		));

		//Color.white.set;
		~kmeans.centroids.do({|cent, i|
			Color.hsv(0.999 / ~nclusters * i, 1.0, 1.0).set;
			Pen.strokeOval(Rect(
				cent[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * 500,
				cent[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * 500,
				10, 10
			));

		});

	})
}
)

