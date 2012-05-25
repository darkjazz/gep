-------------  START gep_gen000_011 --------------
SynthDef('gep_gen000_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar( MostChange.ar( LFSaw.ar(g, j, i, n ),  Saw.ar(k, b, h ) ),  SinOsc.ar(g,  Crackle.ar(g, l, l ), g, m ) ))*( LFDNoise3.ar( LFNoise2.ar(d,  BrownNoise.ar(k, m ), k ), i,  LFDNoise3.ar( Dust.ar(l, f, n ), e, m ) ))*( Dust2.ar(n, a,  LFNoise1.ar(e,  Perlin3.ar( Impulse.ar(j, d, i, k ), a, m ),  LFNoise0.ar(f, d, a ) ) ) )))) })
[ a, 0.047718110439139, b, 1.0061161518097, c, 74.321776959799, d, 0.54304659664513, e, 0.42526769638062, f, 1, g, 821.27271571984, h, 821.27271571984, i, -0.65697418541308, j, 2.4630497694016, k, 0.60706286413931, l, 45.357623346218, m, 252.52942411568, n, 0.01414287237133 ]
SCORE: 6.17
-------------  START gep_gen000_018 --------------
SynthDef('gep_gen000_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(a, e,  Impulse.ar(n, e, c, e ), e ))*( SawDPW.ar( LFDNoise0.ar( LeastChange.ar(m, a ), k, k ), k,  GaussTrig.ar( LFDNoise0.ar(a, a, j ), f, d, l ), h ))*( PinkNoise.ar( LFNoise1.ar( LFSaw.ar( GrayNoise.ar(k, e ), j,  GrayNoise.ar(h, k ), g ),  ClipNoise.ar(m, h ),  Crackle.ar(a, h, k ) ), c ) )))) })
[ a, 0.077690281855638, b, 0, c, 4200, d, 491.38948461716, e, 0.62390100955963, f, 1.2484802303198, g, 126.46721813337, h, 0.42181719095966, i, 0.73958718776703, j, 972.3968237104, k, 26.111324583747, l, 28.43457355585, m, 491.38948461716, n, 0.31894564579 ]
SCORE: 5.82
-------------  START gep_gen000_019 --------------
SynthDef('gep_gen000_019', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Impulse.ar( FSinOsc.ar(j, e,  SyncSaw.ar(b, e, m, d ),  Perlin3.ar(f, a, g ) ),  LFDNoise3.ar(f, f, i ), m, n ))*( StkPluck.ar(f,  LFDNoise3.ar( Perlin3.ar(n, d, g ),  Pulse.ar(d, g, f, m ), h ), h,  Dust2.ar( Pulse.ar(i, h, f, d ), a, m ) ))*( GaussTrig.ar(b, n,  WhiteNoise.ar( LFTri.ar( LFNoise2.ar(e, d, j ), b, i, k ), j ), l ) )))) })
[ a, 4.7955452377829, b, 3891.0152395085, c, 54.958420406854, d, 0.74780857563019, e, 61.826559953118, f, 3891.1786212042, g, 1133.2106184592, h, 0.57058615317089, i, 3503.4524754753, j, 0.74780857563019, k, 572.34661925649, l, 37851092.589498, m, 0.91119027137756, n, -0.015202403068542 ]
SCORE: 6.61
-------------  START gep_gen000_024 --------------
SynthDef('gep_gen000_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LeastChange.ar( Dust.ar( LFDNoise1.ar(b, k, b ), n,  Perlin3.ar(f, j, d ) ),  BrownNoise.ar( Pulse.ar(d, i, m, b ), a ) ))*( SinTone.ar(e, e, b,  FSinOsc.ar(l,  Saw.ar(l, h, b ), d, j ) ))*( Impulse.ar( Blip.ar( LFDNoise0.ar(l, k, n ), i,  SinTone.ar(n, n, d, a ),  BrownNoise.ar(c, f ) ), j, j,  LFPar.ar(g, l, b, n ) ) )))) })
[ a, -0.30117692596512, b, 2.5843700994798, c, -0.18873847471846, d, 1.436329126358, e, 6.8143790658888, f, 1.436329126358, g, 0.1, h, 1.436329126358, i, 0, j, 1.9310884475708, k, 0.78370111871694, l, 1.5501169158128, m, 1.7541893720627, n, 2.5843700994798 ]
SCORE: 6.09
-------------  START gep_gen000_030 --------------
SynthDef('gep_gen000_030', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  StkPluck.ar(e, l, i, h ))*( SyncSaw.ar(a, e, l,  LFDNoise3.ar(d,  LFClipNoise.ar( SinTone.ar(e, f, b, m ), i, j ), a ) ))*( SinOsc.ar( ClipNoise.ar(l, g ),  LFNoise1.ar( LeastChange.ar(a, e ), h, a ), i,  ClipNoise.ar(m, g ) ) )))) })
[ a, 1, b, 0.08577161514469, c, 0.0071704799433601, d, 142.15545099681, e, 1.7616002822646, f, 1.0946468114853, g, -97.825299640415, h, 172.07479168936, i, 2572.4316322182, j, -0.14974483052534, k, 20000, l, 552.29636576862, m, 0.78451979160309, n, 0.27132657679479 ]
SCORE: 5.66


