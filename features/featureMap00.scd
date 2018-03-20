~loader = JsonLDLoader("ges_ld_00")

~features = ~loader.db.get("allValidFeatures")

~result = ~features.replace(${.asString, $(.asString).replace($}.asString, $).asString).replace("\n", "").replace("\"", "'")


~features = ~result.interpret

~features.rows.size

~nclusters = (~features.rows.size * 0.5).sqrt.asInt;

~kmeans = KMeans(~nclusters)

~features.rows.first['value'].keys

['ges:mfcc']['ges:mean']

~coefs = ~features.rows.collect({|row| row['value']['ges:mfcc']['ges:mean'] })


~coefs.do({|coef|
	~kmeans.add(coef.keep(2))
})


~kmeans.update

~kmeans.centroids.size

~nclusters.collect({|num|
	Post << num << ": " << ~kmeans.assignments.occurrencesOf(num) << Char.nl;
	~kmeans.assignments.occurrencesOf(num)
})

~clusterIndices = ~kmeans.assignments.selectIndices({|it|
	it == 0
})

~clusterIndices.first

~features.rows[~clusterIndices.first].key

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


(
~size = 510;
~win = Window("..kmeans..", Rect(100, 100, ~size, ~size)).front;
~win.view.background_(Color.white);
~win.drawHook = {
	~coefs.do({|coef|
		var cluster = ~kmeans.classify(coef.keep(2));
		Color.hsv(0.999 / ~nclusters * cluster, 1.0, 1.0).set;
		Pen.fillOval(Rect(
			coef[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * 500,
			coef[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * 500,
			5, 5
		));

		Color.white.set;
		~kmeans.centroids.do({|cent|
			Pen.strokeOval(Rect(
				cent[0].linlin(~limits.dim0.lo, ~limits.dim0.hi, 0.0, 1.0) * 500,
				cent[1].linlin(~limits.dim1.lo, ~limits.dim1.hi, 0.0, 1.0) * 500,
				10, 10
			));

		});

	})
}
)


2pi / 10 * 3

~kmeans.classify(~features.rows.first['value']['ges:mfcc']['ges:mean'])


~comp = ~coefs.flop.collect({|arr|
	arr.stdDev
})




~comp.size

~limits

~som = SOMap(1000, 100, 4, ~limits.dim1.lo, ~limits.dim0.hi)

~som.trainDuration.do({
	~som.train(~coefs.choose.keep(4))
})

Array.rand(20, ~limits.lo, ~limits.hi).linlin(~limits.lo, ~limits.hi, 0.0, 1.0)

(
~size = 5;
~win = Window("..synths..", Rect(100, 100, ~size*~som.size, ~size* ~som.size)).front;
~win.view.background_(Color.grey(0.1));
~win.drawHook = {
	~som.nodes.do({|row, x|
		row.do({|node, y|
			Color(*(node.weights.keep(3).linlin(~limits.dim1.lo, ~limits.dim0.hi, 0.0, 1.0)-0.1)).set;
			Pen.fillRect(Rect(x*~size, y*~size, ~size, ~size))
		})
	});
	~coefs.do({|coef|
		var bmu;
		bmu = ~som.findBMU(coef.keep(4));
		Color.grey(0.2, 0.8).set;
		Pen.fillOval(Rect(bmu.coords.x*~size-~size, bmu.coords.y*~size-~size, ~size*2, ~size*2));
	});

}
)

~flatcent = ~features.rows.collect({|row|
	[
		row['value']['ges:flatness']['ges:mean'],
		row['value']['ges:flatness']['ges:std_dev'],
		row['value']['ges:centroid']['ges:mean'],
		row['value']['ges:centroid']['ges:std_dev']
	]
})

(
~limits = ('flat': ('lo': 1.0, 'hi': 0.0), 'cent': ('lo': 20000.0, 'hi': 20.0));
~flatcent.do({|arr|
	if (arr[0] < ~limits.flat.lo) { ~limits.flat.lo = arr[0] };
	if (arr[0] > ~limits.flat.hi) { ~limits.flat.hi = arr[0] };
	if (arr[2] < ~limits.cent.lo) { ~limits.cent.lo = arr[2] };
	if (arr[2] > ~limits.cent.hi) { ~limits.cent.hi = arr[2] };
});

)

(
~size = 500;
~win = Window("..feature map..", Rect(100, 100, ~size, ~size)).front;
~win.view.background_(Color.grey(0.1));
~win.drawHook = {
	~flatcent.do({|arr|
		var cm, cs;
		cm = Point(
			arr[0].explin(~limits.flat.lo, ~limits.flat.hi, 0.0, 1.0) * ~size,
			arr[2].explin(~limits.cent.lo, ~limits.cent.hi, 0.0, 1.0) * ~size
		);
		cs = Point(
			arr[1].explin(~limits.flat.lo, ~limits.flat.hi, 0, ~size),
			arr[3].explin(~limits.cent.lo, ~limits.cent.hi, 0, ~size)
		);
		cm = cm + cs / 2;
		Color.hsv(cm.asPolar.theta / 0.5pi * 0.999, 1.0, 1.0).set;
		Pen.fillOval(Rect(cm.x, cm.y, 10, 10));
		// Color.hsv(cs.asPolar.theta + pi / 2pi * 0.999, 1.0, 1.0).set;
		// Pen.fillOval(Rect(cs.x, cs.y, 10, 10));
		// Pen.line(cm, cs);
		// Pen.fillStroke;
	});
}
)

