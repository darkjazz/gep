~matrix = SparseMatrix(
	FoaDecoder(decoderType: 'stereo'),
	CinderApp(),
	2, 
	20
)

~patterns = ~matrix.class.sparsePatterns['raboday'].keep(4);
~arr = (0 ! ~patterns.first.size)

~patterns.do({|pat|
	~arr[pat.indexOf(1)] = 1
})

~arr = ~arr.add(1)


~times = [];
~cdur = 0;

~arr.do({|amp, i|
	if ((i > 0).and(amp == 1))
	{
		~times = ~times.add(~cdur);
		~cdur = 0;
	};
	~cdur = ~cdur + 1;
})

~times * 0.25

~durs = ~times.collect({|time, i|
	[~times.keep(i).sum, time, ~times.drop(i+1).sum]
}) * 0.125