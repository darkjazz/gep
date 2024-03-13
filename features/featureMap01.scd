~kmeansMulti = KMeans(~nclusters)

~coefs.do({|coef|
	~kmeansMulti.add(coef)
})

~kmeansMulti.update

~nclusters.collect({|num|
	Post << num << ": " << ~kmeansMulti.assignments.occurrencesOf(num) << Char.nl;
	~kmeansMulti.assignments.occurrencesOf(num)
})

(
~size = 510;
~win = Window("..kmeans..", Rect(100, 100, ~size, ~size)).front;
~win.view.background_(Color.black);
~coords = [  ];
~win.drawHook = {
	~coefs.do({|coef|
		var cluster = ~kmeansMulti.classify(coef);
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

~win.view.mouseDown = {

}