-------------  START gep_gen001_003 --------------
SynthDef('gep_gen001_003', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise3.ar( SyncSaw.ar( StkPluck.ar(n, e, c, m ), f, g,  Pulse.ar(d, f, c, j ) ),  StkPluck.ar(c, i, b, j ),  LFClipNoise.ar(h, i, f ) ))*( GaussTrig.ar( LFSaw.ar(f, k, d, i ), j,  SinTone.ar(n, a, m, f ),  FSinOsc.ar(c, d, e, b ) ))*( LeastChange.ar( Dust2.ar(i, b, f ), k ) )))) })
[ a, 3.1511245094692, b, 5520.5069228132, c, 41.680580395228, d, 0.14610779285431, e, 1.4613167725148, f, 0.37992862528653, g, -0.14610779285431, h, 5.5688313298919, i, 55.688513673673, j, 0.14610779285431, k, 22.393043719223, l, 54.872326530347, m, 122.17640220821, n, 237.19507698574 ]
SCORE: 5.29
-------------  START gep_gen001_009 --------------
SynthDef('gep_gen001_009', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(j,  Dust2.ar(a, f,  Dust2.ar(b, b, l ) ),  SyncSaw.ar(f, b, c, b ),  ClipNoise.ar(e, h ) ))*( Impulse.ar(m,  LFDNoise3.ar(f, e,  Saw.ar(a, m, e ) ), h, i ))*( GaussTrig.ar(a,  SinTone.ar( GaussTrig.ar(a, c, h, h ),  LFCub.ar(m, d, j, b ),  LeastChange.ar(h, m ),  SyncSaw.ar(e, d, e, l ) ),  LFSaw.ar(n, g, b, h ), m ) )))) })
[ a, 0.13346922397614, b, 0.54157561497686, c, 0.5, d, 0.77953279018402, e, -0.44139409065247, f, 1.3027395016584, g, 1432.573516722, h, 0.95650100708008, i, 5.4049310314399, j, 439.87079988074, k, 0.17696821689606, l, 1.376586716063, m, -1.1924913712319, n, 1.9130020141602 ]
SCORE: 5.82
-------------  START gep_gen001_013 --------------
SynthDef('gep_gen001_013', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar(m, m, j ))*( LFNoise0.ar( Perlin3.ar( Perlin3.ar(g, n, n ),  LFClipNoise.ar(f, i, l ), e ),  LFClipNoise.ar( SinOsc.ar(l, g, f, n ),  StkPluck.ar(i, h, a, n ), n ), e ))*( PinkNoise.ar( Perlin3.ar(d,  LFCub.ar(l, a, n, b ),  LeastChange.ar(b, d ) ),  Blip.ar( LFCub.ar(g, g, l, k ),  Crackle.ar(i, j, l ), j, n ) ) )))) })
[ a, 2.0257422794534, b, 4.5523563074268, c, 0.79725378792349, d, 6.2831853071796, e, -0.12447488307953, f, 1.9631695747375, g, 0.90178367952049, h, -5.1858943263777, i, 6.0298820764879, j, 0.18442027356664, k, 0.51028595161542, l, 2.670223236084, m, -0.046339940551356, n, -1.1786282037812 ]
SCORE: 5.89
-------------  START gep_gen001_014 --------------
SynthDef('gep_gen001_014', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SawDPW.ar( LFDNoise0.ar(n, e, c ), e,  Impulse.ar(e, d, g, f ), e ))*( SawDPW.ar( LFDNoise0.ar( LeastChange.ar(m, a ), k, k ), k,  GaussTrig.ar( LFDNoise0.ar(a, a, j ), f, d, l ), h ))*( PinkNoise.ar( LFNoise1.ar( LFSaw.ar( GrayNoise.ar(c, f ), k, k, g ),  ClipNoise.ar(m, c ),  Crackle.ar(i, i, e ) ), c ) )))) })
[ a, 0.001681791218523, b, 159.73646007125, c, 32.821790577351, d, 52.980491789689, e, 0.9578298330307, f, 0.24598423703505, g, 315.57158671003, h, 0.0052848231891948, i, 0.50853157043457, j, 257.84444000318, k, 25.146638743277, l, 32.821790577351, m, 52.980491789689, n, 0.2655743542806 ]
SCORE: 6.31
-------------  START gep_gen001_016 --------------
SynthDef('gep_gen001_016', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(a,  Blip.ar(g,  Saw.ar(h, h, k ),  LFDNoise3.ar(d, e, i ),  LFDNoise0.ar(b, n, m ) ), e,  SinOsc.ar(c, j, k, h ) ))*( LFDNoise3.ar(a,  SawDPW.ar(b,  MostChange.ar(c, g ),  MostChange.ar(l, f ),  GaussTrig.ar(l, e, f, f ) ),  SinOscFB.ar(g, h, l, l ) ))*( LFNoise2.ar(k,  LFSaw.ar( GaussTrig.ar(l, n, b, m ), n,  LFSaw.ar(j, k, l, c ), h ),  LFPar.ar(i, k, k, n ) ) )))) })
[ a, 0.001681791218523, b, 159.73646007125, c, 32.821790577351, d, 52.980491789689, e, 0.9578298330307, f, 0.24598423703505, g, 315.57158671003, h, 0.0052848231891948, i, 0.50853157043457, j, 257.84444000318, k, 25.146638743277, l, 32.821790577351, m, 52.980491789689, n, 0.2655743542806 ]
SCORE: 6.47
-------------  START gep_gen001_018 --------------
SynthDef('gep_gen001_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Impulse.ar( ClipNoise.ar(n, l ), a, a, l ))*( SinTone.ar( MostChange.ar( LFDNoise0.ar(d, a, a ), h ),  Pulse.ar(b, i, c, k ),  LFNoise1.ar(a, m, g ),  SawDPW.ar(j, n, i, n ) ))*( LFSaw.ar( StkPluck.ar(a, m,  LFDNoise0.ar(e, c, l ),  SinOscFB.ar(a, b, e, m ) ),  Impulse.ar(l, l, f, j ),  Blip.ar(l, m, k, f ),  GrayNoise.ar(a, j ) ) )))) })
[ a, 1.3372406155643, b, 3503.8887230625, c, 3503.1257120838, d, 2672.9233780818, e, 61.826559953118, f, 3891.1786212042, g, 1133.2106184592, h, 0.048313031136189, i, 2619.6674490069, j, 1.3372335221387, k, 1.6742012500763, l, 3891.0152395085, m, 0.91119027137756, n, -0.015202403068542 ]
SCORE: 6.06
-------------  START gep_gen001_020 --------------
SynthDef('gep_gen001_020', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Impulse.ar( ClipNoise.ar(n, l ), a, a, l ))*( SinTone.ar( MostChange.ar( LFDNoise0.ar(d, a, a ), h ),  Pulse.ar(b, i, c, k ),  LFNoise1.ar(a, m, g ),  SawDPW.ar(j, n, i, n ) ))*( LFSaw.ar( StkPluck.ar(a, m,  LFDNoise0.ar(e, c, l ),  SinOscFB.ar(a, b, e, m ) ),  Impulse.ar(l, l, f, j ),  Blip.ar(l, m, k, f ),  GrayNoise.ar(a, j ) ) )))) })
[ a, 3.1511245094692, b, 5520.5069228132, c, 41.680580395228, d, 0.14610779285431, e, 1.4613167725148, f, 0.37992862528653, g, -0.14610779285431, h, 5.5688313298919, i, 55.688513673673, j, 0.14610779285431, k, 22.393043719223, l, 54.872326530347, m, 122.17640220821, n, 237.19507698574 ]
SCORE: 6.06
-------------  START gep_gen001_021 --------------
SynthDef('gep_gen001_021', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(a,  Blip.ar(g,  Saw.ar(h, h, k ),  LFDNoise3.ar(d, e, i ),  LFDNoise0.ar(b, n, m ) ), e,  SinOsc.ar(c, j, k, h ) ))*( LFDNoise3.ar(a,  SawDPW.ar(b,  MostChange.ar(c, g ),  MostChange.ar(l, f ),  GaussTrig.ar(l, e, f, f ) ),  SinOscFB.ar(g, h, l, l ) ))*( LFNoise2.ar(k,  LFSaw.ar( GaussTrig.ar(l, n, b, m ), n,  LFSaw.ar(j, k, l, c ), h ),  LFPar.ar(i, k, k, n ) ) )))) })
[ a, 0.11913638474496, b, 0.16016194312867, c, 1.1060171383314, d, 0.39414043525123, e, 1.2212109737646, f, 0.19756283432817, g, 2.5270577251906, h, 6.2831853071796, i, 0.7015974521637, j, 0.059866257775909, k, 2.0108379125595, l, 1.7001327499093, m, -0.1830940246582, n, 6.2831853071796 ]
SCORE: 6.47
-------------  START gep_gen001_024 --------------
SynthDef('gep_gen001_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  ClipNoise.ar(j,  SinTone.ar( WhiteNoise.ar( LFDNoise0.ar(e, h, m ),  LFTri.ar(i, d, a, n ) ),  LFDClipNoise.ar(e, c, k ), g, f ) ))*( Pulse.ar(f,  StkPluck.ar( Dust2.ar(m, m, f ),  Saw.ar(k, k, l ), k, k ), a, j ))*( LFCub.ar(b, b,  Dust.ar( GaussTrig.ar(f, m, m, d ), g, a ),  SyncSaw.ar(h, j, f, j ) ) )))) })
[ a, 0, b, 0.00086182847267124, c, -0.601118683815, d, 1, e, 153.65552253544, f, -0.7474687072049, g, 20000, h, 153.65552253544, i, 153.05440385162, j, 1.2944204807281, k, 26.387596471021, l, 1.3353292283216, m, 1.4578713178635, n, 153.65552253544 ]
SCORE: 4.94
-------------  START gep_gen001_030 --------------
SynthDef('gep_gen001_030', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(a,  Blip.ar(g,  Saw.ar(h, h, k ),  LFDNoise3.ar(d, e, i ),  LFDNoise0.ar(b, n, m ) ), e,  SinOsc.ar(c, j, k, h ) ))*( LFDNoise3.ar(a,  SawDPW.ar(b,  MostChange.ar(c, g ),  MostChange.ar(l, f ),  GaussTrig.ar(l, e, f, f ) ),  SinOscFB.ar(g, h, l, l ) ))*( LFNoise2.ar(k,  LFSaw.ar( GaussTrig.ar(l, n, b, m ), n,  LFSaw.ar(j, k, l, c ), h ),  LFPar.ar(i, k, k, n ) ) )))) })
[ a, 4200, b, 0.077690281855638, c, 0, d, 27.610785870051, e, 0.21676006179911, f, 18.556857702838, g, 0.025123119354248, h, 39.803974414941, i, -0.026258037454144, j, 0, k, 0.00072969536019993, l, 0.050134263410229, m, 0.62390100955963, n, 491.38948461716 ]
SCORE: 6.47
-------------  START gep_gen001_031 --------------
SynthDef('gep_gen001_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(k,  PinkNoise.ar( LFDClipNoise.ar(f, k, l ),  StkPluck.ar(n, i, e, g ) ),  LFNoise1.ar(h,  Impulse.ar(b, f, b, k ), e ), d ))*( Saw.ar(g, j,  LFPar.ar(g,  LFNoise0.ar( Crackle.ar(a, k, e ), i, h ),  LFTri.ar(j, k, m, d ),  LFNoise0.ar(e, f, m ) ) ))*( FSinOsc.ar(b, g,  LFNoise2.ar( Crackle.ar(n, h, c ),  LeastChange.ar(g, d ),  LFPar.ar(e, c, l, d ) ),  GrayNoise.ar( SawDPW.ar(m, n, l, f ), m ) ) )))) })
[ a, 1.3372406155643, b, 3503.8887230625, c, 3503.1257120838, d, 2672.9233780818, e, 61.826559953118, f, 3891.1786212042, g, 1133.2106184592, h, 0.048313031136189, i, 2619.6674490069, j, 1.3372335221387, k, 1.6742012500763, l, 3891.0152395085, m, 0.91119027137756, n, -0.015202403068542 ]
SCORE: 6.24

-------------  START gep_gen000_005 --------------
SynthDef('gep_gen000_005', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(e,  Perlin3.ar( PinkNoise.ar( LFPar.ar(l, n, b, a ), f ),  Dust2.ar(l, f, j ), l ), a, e ))*( Perlin3.ar( LFPar.ar( Impulse.ar(h, c, o, k ), g, m, g ), a,  Saw.ar(c, l, e ) ) )))) })
[ a, 1, b, 0.68800254848702, c, 39.97458343201, d, 0, e, 0.10025131702423, f, -1.5141123227057, g, 1.1247093677521, h, 6157.5446083465, i, 104.45208075674, j, 20000, k, 0.23029391010409, l, 2.8093435801445, m, 1.6589183807373, n, 0.0099177420780513, o, 3.4322364290669 ]
SCORE: 6.23
-------------  START gep_gen000_058 --------------
SynthDef('gep_gen000_058', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(a, h, l, e ))*( FSinOsc.ar( HPF.ar( ClipNoise.ar(d, o ), j, f, o ), f,  BrownNoise.ar(o, g ), o ) )))) })
[ a, 0.67896592617035, b, 4.1336582350121, c, 3.1415926535898, d, 6.0946245418796, e, 0.050146693671493, f, -0, g, 1.179182767868, h, 1.1174284219742, i, 5.0946245418796, j, 1, k, 1.3999447224598, l, 0.58789437072016, m, -0.24217717746886, n, 0.94188697734365, o, 0.31208328858 ]
SCORE: 5.69
-------------  START gep_gen000_063 --------------
SynthDef('gep_gen000_063', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar(l, l,  Dust.ar( Dust2.ar(i, h, c ), c,  LFNoise1.ar(n, o, k ) ) ))*( LFNoise2.ar( GrayNoise.ar( LFNoise2.ar(d,  LFNoise2.ar(f, o, i ), h ),  Blip.ar(n, k, k, k ) ), h, l ) )))) })
[ a, 15.166577239757, b, 2953.5954495535, c, -1.1508784932412, d, -0.17516820335251, e, 0, f, 0.20660281398947, g, 0.27543972030778, h, 3.944796674228, i, 1.148169875145, j, -0.93970131874084, k, 0.41881970395155, l, 0.3399201631546, m, 3084.5967759185, n, 3083.6570745997, o, 0.45161128044128 ]
SCORE: 4.32


