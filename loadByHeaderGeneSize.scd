~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 2;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });

UGepLoader

//~allData = UGEP.loadDataFromDir

~data = ~meta.select({|meta| 
	var data, include, path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { 
		data = UGEP.loadData(path) 
	};
	include = (data.header.headsize == ~headsize).and(data.header.numgenes == ~numgenes);
	if (include) {  
		meta.data = data;
	};
	include
})

~data.collect(_.defname).

~data.first.keys

~meta.first
['defname']

~it = ~data.first

~it.argnames
~it.args.code.first
.asString.interpret
[0]

~it.data.linker

~chrm = GEPChromosome(~it.data.code, ~it.data.terminals, ~numgenes, ~it.data.linker)

~chrm.asUgenExpressionTree.asSynthDefString('gep_gen_000_000_120523_202119', Pan2, Normalizer, true)

~data.size

~f64 = ~data.reverse.keep(64)

~f64.collect(_.defname)

~it.args.args



(
Routine({
	~data.do({|dataitem, i|
		var chrom, tree, str, def, name;
		chrom = GEPChromosome(dataitem.data.code, dataitem.data.terminals, 
			~numgenes, dataitem.data.linker);
		tree = chrom.asUgenExpressionTree;
		name = ("s"++i.asString).asSymbol;
		str = tree.asSynthDefString(name, Pan2, Normalizer, true).postln;
		"".postln;
		def = str.interpret.add;
		8.do({
			var delta;
			delta = 0.5.rand.round(0.125) + 0.125;
			Synth(name, [\amp, 1, \dur, rrand(0.2, 0.5)] ++ dataitem.args.args)
				.setn(\env, Env.perc);
			delta.wait;
		});
		1.wait;
	})
}).play
)

File





SynthDef('gep_gen_000_000_120523_202119', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s|  Out.ar(out,Pan2.ar(Normalizer.ar((  Dust2.ar( LFPar.ar(a,  Logist0.ar( LFNoise1.ar(p, f, n ),  Saw.ar(k, s, q ),  LFNoise0.ar(k, d, r ),  Blip.ar(g, n, q, l ), o ),  LFNoise0.ar(n, q, c ), q ), b, f ))*( LFNoise1.ar(i,  Formant.ar( Logist0.ar(e, o, i, n, n ), f, h, i, b ),  LFNoise0.ar(a,  PMOsc.ar(l, g, m, l, k, g ),  LFNoise1.ar(d, i, a ) ) ) )),0,amp) * EnvGen.kr(EnvControl.kr,timeScale:dur,doneAction:2)) })


~args = "#[ a, 0.62922763824463, b, 42.900234222412, c, 5.5319352149963, d, 0.00035218510311097, e, 0.11461853981018, f, 599.27215576172, g, -0.00079052126966417, h, 63.261150360107, i, 42.794849395752, j, 4200, k, 42.900234222412, l, 0.11461853981018, m, 11.468799591064, n, 283.10696411133, o, 0.38874185085297, p, 42.900234222412, q, 0.29365935921669, r, 4200, s, 0.61076545715332 ]".interpret

~args


[ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s ]