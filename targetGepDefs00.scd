// target gep finds

-------------  START gep_gen000_001 --------------
SynthDef('gep_gen000_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  Perlin3.ar( PinkNoise.ar(j, j ),  SinOscFB.ar( LeastChange.ar(d, c ), j, j, k ),  StkPluck.ar(b, i, k, j ) ))*( LFNoise1.ar( Blip.ar( LFDNoise0.ar(e, e, l ),  Perlin3.ar(j, b, i ), h, h ), d,  Impulse.ar(h, d, e, j ) ))*( Dust2.ar( Perlin3.ar( Dust.ar(k, i, b ), b, f ),  Perlin3.ar(i, g, j ),  LFNoise1.ar(d, h, b ) ) )))) })
[ a, 2.2998248043614, b, 0.78085947036743, c, -345.44475024951, d, -0.046170714609261, e, 0.38147938251495, f, 25, g, 0.53596729511793, h, 349.89941747576, i, 2.9795351135359, j, 0.61858065153393, k, 4.9696532644558, l, 98.146635129821 ]
SCORE: 5.83
-------------  START gep_gen000_004 --------------
SynthDef('gep_gen000_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(k, e, j, i ))*( Perlin3.ar( GaussTrig.ar(h, e, k, e ), g,  LFPar.ar(a, a, b, d ) ))*( SawDPW.ar( SyncSaw.ar( SinOsc.ar(j, l, j, f ), g, k, c ),  Pulse.ar(a, f, f, b ),  Dust2.ar(d, g, e ),  Pulse.ar(k, f, f, a ) ) )))) })
[ a, -0.13287675380707, b, 0, c, 0.0045672906874188, d, 142.1680506693, e, 0.001631947826784, f, 127.13645362447, g, 4200, h, 25, i, 1.7589962482452, j, 1.3029491901398, k, 50.846921497767, l, 25.737881104427 ]
SCORE: 5.87
-------------  START gep_gen000_012 --------------
SynthDef('gep_gen000_012', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(d, a, k, b ),  PinkNoise.ar(g, e ),  LeastChange.ar(i, g ), e ),  LFTri.ar(a, e, l, k ) ))*( GaussTrig.ar( LFNoise0.ar(c,  LFNoise2.ar(l, c, g ), b ), e, d, k ))*( LFCub.ar(l, f,  LFNoise0.ar( LFClipNoise.ar(d, g, f ), a, a ),  FSinOsc.ar(c, d, e, b ) ) )))) })
[ a, 117.91008419416, b, -13.315219901366, c, -0.61795008182526, d, 1.0120168094751, e, 0.30066084823304, f, 1.1119400262833, g, 298.90806814775, h, -6.821577592914, i, 0.67880491254981, j, 0, k, 0.1, l, 0.96586573123932 ]
SCORE: 5.82
-------------  START gep_gen000_014 --------------
SynthDef('gep_gen000_014', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SawDPW.ar(k, i, h, b ))*( SawDPW.ar( SinOsc.ar( PinkNoise.ar(i, h ), j, d, d ),  SyncSaw.ar(e, k, d, l ), g, d ))*( SawDPW.ar(b, c,  Saw.ar(e, e, b ),  FSinOsc.ar(h, l, c, f ) ) )))) })
[ a, 0.57199505669285, b, 0.49047362804413, c, 4.4320809029685, d, 0.83987355232239, e, 6.2831853071796, f, 5.0911646397856, g, 2.1588086607184, h, 11.089085893184, i, 1.2338686070299, j, 0.54623597266371, k, 2.6577409758947, l, -0.61902010234636 ]
SCORE: 5.5
-------------  START gep_gen000_016 --------------
SynthDef('gep_gen000_016', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOscFB.ar(h, d, i, h ))*( Saw.ar( GrayNoise.ar( LFNoise0.ar( LFDNoise3.ar(e, c, a ), k, d ), f ), b, g ))*( LFDNoise0.ar( ClipNoise.ar( LFNoise2.ar(d, l, c ), e ), j,  SinOscFB.ar( SawDPW.ar(c, a, a, b ), b, d, i ) ) )))) })
[ a, 1.157131892837, b, 2.1997900539157, c, 306.70453784031, d, 167.95612003113, e, 31.383739710659, f, 1.8175339698792, g, 0.85637542061635, h, 0.86191642284393, i, 0.94977784156799, j, 0.036382107929999, k, 33.017794367667, l, 31.046348627526 ]
SCORE: 5.71
-------------  START gep_gen000_024 --------------
SynthDef('gep_gen000_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise0.ar(e, c,  BrownNoise.ar( Perlin3.ar(f, d, a ), l ) ))*( MostChange.ar( SinOsc.ar(a,  WhiteNoise.ar(c, i ), a,  LFNoise0.ar(b, b, c ) ),  LFTri.ar(g, l, f, c ) ))*( LFTri.ar(e, i,  LFCub.ar(k, i, j, f ), k ) )))) })
[ a, -0.97842574119568, b, 0.87542855739594, c, 96.394351336651, d, 0.9837418794632, e, 0.39475609909092, f, 1.0053445506377, g, 0.85917043685913, h, -0.31221878528595, i, 100, j, 0.19050952037662, k, 100, l, -0.55121068760171 ]
SCORE: 4.85
-------------  START gep_gen000_027 --------------
SynthDef('gep_gen000_027', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFTri.ar(b, f,  BrownNoise.ar(j,  MostChange.ar(d, l ) ),  SinTone.ar(g, c, b, j ) ))*( SinTone.ar(l,  Perlin3.ar( LFSaw.ar(a, b, e, a ),  BrownNoise.ar(d, d ), h ),  Perlin3.ar(f, a, k ),  LFDNoise0.ar(e, j, b ) ))*( SawDPW.ar( ClipNoise.ar(g,  SinOscFB.ar(b, g, a, h ) ),  Pulse.ar(b, a, i, i ),  LFCub.ar(a, a, g, l ),  LFNoise2.ar(i, f, b ) ) )))) })
[ a, 36.29501212143, b, 100, c, 0.69460776863285, d, 4.1500943115236, e, 0.60292927311281, f, 4.1500943115236, g, -1.7471459933079, h, 100, i, 0.8627552986145, j, 100, k, -0.59785002478276, l, 0.37098720179208 ]
SCORE: 5.82
-------------  START gep_gen000_028 --------------
SynthDef('gep_gen000_028', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar( LFNoise0.ar(c,  MostChange.ar(d, d ), h ),  LFCub.ar(i, b, f, d ), l, i ))*( SyncSaw.ar(b, h,  LFDNoise0.ar(b, d, g ),  LFCub.ar(f, k, j, k ) ))*( SinTone.ar(f, f, k,  ClipNoise.ar( GrayNoise.ar(k, f ),  LFPar.ar(h, h, e, b ) ) ) )))) })
[ a, 186.99220614104, b, 0.0018823820902882, c, 17176.956846947, d, 1.094267837471, e, 268.1561043269, f, 0.10001723736112, g, 0.10448227959663, h, 0.10089002686531, i, -0.69611823558807, j, -0.19569483231251, k, 12274.331408268, l, 1.8244233074442 ]
SCORE: 6.24
-------------  START gep_gen000_033 --------------
SynthDef('gep_gen000_033', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(c, l,  LFPar.ar(k,  Impulse.ar(i, f, c, k ), a, e ), j ))*( BrownNoise.ar(e, d ))*( LFDClipNoise.ar( LFDNoise3.ar( Perlin3.ar(l, f, c ),  Saw.ar(d, f, f ),  Perlin3.ar(c, f, g ) ),  LFDNoise3.ar(f, a, b ),  Pulse.ar(c, a, b, a ) ) )))) })
[ a, 0.060812237730172, b, 0.14192950725555, c, 4200, d, -0.10525274276733, e, 51.734119095126, f, 1, g, 1413.1483680708, h, -0.4045633933849, i, 289.65454902582, j, 6.9405278554936, k, 2068.5161851471, l, -0.57649712630247 ]
SCORE: 6.31