-------------  START gep_gen001_005 --------------
SynthDef('gep_gen001_005', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(o, n ))*( Impulse.ar( Impulse.ar( SinOsc.ar(o, o, k, c ), e,  SinOsc.ar(f, c, o, m ), a ),  Impulse.ar(g, l, e, i ),  Impulse.ar(k, m, l, c ),  SinOsc.ar(j, h, f, e ) ) )))) })
[ a, 70.068832889388, b, 0.62566113471985, c, 5867.9394147979, d, 39.808726418194, e, 15.331351242152, f, 65.122977509787, g, 65.122977509787, h, 0.1968240737915, i, 0.36772549152374, j, 0.086525130890528, k, 1.0996494293213, l, 9.0762726522859, m, 253.63341559401, n, 0.11667965806851, o, 0.18793164647946 ]
SCORE: 5.42
-------------  START gep_gen001_025 --------------
SynthDef('gep_gen001_025', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar(a, i, l,  ClipNoise.ar( SawDPW.ar( Dust.ar(d, j, g ), i, k, j ), a ) ))*( HPF.ar( Pulse.ar(b,  BrownNoise.ar(c, b ), a, k ), n, o,  LFTri.ar(e, a, b, j ) ) )))) })
[ a, 5.1727023260219, b, 1.9379430982189, c, 0.29673650713687, d, 3.6752465991705, e, 0.11500287055969, f, 5.2924352029867, g, 1.386604309082, h, 1.6005037809833, i, 0.11009455886696, j, 1, k, 2.4844016211993, l, 0.69123554229736, m, 6.1347524265356, n, 0.61818962263801, o, 0.6198330675347 ]
SCORE: 5.87
-------------  START gep_gen001_027 --------------
SynthDef('gep_gen001_027', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( PinkNoise.ar(k,  LFSaw.ar(c, m, i, k ) ), n, i, n ))*( Impulse.ar( SawDPW.ar( LFSaw.ar(h, m, b, b ),  Saw.ar(b, m, k ), e, g ), c, c, n ) )))) })
[ a, 4200, b, 0.014677893598048, c, -144.84463021679, d, 0.73085357347024, e, 3476.8353456873, f, 0.91345942020416, g, 0.94645819444914, h, 1.4635535391318, i, 0.42609397999257, j, 160.44992583957, k, 79.610413403527, l, 1.4032801389694, m, 0.34610449401991, n, -0.20297928721018, o, -20.759444035346 ]
SCORE: 4.86
-------------  START gep_gen001_028 --------------
SynthDef('gep_gen001_028', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(o, n ))*( Impulse.ar( Impulse.ar( SinOsc.ar(o, o, k, c ), e,  SinOsc.ar(f, c, o, m ), a ),  Impulse.ar(g, l, e, i ),  Impulse.ar(k, m, l, c ),  SinOsc.ar(j, h, f, e ) ) )))) })
[ a, 70.068832889388, b, 0.62566113471985, c, 5867.9394147979, d, 39.808726418194, e, 15.331351242152, f, 65.122977509787, g, 65.122977509787, h, 0.1968240737915, i, 0.36772549152374, j, 0.086525130890528, k, 1.0996494293213, l, 9.0762726522859, m, 253.63341559401, n, 0.11667965806851, o, 0.18793164647946 ]
SCORE: 5.42
-------------  START gep_gen001_040 --------------
SynthDef('gep_gen001_040', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c, o,  SawDPW.ar( FSinOsc.ar(f, l, e, g ), f,  Dust2.ar(g, f, j ), n ),  LFClipNoise.ar(g, c, i ) ))*( LPF.ar( LFPar.ar(b,  PinkNoise.ar(i, m ), h, c ), j, h, e ) )))) })
[ a, 0.71953045253488, b, 0.12004992829108, c, 11.090964102611, d, 0.54722166061401, e, 0.45277833938599, f, 20000, g, 0.76862097677366, h, 0, i, 1.094443321228, j, 1.3806118965149, k, 20000, l, -0.99484360218048, m, 0.1, n, -0.52052545547485, o, -0.12024750212169 ]
SCORE: 5.07
-------------  START gep_gen001_041 --------------
SynthDef('gep_gen001_041', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( PinkNoise.ar(k,  LFSaw.ar(c, m, i, k ) ), n, i, n ))*( Impulse.ar( SawDPW.ar( LFSaw.ar(h, m, b, b ),  Saw.ar(b, m, k ), e, g ), c, c, n ) )))) })
[ a, 1.0812891921052, b, 1.3782258344526, c, 2.1661214156666, d, 3683.971153693, e, -0.40992558002472, f, 1.1650521753082, g, 1.3184984041089, h, 0.25461873323906, i, 1465.2218494003, j, 0.53986111371529, k, 1466.1962650602, l, 514.82349319846, m, 1.5644900798798, n, 2.3416665594676, o, -513.49866636187 ]
SCORE: 4.86
-------------  START gep_gen001_043 --------------
SynthDef('gep_gen001_043', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( PinkNoise.ar(k,  LFSaw.ar(c, m, i, k ) ), n, i, n ))*( Impulse.ar( SawDPW.ar( LFSaw.ar(h, m, b, b ),  Saw.ar(b, m, k ), e, g ), c, c, n ) )))) })
[ a, -0.036783706916381, b, 1.4987663030624, c, 13.039604397612, d, 13.039604397612, e, 12.278112198842, f, 13.039604397612, g, 0.63272647289179, h, 0.41957746154389, i, 0, j, 0.065925208477339, k, 0.83638346195221, l, 1.5369191169739, m, 4.0809131378393, n, 1, o, 0.13129532337189 ]
SCORE: 4.86
-------------  START gep_gen001_053 --------------
SynthDef('gep_gen001_053', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar(a, i, l,  ClipNoise.ar( SawDPW.ar( Dust.ar(d, j, g ), i, k, j ), a ) ))*( HPF.ar( Pulse.ar(b,  BrownNoise.ar(c, b ), a, k ), n, o,  LFTri.ar(e, a, b, j ) ) )))) })
[ a, 534.6986980092, b, 0.11183466823693, c, 811.53689725446, d, 0.67875363260873, e, 0.16148796372395, f, 0.91165760065866, g, 0.21383865844064, h, 1.7920507829852, i, -2.107074567973, j, -0.19978495879829, k, 0.045389613361749, l, 0.25502157296432, m, -4.7273796435843, n, 0, o, 36.370358285201 ]
SCORE: 5.87