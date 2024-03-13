~loader = JsonLDLoader("ges_ld_00")

~features = ~loader.db.getParsed("allValidFeatures")

~coefs = ~features["rows"].keep(43).collect({|row|
	row["value"]["ges:mfcc"]["ges:mean"].collect(_.asFloat)
	++ row["value"]["ges:mfcc"]["ges:std_dev"].collect(_.asFloat)
})

~distanceMatrix = Array.fill(~coefs.size, { Array.newClear(~coefs.size) });

~coefs.do({|coefA, y|
	~coefs.do({|coefB, x|
		~distanceMatrix[y][x] = (coefA - coefB).squared.sum.sqrt
	})
});

~size = ~coefs.size

~ctrH = Array.fill(~size, {|x| Array.fill(~size, {|y| if (x==y) { 1.0 } { 0.0 } }) }) - (((1.0 ! ~size) ! ~size) / ~size)

~ctrB = Matrix.with(~ctrH.neg).mulMatrix(Matrix.with(~distanceMatrix.squared)).mulMatrix(Matrix.with(~ctrH)) / 2;


/* dot product
a = [[1, 2, 3], [1, 2, 3], [1, 2, 3]];
b = [[1, 1, 1], [2, 2, 2], [3, 3, 3]];

Matrix.with(b).mulMatrix(Matrix.with(a))
*/