-------------  START gep_gen001_001 --------------
SynthDef('gep_gen001_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(f, i ))*( LFDNoise0.ar( LFDNoise0.ar( LFDNoise1.ar(l, b, c ), l,  SawDPW.ar(i, a, h, d ) ), h, h ))*( Impulse.ar( SinTone.ar( SinOsc.ar(k, c, j, l ), a, b, k ),  Perlin3.ar(d, b, d ),  PinkNoise.ar(g, b ),  Saw.ar(j, h, l ) ) )))) })
[ a, 26.335778574817, b, -0.97842574119568, c, 0.87542855739594, d, 96.394351336651, e, 0.9837418794632, f, 0.22495689005948, g, 1.7137359334683, h, 0.11799370398872, i, -0.55132376367406, j, 0.19152770815523, k, 100, l, -0.55121068760171 ]
SCORE: 5.65
-------------  START gep_gen001_016 --------------
SynthDef('gep_gen001_016', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOscFB.ar(h, d, i, h ))*( Saw.ar( GrayNoise.ar( LFNoise0.ar( LFDNoise3.ar(e, c, a ), k, d ), f ), b, g ))*( LFNoise2.ar( Dust.ar( ClipNoise.ar(c, c ), d, c ),  GrayNoise.ar(j, h ),  Saw.ar(g, c, e ) ) )))) })
[ a, 1.0453580222048, b, 0.10395359992981, c, 1.7846622467041, d, 1.8628959655762, e, 0.92924013053004, f, 0.39946781286836, g, 1.0795523157888, h, -0.32678460486581, i, 0.53244736528858, j, -0.60744485520855, k, 0.16458162509345, l, inf ]
SCORE: 5.5
-------------  START gep_gen001_019 --------------
SynthDef('gep_gen001_019', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(f, i ))*( LFDNoise0.ar( LFDNoise0.ar( LFDNoise1.ar(l, b, c ), l,  SawDPW.ar(i, a, h, d ) ), h, h ))*( Impulse.ar( SinTone.ar( SinOsc.ar(k, c, j, l ), a, b, k ),  Perlin3.ar(d, b, d ),  PinkNoise.ar(g, b ),  Saw.ar(j, h, l ) ) )))) })
[ a, 0.5, b, 1.3375980854034, c, 4.2250339962991, d, 5.411019999182, e, 0.74268579483032, f, 0.023021727048692, g, 0.087014743173199, h, 1.0924601554871, i, 1.0988485618533, j, 0.42002511024475, k, 0.75710122478768, l, 0.031586462565451 ]
SCORE: 5.65
-------------  START gep_gen001_029 --------------
SynthDef('gep_gen001_029', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(h, a, g, k ),  PinkNoise.ar(g, b ),  LeastChange.ar(a, k ), e ),  LFTri.ar(a, e, b, d ) ))*( LFDNoise0.ar(e, c,  BrownNoise.ar( Perlin3.ar(f, d, a ), l ) ))*( LFCub.ar(l, f,  LFNoise0.ar( LFClipNoise.ar(d, g, b ), a, a ),  FSinOsc.ar(c, d, e, b ) ) )))) })
[ a, 2.2998248043614, b, 0.78085947036743, c, -345.44475024951, d, -0.046170714609261, e, 0.38147938251495, f, 25, g, 0.53596729511793, h, 349.89941747576, i, 2.9795351135359, j, 0.61858065153393, k, 4.9696532644558, l, 98.146635129821 ]
SCORE: 5.93
-------------  START gep_gen001_031 --------------
SynthDef('gep_gen001_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise1.ar( LFNoise0.ar( ClipNoise.ar(e, j ),  LFNoise1.ar(e, a, l ), f ), k, d ))*( LFDNoise1.ar( BrownNoise.ar(k,  Dust.ar(j, d, b ) ),  LFClipNoise.ar( Blip.ar(h, a, a, b ), b, g ),  Dust2.ar(a, g, j ) ))*( SinOscFB.ar(a, j,  LFDClipNoise.ar(f, l, e ), e ) )))) })
[ a, 1.1908362332868, b, 0.096819162368774, c, -0.10221785448904, d, 0, e, 1.1221933364868, f, 1, g, -1.9053321671462, h, 0.79323542118073, i, -0.21367418766022, j, 37.211611017644, k, 0.19493759632809, l, -0.28339433146998 ]
SCORE: 5.58
-------------  START gep_gen001_037 --------------
SynthDef('gep_gen001_037', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SyncSaw.ar(f,  PinkNoise.ar( LFCub.ar(d, k, l, j ),  MostChange.ar(b, k ) ), i, d ))*( LFDNoise1.ar( GaussTrig.ar(b,  Blip.ar(g, h, e, l ), g, i ),  PinkNoise.ar(a, g ), e ))*( SinTone.ar(f, f, k,  ClipNoise.ar( GrayNoise.ar(f, j ), d ) ) )))) })
[ a, 0.088164946315317, b, 0, c, 0.012529751639505, d, 20, e, 0.78681445121765, f, 0.85127608003361, g, 0.17365203299653, h, 4586.4150018545, i, 6240.4122255209, j, 0.41355967521667, k, 0.17103160496532, l, 0 ]
SCORE: 5.68



