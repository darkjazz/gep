// generation 0

SynthDef('test_04', {|a,b,c,d,e,f,g,h,i,j,k,l,m|  Out.ar(0, (  SinOsc.ar(  LFNoise0.ar(  LFNoise0.ar( k, a, i ), l, f ),  LFSaw.ar( e, l, m, l ), h,  LFNoise0.ar( d, i, k ) ))*( SinOsc.ar(  LFSaw.ar(  LFPulse.ar( c, b, b, g, f ), k, a, a ),  LFNoise0.ar( k, f, h ),  LFSaw.ar( a, i, l, a ),  LFNoise0.ar( d, i, c ) ) )) }).add

x=Synth('test_04', #[ a, 9271.6266518087, b, -1776.9647773107, c, 0.75121368702199, d, 0.10681132915056, e, 1777.9017873605, f, 7357.1634915279, g, 0.87798783346358, h, 20000, i, -0.73014771938324, j, 4.9864652171624, k, 20000, l, 0.020643190595998, m, 20000 ])

x.free



SynthDef('test_16', {|a,b,c,d,e,f,g,h,i,j,k,l,m|  Out.ar(0, (  LFSaw.ar( b, e,  SinOsc.ar(  LFSaw.ar( g, d, k, e ),  LFSaw.ar( c, g, b, e ), l, b ),  LFNoise0.ar( a, e, d ) ))*( LFSaw.ar(  LFSaw.ar(  LFSaw.ar( e, k, j, a ),  SinOsc.ar( k, c, f, e ), m, f ), h,  LFSaw.ar( a, d, a, b ),  SinOsc.ar( k, e, b, a ) ) )) }).add

x=Synth('test_04', #[ a, 12.800537510672, b, 6.6657290591834, c, 0.95890080776971, d, -0.13804598266333, e, -1.0455952854061, f, 6.0249514664213, g, 0.4818924245709, h, 0.38539147377014, i, 0.068680730449281, j, 1.9953330755234, k, 1.1219329144223, l, 2.979716099092, m, 0.36882603435192 ])

x.free




SynthDef('gep_gen000_002', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m|  Out.ar(out, Normalizer.ar((  SinOsc.ar( a, a, e,  LFSaw.ar(  LFNoise0.ar( f, h, e ),  LFPulse.ar( b, m, d, l, l ), e, b ) ))+( LFPulse.ar( h,  LFNoise0.ar(  LFNoise0.ar( l, g, h ), g, i ),  LFPulse.ar( a, h, i, h, a ),  LFPulse.ar( h, h, k, h, j ), a ))+( LFNoise0.ar(  LFSaw.ar(  LFNoise0.ar( l, b, m ), g,  LFPulse.ar( h, f, e, f, k ), k ),  LFSaw.ar( l, j, k, g ),  LFSaw.ar( c, f, d, d ) ) ))) })

x=Synth('gep_gen000_002', #[ a, 67.750229764528, b, 0, c, 247.95347161262, d, 1.490818523507, e, 0.52690206784167, f, 5.4339754742896e-05, g, 1381.2052192069, h, 2, i, -0.2624341483026, j, 0.97046884014636, k, 1381.2052192069, l, -0.74176917034785, m, 1.0607151985168 ])

x.free




SynthDef('gep_gen001_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  ClipNoise.ar(a,  LFDNoise3.ar( LFDNoise3.ar(g, f, i ), l, g ) ))*( GrayNoise.ar( Impulse.ar(h,  SyncSaw.ar(e, i, f, e ), j, j ), h ))*( Pulse.ar( SinOsc.ar(g,  LeastChange.ar(f, a ), l, b ), e, b,  LFCub.ar(l, j, g, i ) ) ))) })

[ a, -0.20451068878174, b, 0.49815569047036, c, 1.9727537073714, d, 0.21377207565865, e, 0.25332452371133, f, 0.002147803360586, g, 0.84823020164913, h, 0.20451068878174, i, 0.45515882968903, j, -0.046344399452209, k, 0.33926991277453, l, 100 ]


SynthDef('gep_gen001_015', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  SinTone.ar(g,  LFCub.ar( LFSaw.ar(b, l, k, f ), f, j, l ),  SawDPW.ar(h, a, g, d ), k ))*( SinOscFB.ar(i,  Impulse.ar(c, b, k, f ),  Perlin3.ar(g, e, h ),  LFNoise0.ar(i, e, f ) ))*( Impulse.ar(b, d, d,  LFPar.ar( SyncSaw.ar(l, j, g, b ), k, c, f ) ) ))) })

[ a, 0, b, 15.178750721599, c, 2.2597516569187, d, 0.42888188362122, e, 0.046145518820033, f, 0.65915381908417, g, -0.86229968070984, h, -13.055007302848, i, 15.986972756012, j, 15.178750721599, k, 11.507073386744, l, 0.71116980982139 ]


