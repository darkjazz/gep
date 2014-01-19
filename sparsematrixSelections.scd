~selectedIndices = [1, 4, 16, 21, 26, 38, 44, 57, 61, 62, 79, 80, 83, 101, 121, 128, 130, 143, 148, 152, 158, 164, 166, 170, 175, 177, 191, 192, 201, 203, 204, 207, 212, 215, 228, 229, 243, 248, 256, 259, 262, 275, 280, 283, 284, 287, 298, 305, 314]

SparseMatrix

~names = ~selectedIndices.collect({|ind| ~meta[ind].defname })

~names.do(_.postln)

~defname = 'gep_gen000_005_130501_180743';
~path = UGEP.archDir +/+ ~defname.asString ++ "." ++ UGEP.fileExt
~data = UGEP.loadData(~path);

~chrom = GEPChromosomes(~data.code, ~data.terminals, ~data.header.numgenes, ~data.linker)

~chrom.asUgenExpressionTree



(
~defnames = [	
	\gep_gen000_005_130501_180743,
	\gep_gen000_007_130501_180759,
	\gep_gen000_058_130502_145351,
	\gep_gen001_020_130503_003936,
	\gep_gen001_036_130501_181549,
	\gep_gen002_003_130501_182402,
	\gep_gen002_019_130501_182433,
	\gep_gen002_054_130501_182539,
	\gep_gen002_086_130503_105839,
	\gep_gen002_089_130503_105844,
	\gep_gen003_059_130503_113248,
	\gep_gen003_060_130501_183556,
	\gep_gen003_099_130503_113253,
	\gep_gen004_066_130503_121740,
	\gep_gen005_033_130501_202804,
	\gep_gen005_051_130501_202839,
	\gep_gen005_054_130503_124142,
	\gep_gen005_120_130503_124232,
	\gep_gen006_010_130503_131939,
	\gep_gen006_026_130503_131949,
	\gep_gen006_046_130501_205504,
	\gep_gen006_064_130503_132019,
	\gep_gen006_076_130503_132030,
	\gep_gen006_114_130503_132050,
	\gep_gen007_014_130503_142546,
	\gep_gen007_018_130503_142556,
	\gep_gen007_094_130503_142636,
	\gep_gen007_100_130503_142642,
	\gep_gen008_007_130501_211737,
	\gep_gen008_010_130501_211747,
	\gep_gen008_010_130503_144321,
	\gep_gen008_016_130501_211757,
	\gep_gen008_024_130501_211817,
	\gep_gen008_055_130501_211832,
	\gep_gen009_021_130503_145825,
	\gep_gen009_022_130503_145830,
	\gep_gen009_051_130503_145851,
	\gep_gen009_095_130503_145906,
	\gep_gen010_022_130501_215138,
	\gep_gen010_029_130503_151002,
	\gep_gen010_033_130503_151012,
	\gep_gen010_061_130501_215239,
	\gep_gen010_111_130503_151052,
	\gep_gen011_001_130501_220738,
	\gep_gen011_001_130503_153102,
	\gep_gen011_004_130503_153108,
	\gep_gen011_023_130501_220834,
	\gep_gen011_036_130501_220849,
	\gep_gen011_114_130503_153149
];
)

~player

~allPatterns = DjembeLib.convertAll(2)
~sparse = ~allPatterns.collect(SparsePattern(_)).collect(_.makeSparse)

~arr = [];
~on = false;
~sparse[\djakandi].patterns.sum.do({|num|
	if (num == 1) { ~on = ~on.not } ;
	~arr = ~arr.add(~on.asInt)	
})

~player = UGepPlayer(~defnames[10])

~pmono = ~player.asPmono(Pseq(~arr, inf), 0.25)

p = ~pmono.play

p.stop

~player.play

~player.set(\amp, 0.3)

~player.free

~mtrx = SparseMatrix()

SparseMatrix.sparsePatterns[\djakandi]