-------------  START gep_gen002_001 --------------
SynthDef('gep_gen002_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise1.ar(d,  LFNoise0.ar(d,  ClipNoise.ar(e, j ),  LFNoise1.ar(e, a, l ) ), k ))*( LFDNoise1.ar( BrownNoise.ar( LFCub.ar(j, i, j, k ), b ),  LFClipNoise.ar(d, g, f ),  Dust2.ar(k, j, k ) ))*( SawDPW.ar(d, i, a, a ) )))) })
[ a, 1.3375980854034, b, 0.5, c, 4.2250339962991, d, 5.411019999182, e, 0.74268579483032, f, 0.023021727048692, g, 0.087014743173199, h, 1.0924601554871, i, 1.0988485618533, j, 0.42002511024475, k, 0.75710122478768, l, 0.031586462565451 ]
SCORE: 6.42
-------------  START gep_gen002_005 --------------
SynthDef('gep_gen002_005', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(h, a, g, k ),  PinkNoise.ar(g, b ),  LeastChange.ar(a, k ), e ),  LFTri.ar(a, e, b, d ) ))*( LFDNoise0.ar(e, c,  BrownNoise.ar( Perlin3.ar(f, d, a ), l ) ))*( LFCub.ar(l, f,  LFNoise0.ar( LFClipNoise.ar(d, g, b ), a, a ),  FSinOsc.ar(c, d, e, b ) ) )))) })
[ a, 56.111182490498, b, 1041.3342746645, c, 0.12756314819043, d, 0.028487944337888, e, 17.944106064467, f, 30.068883903805, g, 4200, h, 0.90023874674473, i, 0.12334108352661, j, -0.57005143165588, k, 1041.4149303585, l, -0.19563059229491 ]
SCORE: 5.7
-------------  START gep_gen002_008 --------------
SynthDef('gep_gen002_008', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( SyncSaw.ar( SinTone.ar(f, k, j, i ),  LFCub.ar(h, h, h, d ), l, i ),  Blip.ar(k, i, k, f ),  SyncSaw.ar(d, h, h, d ), j ))*( PinkNoise.ar( LFDNoise3.ar( Impulse.ar(d, h, k, d ), d,  WhiteNoise.ar(c, f ) ),  Pulse.ar(j, c, g, c ) ))*( LFPar.ar( PinkNoise.ar( LFDNoise3.ar(a, j, f ), f ),  LFDNoise0.ar(h, b, i ),  LFDNoise1.ar(b, g, k ), b ) )))) })
[ a, 299.91104497891, b, 0.21618330478668, c, -0.27088807334155, d, -0.74213039875031, e, 1.3995685771936, f, 1.6053255796432, g, 0.030676824529962, h, 648.80557770773, i, 1387.2997513608, j, 1.3995685771936, k, 1387.2997513608, l, 0.081805467605591 ]
SCORE: 6.18
-------------  START gep_gen002_009 --------------
SynthDef('gep_gen002_009', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(a,  Impulse.ar( Pulse.ar(b, j, f, i ),  MostChange.ar(j, h ), a,  Impulse.ar(c, d, l, d ) ) ))*( LeastChange.ar(i, f ))*( SinOscFB.ar(a, j,  LFDClipNoise.ar(f, l, e ), e ) )))) })
[ a, 20000, b, 2.162216411282, c, 20000, d, 20, e, 0.78681445121765, f, 0.85127608003361, g, 0.17365203299653, h, 4586.4150018545, i, 6240.4122255209, j, 0.41355967521667, k, 0.17103160496532, l, 0 ]
SCORE: 5.54
-------------  START gep_gen002_012 --------------
SynthDef('gep_gen002_012', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(h, a, g, k ),  PinkNoise.ar(g, b ),  LeastChange.ar(a, k ), e ),  LFTri.ar(a, e, b, d ) ))*( LFDNoise0.ar(e, c,  BrownNoise.ar( Perlin3.ar(f, d, a ), l ) ))*( LFCub.ar(l, f,  LFNoise0.ar( LFClipNoise.ar(d, g, b ), a, a ),  FSinOsc.ar(c, d, e, b ) ) )))) })
[ a, 0.25448274612427, b, 0.44437883676867, c, 151.47469046406, d, -0.37379749539266, e, 315.73009170372, f, 0.82420647144318, g, -0.51747381687164, h, 0.54407518448102, i, -0.023290641189971, j, 0.036100308437526, k, 2.846911055983, l, 0.57873407401393 ]
SCORE: 5.7
-------------  START gep_gen002_031 --------------
SynthDef('gep_gen002_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise0.ar( LFDNoise3.ar(l,  SinTone.ar(h, b, c, c ),  LFNoise1.ar(h, c, k ) ),  LFCub.ar(d, h, h, k ), d ))*( LFDNoise1.ar( LFCub.ar( LFNoise2.ar(g, a, d ), a, f, l ), e,  SyncSaw.ar(a, j, j, f ) ))*( SawDPW.ar(a,  ClipNoise.ar( Crackle.ar(b, k, i ), i ),  LFDNoise0.ar(l, h, i ), i ) )))) })
[ a, 31.383739710659, b, 1.157131892837, c, 2.1997900539157, d, 306.70453784031, e, 167.95612003113, f, 1.2780404090881, g, 0.85637542061635, h, 0.86191642284393, i, 0.94977784156799, j, 0.036382107929999, k, 33.017794367667, l, 31.046348627526 ]
SCORE: 5.43
-------------  START gep_gen002_032 --------------
SynthDef('gep_gen002_032', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar( LFNoise0.ar(c,  MostChange.ar(l, i ), h ),  LFCub.ar(i, b, f, d ), l, i ))*( SawDPW.ar(k, i, h, b ))*( SawDPW.ar(b, c,  Saw.ar(l, f, e ),  SawDPW.ar(h, e, c, f ) ) )))) })
[ a, 0.25448274612427, b, 0.44437883676867, c, 151.47469046406, d, -0.37379749539266, e, 315.73009170372, f, 0.82420647144318, g, -0.51747381687164, h, 0.54407518448102, i, -0.023290641189971, j, 0.036100308437526, k, 2.846911055983, l, 0.57873407401393 ]
SCORE: 5.36
-------------  START gep_gen002_034 --------------
SynthDef('gep_gen002_034', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SawDPW.ar( SinOsc.ar( PinkNoise.ar(d, d ), j, d, d ),  SyncSaw.ar(e, k, d, d ), g, d ))*( LFNoise1.ar( Crackle.ar(b,  FSinOsc.ar(l, f, c, h ),  LFClipNoise.ar(k, c, g ) ),  SawDPW.ar(l, c, c, j ), h ))*( SinTone.ar(f, f, k,  ClipNoise.ar( GrayNoise.ar(f, j ), d ) ) )))) })
[ a, 0.32887219486936, b, 0.66607440241912, c, 20000, d, 1.3060445206034, e, 0.96359395980835, f, 0.70078920413792, g, 0.76567068290904, h, 0.1, i, -0.91026079654694, j, 0.61385635238879, k, 2673.2241424535, l, 0.046148657798767 ]
SCORE: 5.54