SynthDef('gep_gen001_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  ClipNoise.ar(a,  LFDNoise3.ar( LFDNoise3.ar(g, f, i ), l, g ) ))*( GrayNoise.ar( Impulse.ar(h,  SyncSaw.ar(e, i, f, e ), j, j ), h ))*( Pulse.ar( SinOsc.ar(g,  LeastChange.ar(f, a ), l, b ), e, b,  LFCub.ar(l, j, g, i ) ) ))) })

[ a, -59.630859497283, b, -0.23341224582765, c, 0.058741807937622, d, 7.9690452854363, e, 29.488042437691, f, 3.3584645374449, g, 0.21704454149676, h, 0.59443926811218, i, 1, j, 0.24441119812195, k, 0.053709718595769, l, 1197.3769897281 ]



SynthDef('gep_gen001_019', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  SyncSaw.ar( LFDClipNoise.ar( LeastChange.ar(a, g ),  SinOsc.ar(g, l, b, c ), e ),  LFNoise0.ar(i, b, f ), k, k ))*( GaussTrig.ar(g, e,  BrownNoise.ar( SinTone.ar(f, e, h, a ),  FSinOsc.ar(g, d, g, f ) ),  Saw.ar(h, g, b ) ))*( SinOsc.ar( MostChange.ar(e, g ),  LFNoise2.ar(c, c, j ), d,  SinOscFB.ar(l, d, l, g ) ) ))) })

[ a, 0, b, 38.880138305547, c, -0.25215984458411, d, 2.7350086709923, e, 249.98770931965, f, 0.28992330494774, g, 13.262895839505, h, 1.5560255771004, i, -1527.5350834199, j, -0.60595892332513, k, 1.0013170135073, l, 0.59797492140396 ]



SynthDef('gep_gen001_020', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  Dust.ar( Saw.ar( Blip.ar(j, a, i, i ), d, c ),  FSinOsc.ar(l, c, i, k ), l ))*( Saw.ar(f, c,  PinkNoise.ar( LFDNoise1.ar( SyncSaw.ar(g, d, k, f ), h, l ), f ) ))*( LFClipNoise.ar( StkPluck.ar( Dust2.ar(d, l, a ),  FSinOsc.ar(h, a, d, i ), c, h ), i, j ) ))) })

[ a, 0.19254870323364, b, 6.2831853071796, c, 3.0823231712922, d, 0, e, 2.1837265135231, f, 0.75803637504578, g, 0.8705587387085, h, -0.92584633827209, i, 1.9020638538091, j, 0.30838138859074, k, 0, l, 0.14301609992981 ]



SynthDef('gep_gen001_022', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  Crackle.ar(e,  FSinOsc.ar( MostChange.ar(b, b ),  LFDClipNoise.ar(g, i, f ), i, k ), j ))*( SyncSaw.ar( WhiteNoise.ar(i, d ), e,  BrownNoise.ar(k, l ), k ))*( LFClipNoise.ar( LeastChange.ar( SinOsc.ar(f, k, l, e ), k ), e, g ) ))) })

[ a, 1.87103663734, b, 13.088671349621, c, 0.50293286650029, d, 2423.6062613597, e, 0.3742870092392, f, 3.3258647633188, g, 11.433996998979, h, 1.1730874314268, i, 8.4814701444049e-06, j, -0.58920550346375, k, 0.23091068910263, l, 0.28397209841852 ]



SynthDef('gep_gen001_030', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Normalizer.ar((  LFDNoise3.ar(l,  GrayNoise.ar(g, i ), c ))*( Dust.ar( LFClipNoise.ar( SinOsc.ar(c, d, d, b ),  Blip.ar(k, a, b, e ),  GaussTrig.ar(d, e, g, b ) ),  LeastChange.ar(f, b ), i ))*( Dust2.ar(d, e,  SinOsc.ar(j,  GrayNoise.ar(b, e ),  LFSaw.ar(l, f, d, k ), b ) ) ))) })

[ a, 2.1050675591791, b, 1.1594704431891, c, -0.76296165623079, d, 1.3328586816788, e, 0.83333166335797, f, 0.1, g, 0.1, h, -0.35681136368451, i, 0.74686677018538, j, 2.3189408863782, k, 0.5004035112029, l, 1.8866497915257 ]


SynthDef('gep_gen000_026', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar( LFNoise2.ar( StkPluck.ar( LFDClipNoise.ar(e, d, c ), l, a, j ),  GaussTrig.ar(i, h, b, l ), i ), l ))*( FSinOsc.ar(b, f, b,  PinkNoise.ar( StkPluck.ar(a, a, j, h ),  LFDNoise0.ar(d, g, i ) ) ))*( LFNoise1.ar( GrayNoise.ar(j,  LFNoise1.ar(d, d, g ) ), f,  FSinOsc.ar( LFTri.ar(f, i, c, j ), j, b, f ) ) )))) })

[ a, 1.5660528989293, b, 418.41009838533, c, 0.24072476883128, d, 0.85824239253998, e, 25, f, 1, g, -1.5760419717193, h, 0.69391524010496, i, 4200, j, 105.49664435922, k, 68.521817596757, l, 0.00012718121440065 ]




SynthDef('gep_gen000_036', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(a,  Pulse.ar(c, b, d, e ),  SinTone.ar(a, l, h, f ) ))*( MostChange.ar( Dust.ar(g, l, i ),  Blip.ar( SinOsc.ar(d, b, g, j ), g, c, b ) ))*( Saw.ar( SinOscFB.ar( GrayNoise.ar(e, a ),  GrayNoise.ar(l, d ),  SinTone.ar(l, c, a, i ), d ),  WhiteNoise.ar(e, i ), a ) )))) })

[ a, 0.52717038169797, b, 60.258131786399, c, 6997.6781993532, d, -0.499760389328, e, 0.97118079662323, f, 0.97118079662323, g, 67.226748498153, h, 0.13077652549237, i, 0.53880906105042, j, 0.30768509880002, k, 2.160333052771, l, 2 ]

