(
~deflib.do({|ev|
	var score = 0, mean=0, stddev=0;
	ev[\mfcc].collect({|stat, i|
		if ((stat.mean.isNaN).or(stat.mean.isNaN)) {
			score = 0;
		} 
		{
			mean = mean + (1.0 - abs(stat.mean - ~targetStats.mfcc[i].mean).clip(0.0, 1.0));
			stddev = stddev + (1.0 - abs(stat.stdDev - ~targetStats.mfcc[i].stdDev).clip(0.0, 1.0));
		};
	});
	score = score + (mean/13);
	score = score + (stddev/13);
	["MFCC:", mean/13, stddev/13].postln;
	if ((ev[\flat].mean.isNaN).or(ev[\flat].stdDev.isNaN)) {
		score = 0
	}
	{
		score = score + (1.0 - abs(ev[\flat].mean - ~targetStats.flat.mean));
		score = score + (1.0 - abs(ev[\flat].stdDev - ~targetStats.flat.stdDev));
	};
	["FLAT: ", 1.0 - abs(ev[\flat].mean - ~targetStats.flat.mean), 
		1.0 - abs(ev[\flat].stdDev - ~targetStats.flat.stdDev)].postln;
	if ((ev[\cent].mean.isNaN).or(ev[\cent].stdDev.isNaN)) {
		score = 0
	}
	{
		score = score + (1.0 - ControlSpec.specs['freq'].unmap(abs(ev[\cent].mean - ~targetStats.cent.mean)));
		score = score + (1.0 - ControlSpec.specs['midfreq'].unmap(abs(ev[\cent].stdDev - ~targetStats.cent.stdDev)));
	};
	["CENT: ", 1.0 - ControlSpec.specs['freq'].unmap(abs(ev[\cent].mean - ~targetStats.cent.mean)),
		1.0 - ControlSpec.specs['midfreq'].unmap(abs(ev[\cent].stdDev - ~targetStats.cent.stdDev))
	].postln;
	if ((ev[\amp].mean.isNaN).or(ev[\amp].stdDev.isNaN)) {
		score = 0
	}{
		if (ev[\amp].mean > 1.0) {
			score = 0 
		}
		{
			score = score + (1.0 - abs(ev[\amp].mean - ~targetStats[\amp].mean));
			score = score + (1.0 - abs(ev[\amp].stdDev - ~targetStats[\amp].stdDev));
		}				
	};
	["AMP: ", 1.0 - abs(ev[\amp].mean - ~targetStats[\amp].mean), 
		1.0 - abs(ev[\amp].stdDev - ~targetStats[\amp].stdDev)
	].postln;
	if (ev[\err].mean > 0) { score = 0 };
	["ERR: ", ev[\err].mean, ev[\err].stdDev].postln;
	("SCORE: " ++ score.round(0.01)).postln
})
)