-------------  START gep_gen003_002 --------------
SynthDef('gep_gen003_002', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(a,  Impulse.ar( Pulse.ar(b, j, f, i ),  MostChange.ar(j, h ), a,  Impulse.ar(c, d, l, d ) ) ))*( LFNoise0.ar( LFDNoise3.ar(l,  SinTone.ar(h, b, c, c ),  LFNoise1.ar(h, c, k ) ),  LFCub.ar(d, h, h, k ), d ))*( LFDNoise1.ar(e,  SyncSaw.ar(e,  SyncSaw.ar(e, e, k, j ),  SawDPW.ar(e, i, i, c ), e ),  LFCub.ar(h, k, c, f ) ) )))) })
[ a, -0.34540915489197, b, 0.5, c, 20000, d, 0.90148652873049, e, -0.48287117481232, f, -346.98687259497, g, 0.15528060590867, h, 4586.4150018545, i, 0.70357382297516, j, 0.48287117481232, k, 92.649246714702, l, 0.28883649575644 ]
SCORE: 5.89
-------------  START gep_gen003_007 --------------
SynthDef('gep_gen003_007', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(a,  Impulse.ar( Pulse.ar(b, j, f, i ),  MostChange.ar(j, h ), a,  Impulse.ar(c, d, l, d ) ) ))*( LFNoise0.ar( LFDNoise3.ar(l,  SinTone.ar(h, b, c, c ),  LFNoise1.ar(h, c, k ) ),  LFCub.ar(d, h, h, k ), d ))*( LFDNoise1.ar(e,  SyncSaw.ar(e,  SyncSaw.ar(e, e, k, j ),  SawDPW.ar(e, i, i, c ), e ),  LFCub.ar(h, k, c, f ) ) )))) })
[ a, 2.3245420868822, b, 2.1942441689057, c, 1.596333598914, d, 0.97581720352173, e, 2.5961171747695, f, 0.31269303513298, g, 0.15915494309189, h, 2.5961171747695, i, 2.4505966162886, j, 0.89539182186127, k, 0.48903347952306, l, 0 ]
SCORE: 5.89
-------------  START gep_gen003_008 --------------
SynthDef('gep_gen003_008', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  Blip.ar( LFNoise2.ar(i,  SawDPW.ar(k, a, e, a ), d ), b,  LFClipNoise.ar(i, j, l ), c ))*( Dust.ar( SinOscFB.ar(c, g, l, g ),  GrayNoise.ar(e, a ),  SinTone.ar(j, i, h, h ) ))*( LFTri.ar(f, f,  LFPar.ar(d,  LFPar.ar(e, c, a, a ), d, f ),  LFTri.ar(j, c, l, e ) ) )))) })
[ a, 299.91104497891, b, 0.21618330478668, c, -0.27088807334155, d, -0.031434951206776, e, 0.15378211735875, f, 0.1, g, 0.030676824529962, h, 0.15369132465438, i, 5.5065481233167, j, 0.17741061890506, k, 19.147085714722, l, 0.94286824951917 ]
SCORE: 5.4
-------------  START gep_gen003_017 --------------
SynthDef('gep_gen003_017', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( SyncSaw.ar( SinTone.ar(d, c, a, a ),  LFCub.ar(b, g, d, c ), l, i ),  Blip.ar(k, i, a, g ),  SyncSaw.ar(f, l, b, g ), j ))*( LFNoise1.ar( Crackle.ar(b,  FSinOsc.ar(d, l, i, d ),  LFClipNoise.ar(b, g, g ) ),  SawDPW.ar(l, c, b, f ), h ))*( SinOscFB.ar(a, j,  LFDClipNoise.ar(f, l, e ), e ) )))) })
[ a, 4200, b, 4200, c, 4.3791623595845, d, 25, e, 0.080655694007874, f, 9.4706421590219, g, 29.376762987609, h, 0.72783148288727, i, 0.88561153411865, j, 0.23663974456837, k, 1041.3342746645, l, 246.60886966586 ]
SCORE: 4.97
-------------  START gep_gen003_024 --------------
SynthDef('gep_gen003_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(a,  Impulse.ar( Pulse.ar(b, j, f, i ),  MostChange.ar(j, h ), a,  Impulse.ar(c, d, l, d ) ) ))*( LFNoise0.ar( LFDNoise3.ar(l,  SinTone.ar(h, b, c, c ),  LFNoise1.ar(h, c, k ) ),  LFCub.ar(d, h, h, k ), d ))*( LFDNoise1.ar(e,  SyncSaw.ar(e,  SyncSaw.ar(e, e, k, j ),  SawDPW.ar(e, i, i, c ), e ),  LFCub.ar(h, k, c, f ) ) )))) })
[ a, 0.036382107929999, b, 31.383739710659, c, 1.157131892837, d, 2.1997900539157, e, 306.70453784031, f, 167.95612003113, g, 1.2780404090881, h, 0.85637542061635, i, 0.86191642284393, j, 0.94977784156799, k, 33.017794367667, l, 31.046348627526 ]
SCORE: 5.89
-------------  START gep_gen003_028 --------------
SynthDef('gep_gen003_028', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(a,  Impulse.ar( Pulse.ar(b, j, f, i ),  MostChange.ar(j, h ), a,  Impulse.ar(c, d, l, d ) ) ))*( LFNoise0.ar( LFDNoise3.ar(l,  SinTone.ar(h, b, c, c ),  LFNoise1.ar(h, c, k ) ),  LFCub.ar(d, h, h, k ), d ))*( LFDNoise1.ar(e,  SyncSaw.ar(e,  SyncSaw.ar(e, e, k, j ),  SawDPW.ar(e, i, i, c ), e ),  LFCub.ar(h, k, c, f ) ) )))) })
[ a, 299.91104497891, b, 0.21618330478668, c, -0.27088807334155, d, -0.031434951206776, e, 0.15378211735875, f, 0.1, g, 0.030676824529962, h, 0.15369132465438, i, 5.5065481233167, j, 0.17741061890506, k, 19.147085714722, l, 0.94286824951917 ]
SCORE: 5.89




-------------  START gep_gen004_001 --------------
SynthDef('gep_gen004_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( PinkNoise.ar( LFDNoise3.ar(a, j, f ), f ),  LFDNoise0.ar(h, b, i ),  LFDNoise1.ar(b, g, k ), b ))*( LFDNoise0.ar(i,  LFPar.ar(k, l, j, j ),  LFSaw.ar(e, h, e, i ) ))*( ClipNoise.ar( BrownNoise.ar( LFPar.ar(d,  PinkNoise.ar(k, h ), f, j ), f ), g ) )))) })
[ a, 4.1878812004831, b, 6.0650763302564, c, -2579.8886476878, d, -0.48287117481232, e, 348.10400609317, f, 0.78681445121765, g, 20, h, 0.43556635798827, i, 6240.4122255209, j, 0.38224347721425, k, 1.2003741264343, l, 130.56544923038 ]
SCORE: 6.69
-------------  START gep_gen004_009 --------------
SynthDef('gep_gen004_009', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SyncSaw.ar(b, h,  LFDNoise0.ar(h,  LeastChange.ar(a, e ), e ), c ))*( LFDNoise0.ar(c,  Dust.ar( GrayNoise.ar(i, e ),  SinTone.ar(k, a, j, f ), c ),  SinOscFB.ar(g, e, a, j ) ))*( LFDNoise1.ar(k, h, f ) )))) })
[ a, 4.1878812004831, b, 6.0650763302564, c, -2579.8886476878, d, -0.48287117481232, e, 348.10400609317, f, 0.78681445121765, g, 20, h, 0.43556635798827, i, 6240.4122255209, j, 0.38224347721425, k, 1.2003741264343, l, 130.56544923038 ]
SCORE: 5.62
-------------  START gep_gen004_011 --------------
SynthDef('gep_gen004_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(h, d, f, d ),  PinkNoise.ar(g, b ),  SawDPW.ar(b, c, d, a ), l ),  LFTri.ar(b, c, i, a ) ))*( ClipNoise.ar( Dust2.ar(k,  Perlin3.ar(j, l, f ), l ),  SawDPW.ar(f, d, a, c ) ))*( SinTone.ar(g,  SinTone.ar(f, k, f, j ), f, f ) )))) })
[ a, 5.0314802820243, b, 4.3879220831846, c, 6.2831853071796, d, -0.21754765510559, e, 0.5, f, 1.8309605029749, g, -4.4689883461572, h, 0.2099229027117, i, 5.1442719834396, j, 0.97807431221008, k, 0.27358188289492, l, 0 ]
SCORE: 5
-------------  START gep_gen004_015 --------------
SynthDef('gep_gen004_015', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar(l, a ))*( LFNoise0.ar( LFDNoise3.ar(l, k,  LFNoise1.ar(h, b, c ) ),  LFCub.ar(d, h, h, k ), d ))*( SinTone.ar( Perlin3.ar( Perlin3.ar(b, e, a ),  PinkNoise.ar(d, i ), b ),  PinkNoise.ar(k, d ),  WhiteNoise.ar(b, f ),  SinTone.ar(g, a, d, g ) ) )))) })
[ a, 0.0012043511032196, b, 1387.2997513608, c, 0.010028502138198, d, 0.0071295689527911, e, 166.61517700065, f, 2.1384121374124, g, 0.25544261932373, h, -3.5752182884323, i, 0.0071870412818984, j, 0.0084872083602789, k, 19.147085714722, l, 0.25705912504957 ]
SCORE: 5.47
-------------  START gep_gen004_022 --------------
SynthDef('gep_gen004_022', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  Blip.ar( LFNoise2.ar(i,  SawDPW.ar(k, a, e, a ), d ), b,  LFClipNoise.ar(i, j, l ), c ))*( SinTone.ar(e, c,  BrownNoise.ar(h, b ), i ))*( LFTri.ar(f, f,  LFPar.ar(d,  LFPar.ar(e, c, a, a ), d, f ),  LFTri.ar(j, c, l, e ) ) )))) })
[ a, 0.0012043511032196, b, 1387.2997513608, c, 0.010028502138198, d, 0.0071295689527911, e, 166.61517700065, f, 2.1384121374124, g, 0.25544261932373, h, -3.5752182884323, i, 0.0071870412818984, j, 0.0084872083602789, k, 19.147085714722, l, 0.25705912504957 ]
SCORE: 5.96
-------------  START gep_gen004_033 --------------
SynthDef('gep_gen004_033', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  Blip.ar( LFNoise2.ar(i,  SawDPW.ar(k, a, e, a ), d ), b,  LFClipNoise.ar(i, j, l ), c ))*( SinTone.ar(e, c,  BrownNoise.ar(h, b ), i ))*( LFTri.ar(f, f,  LFPar.ar(d,  LFPar.ar(e, c, a, a ), d, f ),  LFTri.ar(j, c, l, e ) ) )))) })
[ a, 0.0012043511032196, b, 1387.2997513608, c, 0.010028502138198, d, 0.0071295689527911, e, 166.61517700065, f, 2.1384121374124, g, 0.25544261932373, h, -3.5752182884323, i, 0.0071870412818984, j, 0.0084872083602789, k, 19.147085714722, l, 0.25705912504957 ]
SCORE: 5.96
-------------  START gep_gen004_038 --------------
SynthDef('gep_gen004_038', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  SyncSaw.ar(b, h,  LFDNoise0.ar(h,  LeastChange.ar(a, e ), e ), c ))*( LFDNoise0.ar(c,  Dust.ar( GrayNoise.ar(i, e ),  SinTone.ar(k, a, j, f ), c ),  SinOscFB.ar(g, e, a, j ) ))*( LFDNoise1.ar(k, h, f ) )))) })
[ a, 4.1878812004831, b, 6.0650763302564, c, -2579.8886476878, d, -0.48287117481232, e, 348.10400609317, f, 0.78681445121765, g, 20, h, 0.43556635798827, i, 6240.4122255209, j, 0.38224347721425, k, 1.2003741264343, l, 130.56544923038 ]
SCORE: 5.62


-------------  START gep_gen005_018 --------------
SynthDef('gep_gen005_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  Blip.ar( LFNoise2.ar( Impulse.ar(f, j, c, d ),  Pulse.ar(f, i, b, h ), h ), b,  LFClipNoise.ar(j, f, a ), c ))*( SinTone.ar(e, c,  BrownNoise.ar(h,  Perlin3.ar(b, k, l ) ), i ))*( LFDNoise1.ar(k, h, f ) )))) })
[ a, 2.1829322935591, b, 6.5444251968711, c, 0.824762930408, d, 2.5961171747695, e, 0.8452022852553, f, 1, g, 0.43176415110359, h, 2.1942441689057, i, -0.26879942417145, j, 5.6259127392875, k, 6.1312403156608, l, 1.3085767030716 ]
SCORE: 5.97
-------------  START gep_gen005_038 --------------
SynthDef('gep_gen005_038', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise1.ar(a,  SinOsc.ar( GaussTrig.ar(a, e, a, l ),  PinkNoise.ar(d, f ),  SawDPW.ar(f, l, b, f ), l ),  LFTri.ar(b, c, i, k ) ))*( SinTone.ar(a,  Perlin3.ar( SinTone.ar(g, a, d, g ), b, k ),  PinkNoise.ar(k, d ),  WhiteNoise.ar(b, f ) ))*( LFNoise0.ar( LFDNoise3.ar( LFCub.ar(k, h, b, c ),  LFNoise0.ar(b, k, c ), i ), d,  LFDNoise3.ar(d, h, h ) ) )))) })
[ a, 119.09139950444, b, 31.383739710659, c, 2070.001330011, d, 0.99325680732727, e, 0.5, f, 2586.5731828075, g, -0.38125160950891, h, 0.94977784156799, i, 31.383739710659, j, 0.044382452964783, k, 140.84437843532, l, 4200 ]
SCORE: 5.84
