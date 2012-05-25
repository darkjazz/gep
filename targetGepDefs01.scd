-------------  START gep_gen000_003 --------------
SynthDef('gep_gen000_003', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Dust.ar(e,  FSinOsc.ar(l, h, n,  SinOsc.ar(m, g, d, h ) ), k ))*( LFSaw.ar( LFCub.ar( LFSaw.ar(a, a, b, g ), k,  Impulse.ar(j, l, j, j ),  LFDNoise1.ar(m, c, d ) ),  LFNoise0.ar(g, a, i ), b, f ))*( LFNoise0.ar( ClipNoise.ar(n, k ), b,  LFNoise2.ar( StkPluck.ar(g, b, e, a ),  Pulse.ar(i, g, e, l ), k ) ) )))) })
[ a, 183.4756992393, b, 416.59944517354, c, 1224.2814888531, d, -0.022652745246887, e, 0.3930743932724, f, 1.4527526178124, g, 1.5767166202904, h, 55.591269451638, i, 166.26889704099, j, 1224.2814888531, k, 0.91538190841675, l, 0.39974652510757, m, 416.96986682157, n, 0.67467434648917 ]
SCORE: 5.72
-------------  START gep_gen000_012 --------------
SynthDef('gep_gen000_012', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c,  GaussTrig.ar( SinOsc.ar(b, f, k, e ), i, m,  LFNoise0.ar(i, a, j ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, j, b ) ))*( Dust2.ar( ClipNoise.ar( GrayNoise.ar(j, b ),  SinTone.ar(m, i, l, m ) ), m,  SawDPW.ar( BrownNoise.ar(c, j ), b, a, c ) ))*( SinTone.ar( StkPluck.ar(m, n,  StkPluck.ar(i, g, h, f ),  ClipNoise.ar(m, b ) ),  SyncSaw.ar(e, n, l, h ), g, l ) )))) })
[ a, 0.13475263118744, b, 100, c, 1.0947344534244, d, 0.033130295145241, e, 100, f, 0.69287252426147, g, 2.5709053624997, h, 0.033130295145241, i, -0.2116836309433, j, 1.1347526311874, k, 0.34643626213074, l, 0.0031794912366695, m, 0.2116836309433, n, 0.57675364478303 ]
SCORE: 5.14
-------------  START gep_gen000_013 --------------
SynthDef('gep_gen000_013', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LeastChange.ar( LFNoise2.ar(g,  LFPar.ar( SinTone.ar(d, i, c, b ), h, f, n ),  Pulse.ar(n, n, h, k ) ), f ))*( BrownNoise.ar( LFDNoise1.ar(l, b, n ),  LFTri.ar( MostChange.ar(m, j ), i,  Blip.ar(i, h, f, h ), e ) ))*( LFCub.ar(d, n,  PinkNoise.ar( LFTri.ar(d, i, i, e ),  LFClipNoise.ar(h, b, n ) ), k ) )))) })
[ a, 0.5453641467943, b, 1.239471912384, c, 4.9989030266797, d, 0.26088178157806, e, 1, f, 0.61915292196666, g, 3.8991679915902, h, 8.5018542690376, i, 2.3870470818196, j, 3.5556373998482, k, -3.3688440093514, l, 2.9682291079064, m, 0.14601788464786, n, 0.55258798599243 ]
SCORE: 5.27
-------------  START gep_gen000_017 --------------
SynthDef('gep_gen000_017', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  ClipNoise.ar( BrownNoise.ar( StkPluck.ar(l, j, a, e ), g ),  Impulse.ar( Dust2.ar(k, d, m ), n,  GaussTrig.ar(a, b, b, a ), j ) ))*( SinOsc.ar(m, i, i,  Perlin3.ar( ClipNoise.ar(n, l ),  SinTone.ar(a, a, c, j ), h ) ))*( LeastChange.ar(f, k ) )))) })
[ a, 0.14125154441177, b, 0.25208483305777, c, 0.37743909448125, d, 2.903741790449, e, 0.3536463122332, f, 0.1833301114435, g, 8.168068954411, h, 15.389654990922, i, 1.442696928978, j, -0.37663543224335, k, -1.2237750781505, l, -0.13384890556335, m, -7.4539952194433, n, 100 ]
SCORE: 5.72
-------------  START gep_gen000_022 --------------
SynthDef('gep_gen000_022', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( LFDClipNoise.ar(h, e,  LFPar.ar(a, c, e, i ) ),  Dust2.ar(l, k, b ), h,  FSinOsc.ar(a, c, k, f ) ))*( LFDNoise3.ar(a, m, e ))*( LFDNoise3.ar( SyncSaw.ar( WhiteNoise.ar( FSinOsc.ar(d, b, n, m ), e ), i, j, l ), k, d ) )))) })
[ a, 398.90939117745, b, 0.069697643488949, c, 73.15236422527, d, -0.071599323242083, e, 0.31491647846599, f, 0.36885190010071, g, 0.12497486211817, h, 146.67099590786, i, 0.045613554536873, j, 20, k, 0.91591930389404, l, 1.091799240117, m, 11188.913267035, n, 0.72171950340271 ]
SCORE: 5.05
-------------  START gep_gen000_024 --------------
SynthDef('gep_gen000_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(i,  Crackle.ar( LFNoise1.ar(k, h, a ), n,  Saw.ar(h, n, j ) ),  LFDNoise0.ar(g, l, d ),  Pulse.ar(h, i, h, g ) ))*( SinTone.ar(a,  SawDPW.ar( Blip.ar(a, b, l, h ), c,  MostChange.ar(g, i ),  LeastChange.ar(b, d ) ), b, f ))*( LFDNoise3.ar(a, i,  LFSaw.ar( Dust.ar( FSinOsc.ar(d, a, i, i ), e, b ), k, e,  LFNoise2.ar(f, k, f ) ) ) )))) })
[ a, 86.20630537136, b, 0.1, c, 1.2447426319122, d, -0.81904971599579, e, 71.406522707109, f, 0, g, 0.87116277217865, h, -1.5527692431145, i, 0.027896252962457, j, -1.9190098047256, k, 1, l, 0.57970622151759, m, 1.74888920784, n, 0.49355366362545 ]
SCORE: 4.97
-------------  START gep_gen000_026 --------------
SynthDef('gep_gen000_026', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar(e,  GrayNoise.ar(g, m ) ))*( Blip.ar( Blip.ar( LFNoise0.ar(e, e, h ), m, k, d ),  LFDNoise0.ar(h, c, n ), h, k ))*( SawDPW.ar(k,  FSinOsc.ar( LFNoise2.ar(i, h, b ),  LFDClipNoise.ar(e, n, a ), a,  LFCub.ar(c, a, i, g ) ), n, m ) )))) })
[ a, 2.7796025899921, b, 20, c, 0.24307329520019, d, 0.031479452495674, e, -0.69496327466699, f, 673.61781072974, g, -0.49310952253076, h, 2329.3805036727, i, 0.54292936002236, j, 1.6473654777128, k, 1983.1746944747, l, 20, m, 131.1976562133, n, 0.00185861742995 ]
SCORE: 5.71
-------------  START gep_gen000_029 --------------
SynthDef('gep_gen000_029', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GrayNoise.ar(k, d ))*( SinOsc.ar(j,  PinkNoise.ar(g,  Dust2.ar(d, b, m ) ), f, c ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, c, a, h ),  LFNoise1.ar(e, b, i ), h, i ) ) )))) })
[ a, 1.3883371353149, b, -0.34149388272311, c, 1.836398209288, d, 2.3423772288737, e, -0.42691671848297, f, 0.77899870596017, g, 1.1745855498791, h, 3.4433906403673, i, 2.6823968529615, j, 3.6823968529615, k, 0.91689133644104, l, 3.4433906403673, m, 0.91689133644104, n, 0.29825203365769 ]
SCORE: 5.54
-------------  START gep_gen000_031 --------------
SynthDef('gep_gen000_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(f, n,  Impulse.ar( LFPar.ar( Dust2.ar(e, i, a ), j, g, c ),  SawDPW.ar(j, a, a, m ),  Saw.ar(l, d, g ),  BrownNoise.ar(c, d ) ) ))*( SinTone.ar(g,  BrownNoise.ar( LFSaw.ar(a,  LFPar.ar(e, n, j, a ), d, k ),  SinOsc.ar(k, m, j, l ) ), k, l ))*( Saw.ar(i,  Dust.ar(k,  Blip.ar(h, b, b, d ), h ),  WhiteNoise.ar( LFNoise0.ar(k, d, f ),  Impulse.ar(i, e, c, g ) ) ) )))) })
[ a, 0.81896886664306, b, 1.1586921487452, c, 0.44800522446224, d, 0.76808800864234, e, -0.26870251121596, f, 26.965526567153, g, 44.802676225024, h, 2.4208389266101, i, 1.8550522327423, j, -0.041335829907496, k, 100, l, 60.48816321509, m, 100, n, 0.92752611637115 ]
SCORE: 6.49
-------------  START gep_gen000_032 --------------
SynthDef('gep_gen000_032', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar( BrownNoise.ar( FSinOsc.ar(e, n, k, l ), l ), l, h,  BrownNoise.ar(e, c ) ))*( Pulse.ar(e, i,  PinkNoise.ar(g, a ),  SinOsc.ar( Perlin3.ar(n, f, m ), n, k, b ) ))*( LFNoise1.ar( LFNoise0.ar(i,  MostChange.ar(m, a ),  LFTri.ar(a, l, i, b ) ),  LFNoise2.ar(f,  Pulse.ar(k, k, f, k ), h ), n ) )))) })
[ a, 4.8369230534887, b, 0.11314749717712, c, -0.86786472693348, d, -0.38754680106178, e, 3.2031436327037, f, 0, g, 0.33509405135252, h, 0.71092669180745, i, 0.027664414048252, j, -0.22117744785845, k, 0.07430087429583, l, -0.16415085489058, m, 0.71092669180745, n, 0.12224934151635 ]
SCORE: 5.64
-------------  START gep_gen000_038 --------------
SynthDef('gep_gen000_038', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise1.ar( LFDNoise1.ar( WhiteNoise.ar(j, a ),  SinOscFB.ar(h, a, e, i ),  LeastChange.ar(m, d ) ), g,  SyncSaw.ar( SyncSaw.ar(h, b, c, l ),  Dust.ar(l, e, h ), l, m ) ))*( PinkNoise.ar( ClipNoise.ar(d,  WhiteNoise.ar( LFNoise0.ar( ClipNoise.ar(m, j ), b, b ), f ) ), f ))*( LFPar.ar( Dust2.ar( LFTri.ar(i, c, k, f ),  LFDClipNoise.ar(l, c, k ), e ), i, b,  SawDPW.ar(l, b, k, e ) ) )))) })
[ a, 0.35253179073334, b, 0.012068337720024, c, 98.331849181451, d, 14.565908695198, e, 0.19378173351288, f, 2.8135326125177, g, 0.64133322178891, h, 33.353867893634, i, -0.18758710183705, j, 0.99727916717529, k, -0.33950427294533, l, 0.12667764908796, m, -0.032870752744619, n, 0.35253179073334 ]
SCORE: 5.97




-------------  START gep_gen001_008 --------------
SynthDef('gep_gen001_008', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar(j,  BrownNoise.ar( BrownNoise.ar(l, e ),  FSinOsc.ar(e, n, k, l ) ), l, h ))*( Pulse.ar(e, i,  PinkNoise.ar(g, a ),  SinOsc.ar( Perlin3.ar(n, f, m ), n, k, b ) ))*( LFNoise1.ar( LFNoise0.ar(i,  MostChange.ar(m, a ),  LFTri.ar(a, l, i, b ) ),  LFNoise2.ar(f,  Pulse.ar(k, k, f, k ), h ), n ) )))) })
[ a, 0.35308253765106, b, 20000, c, 1390.8024486432, d, 0.6574172177406, e, 20000, f, 1.5631926059723, g, 2.2136362454678, h, 0.6574172177406, i, -0.42851376533508, j, 1.3530825376511, k, 0.78159630298614, l, 0.92923149007432, m, 0.067225418892207, n, 1.0674806833267 ]
SCORE: 5.4
-------------  START gep_gen001_012 --------------
SynthDef('gep_gen001_012', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  FSinOsc.ar(f, m, k,  Perlin3.ar( LFDNoise3.ar( LFDClipNoise.ar(i, c, b ), h, i ), d,  LFNoise2.ar(k, d, m ) ) ))*( Saw.ar( SinOscFB.ar(a,  SawDPW.ar( GaussTrig.ar(j, m, h, f ), b, f, a ),  StkPluck.ar(c, j, d, g ),  Crackle.ar(n, f, j ) ), b, b ))*( PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ) )))) })
[ a, 0.018578380640285, b, 2.2891817092896, c, 0.48534102607141, d, -1852.8427379624, e, 0.1, f, 1.3991057872772, g, 1.640742166935, h, -0.94746353220704, i, 0.22920835018158, j, 0.20035557827951, k, 0.41226022916638, l, 64.633676193705, m, -0.68200601557453, n, 0.045923171547123 ]
SCORE: 6.36
-------------  START gep_gen001_015 --------------
SynthDef('gep_gen001_015', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise0.ar( LFPar.ar( Perlin3.ar( LFTri.ar(k, m, m, n ), d, g ),  LFDNoise0.ar(d, i, e ),  SinOscFB.ar(c, g, m, m ),  LFDClipNoise.ar(g, g, b ) ), f, g ))*( Perlin3.ar( MostChange.ar( SinTone.ar( ClipNoise.ar(c, a ),  LFTri.ar(e, j, l, e ),  SinOscFB.ar(n, j, a, d ), c ), n ), b, d ))*( Saw.ar(i,  Dust.ar(k,  Blip.ar(h, b, b, d ), h ),  WhiteNoise.ar( LFNoise0.ar(k, d, f ),  Impulse.ar(i, e, c, g ) ) ) )))) })
[ a, 0.76902694325858, b, 0.81382209528238, c, 46.660062104105, d, 2.978923075168, e, 0.1329550743103, f, 1.1568495035172, g, 0.1, h, 4.351313957363, i, 2.6987990140915, j, 5.0518131890885, k, 47.174475580095, l, 0.52868059997162, m, 1.2232989695622, n, 46.660062104105 ]
SCORE: 5.78
-------------  START gep_gen001_017 --------------
SynthDef('gep_gen001_017', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar(j,  BrownNoise.ar( BrownNoise.ar(l, e ),  FSinOsc.ar(e, n, k, l ) ), l, h ))*( Pulse.ar(e, i,  PinkNoise.ar(g, a ),  SinOsc.ar( Perlin3.ar(n, f, m ), n, k, b ) ))*( LFNoise1.ar( LFNoise0.ar(i,  MostChange.ar(m, a ),  LFTri.ar(a, l, i, b ) ),  LFNoise2.ar(f,  Pulse.ar(k, k, f, k ), h ), n ) )))) })
[ a, 20000, b, 0.60353708267212, c, 0.2858259510628, d, 75.13891826772, e, 0.41063141822815, f, 1.6839853514889, g, 0, h, 0.13380908027753, i, 0.44335818517267, j, 1988.7693449025, k, -0.58807456493378, l, 344.19638192708, m, 20000, n, 1293.1271904832 ]
SCORE: 5.4
-------------  START gep_gen001_023 --------------
SynthDef('gep_gen001_023', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFTri.ar( Dust.ar(h,  LFSaw.ar(h, f, n, k ),  Impulse.ar(f, m, k, j ) ),  SinTone.ar( BrownNoise.ar(f, f ), f, h, m ), k,  Blip.ar(a, d, b, k ) ))*( StkPluck.ar(i,  LFSaw.ar(j, f,  SinTone.ar(e, g, n, f ), g ), i,  BrownNoise.ar(g, g ) ))*( LFDNoise3.ar( GrayNoise.ar( Perlin3.ar(l, l, m ),  Dust.ar(d, i, l ) ),  MostChange.ar( GrayNoise.ar(i, f ),  SawDPW.ar(d, k, m, h ) ), l ) )))) })
[ a, 4.8369230534887, b, 0.11314749717712, c, -0.86786472693348, d, -0.38754680106178, e, 3.2031436327037, f, 0, g, 0.33509405135252, h, 0.71092669180745, i, 0.027664414048252, j, -0.22117744785845, k, 0.07430087429583, l, -0.16415085489058, m, 0.71092669180745, n, 0.12224934151635 ]
SCORE: 6.29
-------------  START gep_gen001_031 --------------
SynthDef('gep_gen001_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(f, n,  Impulse.ar( LFPar.ar( Dust2.ar(k, m, n ), j, g, c ),  SawDPW.ar(j, a, a, m ),  Saw.ar(l, d, g ),  BrownNoise.ar(c, d ) ) ))*( Crackle.ar(n,  ClipNoise.ar( LFTri.ar(h, n, i, k ), l ),  BrownNoise.ar( Saw.ar(f, m, a ),  LFNoise1.ar(m, d, i ) ) ))*( LFDNoise0.ar( Saw.ar(d, e, n ), a,  LFDClipNoise.ar(g, n, b ) ) )))) })
[ a, 0.29561134616111, b, -0.15826915250471, c, 0.57612860202789, d, -7.510014155922, e, 0.49427023058745, f, 0.34823967214884, g, 5.3503945135343, h, 13.96108098087, i, 2.5107632334197, j, 3.0127363482634, k, 0.4827948953087, l, -6.1277812058679, m, 8.3789990935899, n, 0.71497301540449 ]
SCORE: 6.48
-------------  START gep_gen001_033 --------------
SynthDef('gep_gen001_033', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar( LFNoise0.ar( LFDNoise1.ar(g, c, l ), n, h ),  SawDPW.ar( GrayNoise.ar(j, i ), j, d, m ) ))*( LFDNoise3.ar(e,  Impulse.ar( GrayNoise.ar(h, d ), n, f, e ), k ))*( LFSaw.ar(l, g,  LFSaw.ar(d, n, n,  StkPluck.ar(h, c, h, m ) ), n ) )))) })
[ a, 0.35253179073334, b, 0.012068337720024, c, 0.54631352424622, d, 14.565908695198, e, 0.19378173351288, f, 2.8135326125177, g, 0.64133322178891, h, 33.353867893634, i, -0.18758710183705, j, 0.99727916717529, k, -0.33950427294533, l, 0.12667764908796, m, 0.93017508275038, n, 0.013267588713859 ]
SCORE: 5.38



-------------  START gep_gen002_001 --------------
SynthDef('gep_gen002_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFClipNoise.ar( SinOsc.ar(d, d, k, k ), h,  GrayNoise.ar(f, k ) ))*( Perlin3.ar( SinTone.ar(e,  Blip.ar(i, m, h, m ),  SinOscFB.ar(j, g, l, a ),  GaussTrig.ar(f, m, a, m ) ), b, a ))*( StkPluck.ar( LFPar.ar( Blip.ar(h, d, j, g ),  Dust2.ar(n, g, h ), k,  LeastChange.ar(m, m ) ),  MostChange.ar(d, k ),  Impulse.ar(f, i, k, g ),  LFCub.ar(h, n, a, c ) ) )))) })
[ a, 0.68063039909297, b, 0.66086274908142, c, 25.281631098441, d, 0.44800522446224, e, 0.76808800864234, f, -0.88296043872833, g, 44.802676225024, h, 1.9511579020587, i, 2.4848304986954, j, 0.0098580900780048, k, 1, l, 0, m, 100, n, 3.3677909374237 ]
SCORE: 6
-------------  START gep_gen002_002 --------------
SynthDef('gep_gen002_002', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c,  GaussTrig.ar( SinOsc.ar(b, f, k, e ), i, m,  LFNoise0.ar(i, a, d ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, j, b ) ))*( SinTone.ar(f,  Saw.ar( BrownNoise.ar(l, g ),  LeastChange.ar(n, j ), e ),  MostChange.ar( Crackle.ar(n, n, k ), g ), a ))*( ClipNoise.ar( StkPluck.ar(g, l, m, n ),  SyncSaw.ar( StkPluck.ar(l, h, i, g ),  ClipNoise.ar(h, f ), e, n ) ) )))) })
[ a, 0.86882947384918, b, 1.6153409751211, c, -0.1025687456131, d, 0.53124164479556, e, 1.0855179980042, f, 1.289166738032, g, 0.15899622440338, h, -0.57930076122284, i, -0.52287328243256, j, -0.12953817844391, k, -0.029458045959473, l, 0, m, 5.2446383133406, n, -5.0036091261342 ]
SCORE: 6.27
-------------  START gep_gen002_005 --------------
SynthDef('gep_gen002_005', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  FSinOsc.ar(f, m, k,  Perlin3.ar( LFDNoise3.ar( LFDClipNoise.ar(i, c, b ), h, i ), d,  LFNoise2.ar(k, d, m ) ) ))*( StkPluck.ar(i,  LFSaw.ar(j, f,  SinTone.ar(e, g, n, f ), g ), i,  BrownNoise.ar(g, g ) ))*( PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ) )))) })
[ a, 0.54807896579336, b, 0.23257822248372, c, -0.11911356449127, d, 0.56169784069061, e, 27.752284064688, f, 44.537657793734, g, 0.06690583197171, h, 27.071472659506, i, -0.038261254420007, j, 123.9117311844, k, -0.092946293785592, l, 123.9117311844, m, 123.83644491521, n, 0.062898507654012 ]
SCORE: 6.42
-------------  START gep_gen002_009 --------------
SynthDef('gep_gen002_009', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar( Pulse.ar(n,  BrownNoise.ar( SinTone.ar(k, l, h, g ),  LFNoise2.ar(l, f, i ) ),  Dust.ar(n, a, k ), b ), g ))*( SinOsc.ar(j,  PinkNoise.ar(g,  Dust2.ar(d, b, m ) ), f, c ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, c, a, h ),  LFNoise1.ar(e, b, i ), h, i ) ) )))) })
[ a, 8.3789990935899, b, 0.29561134616111, c, -0.15826915250471, d, 0.57612860202789, e, 0.28476321697235, f, 1.1558996507331, g, 0.18242500764093, h, 0.83799848438236, i, -0.43020979843214, j, 0.64106404781342, k, -0.01480014458653, l, -0.28476321697235, m, -8.1510782037354, n, 100 ]
SCORE: 6.44
-------------  START gep_gen002_010 --------------
SynthDef('gep_gen002_010', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Dust.ar(n,  LFNoise1.ar( Saw.ar( BrownNoise.ar(j, n ),  LFDNoise3.ar(c, n, c ), a ), e,  LFPar.ar(h, g, k, f ) ), k ))*( LFNoise2.ar(b,  LFDNoise0.ar( Crackle.ar(b, n, d ),  Impulse.ar(n, h, k, j ),  SinOsc.ar(f, a, j, b ) ),  Saw.ar(g,  BrownNoise.ar(b, b ), k ) ))*( LFNoise2.ar( LeastChange.ar( Impulse.ar(l, h, b, c ),  Pulse.ar(d, f, k, h ) ),  Impulse.ar(j,  Pulse.ar(h, g, n, c ),  LFSaw.ar(i, d, k, g ), c ),  LFDClipNoise.ar(k, a, h ) ) )))) })
[ a, 0.018578380640285, b, 2.2891817092896, c, 0.48534102607141, d, -1852.8427379624, e, 0.1, f, 1.3991057872772, g, 1.640742166935, h, -0.94746353220704, i, 0.22920835018158, j, 0.20035557827951, k, 0.41226022916638, l, 64.633676193705, m, -0.68200601557453, n, 0.045923171547123 ]
SCORE: 5.44
-------------  START gep_gen002_011 --------------
SynthDef('gep_gen002_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar( LFNoise0.ar( LFDNoise1.ar(g, c, l ), n, h ),  SawDPW.ar( GrayNoise.ar(j, i ), j, d, m ) ))*( LFDNoise3.ar(e,  Impulse.ar( GrayNoise.ar(h, d ), n, f, e ), k ))*( LFSaw.ar(l, g,  LFSaw.ar(d, n, n,  StkPluck.ar(h, c, h, m ) ), n ) )))) })
[ a, 315.83038508014, b, 0.3070987386709, c, 1.8617309331894, d, 0.0037694698409229, e, 4200, f, -0.70341968536377, g, 429.07240291846, h, 1.0877762470811, i, 0.81264114379883, j, 0.14200233152224, k, 4200, l, 200.59462650297, m, 200.50672741411, n, 0.40632057189941 ]
SCORE: 5.99
-------------  START gep_gen002_014 --------------
SynthDef('gep_gen002_014', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFClipNoise.ar( SinOsc.ar(d, d, k, k ), h,  GrayNoise.ar(f, k ) ))*( Perlin3.ar( SinTone.ar(e,  Blip.ar(i, m, h, m ),  SinOscFB.ar(j, g, l, a ),  GaussTrig.ar(f, m, a, m ) ), b, a ))*( StkPluck.ar( LFPar.ar( Blip.ar(h, d, j, g ),  Dust2.ar(n, g, h ), k,  LeastChange.ar(m, m ) ),  MostChange.ar(d, k ),  Impulse.ar(f, i, k, g ),  LFCub.ar(h, n, a, c ) ) )))) })
[ a, 0.73198926448822, b, 0.260115190298, c, 0.86583817005157, d, 0.89726105060042, e, -6.8163049137335, f, 0.37666374587209, g, -0.19227492071425, h, 1.1642908830325, i, 0.570498489884, j, 1.8833537113866, k, 7.9191394980532, l, 15.702463532341, m, -3.4217295725755, n, 0.25208483305777 ]
SCORE: 6
-------------  START gep_gen002_017 --------------
SynthDef('gep_gen002_017', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar( LFNoise1.ar(b,  Dust.ar(c, l, j ),  Pulse.ar(a, c, d, i ) ),  Dust.ar(n, n, f ), f ))*( SawDPW.ar( Dust2.ar( LFNoise2.ar(c, n, d ),  ClipNoise.ar(m, j ), e ),  Impulse.ar( Saw.ar(f, m, d ), l, b, i ), n,  BrownNoise.ar(l, i ) ))*( StkPluck.ar(b, b,  LFDNoise0.ar( Impulse.ar(k, k, l, b ),  LFNoise1.ar(f, h, g ),  GaussTrig.ar(b, b, e, m ) ),  Pulse.ar( LFCub.ar(f, l, c, a ), a, j, d ) ) )))) })
[ a, 0.013240258717957, b, 1.0054639552867, c, -0.76926410198212, d, 1.3498109579086, e, 0.19431041968093, f, 2.1390931895989, g, 20.313853026448, h, 0.38033119450439, i, 1.7365760803223, j, -1.2178775684938, k, 1.1239568162633, l, 0.1, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 5.26
-------------  START gep_gen002_025 --------------
SynthDef('gep_gen002_025', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Dust.ar(n,  LFNoise1.ar( Saw.ar( BrownNoise.ar(j, n ),  LFDNoise3.ar(c, n, c ), a ), e,  LFPar.ar(h, g, k, f ) ), k ))*( LFNoise2.ar(b,  LFDNoise0.ar( Crackle.ar(b, n, d ),  Impulse.ar(n, h, k, j ),  SinOsc.ar(f, a, j, b ) ),  Saw.ar(g,  BrownNoise.ar(b, b ), k ) ))*( LFNoise2.ar( LeastChange.ar( Impulse.ar(l, h, b, c ),  Pulse.ar(d, f, k, h ) ),  Impulse.ar(j,  Pulse.ar(h, g, n, c ),  LFSaw.ar(i, d, k, g ), c ),  LFDClipNoise.ar(k, a, h ) ) )))) })
[ a, 0.013240258717957, b, 1.0054639552867, c, -0.76926410198212, d, 1.3498109579086, e, 0.19431041968093, f, 2.1390931895989, g, 20.313853026448, h, 0.38033119450439, i, 1.7365760803223, j, -1.2178775684938, k, 1.1239568162633, l, 0.1, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 5.44
-------------  START gep_gen002_028 --------------
SynthDef('gep_gen002_028', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c,  GaussTrig.ar( SinOsc.ar(b, f, k, e ), i, m,  LFNoise0.ar(i, a, d ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, j, b ) ))*( SinTone.ar(f,  Saw.ar( BrownNoise.ar(l, g ),  LeastChange.ar(n, j ), e ),  MostChange.ar( Crackle.ar(n, n, k ), g ), a ))*( ClipNoise.ar( StkPluck.ar(g, l, m, n ),  SyncSaw.ar( StkPluck.ar(l, h, i, g ),  ClipNoise.ar(h, f ), e, n ) ) )))) })
[ a, 0.54807896579336, b, 0.23257822248372, c, -0.11911356449127, d, 0.56169784069061, e, 27.752284064688, f, 44.537657793734, g, 0.06690583197171, h, 27.071472659506, i, -0.038261254420007, j, 123.9117311844, k, -0.092946293785592, l, 123.9117311844, m, 123.83644491521, n, 0.062898507654012 ]
SCORE: 6.27
-------------  START gep_gen002_034 --------------
SynthDef('gep_gen002_034', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFClipNoise.ar( SinOsc.ar(d, d, k, k ), h,  GrayNoise.ar(f, k ) ))*( Perlin3.ar( SinTone.ar(e,  Blip.ar(i, m, h, m ),  SinOscFB.ar(j, g, l, a ),  GaussTrig.ar(f, m, a, m ) ), b, a ))*( StkPluck.ar( LFPar.ar( Blip.ar(h, d, j, g ),  Dust2.ar(n, g, h ), k,  LeastChange.ar(m, m ) ),  MostChange.ar(d, k ),  Impulse.ar(f, i, k, g ),  LFCub.ar(h, n, a, c ) ) )))) })
[ a, 0.013240258717957, b, 1.0054639552867, c, -0.76926410198212, d, 1.3498109579086, e, 0.19431041968093, f, 2.1390931895989, g, 20.313853026448, h, 0.38033119450439, i, 1.7365760803223, j, -1.2178775684938, k, 1.1239568162633, l, 0.1, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 6
-------------  START gep_gen002_035 --------------
SynthDef('gep_gen002_035', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar(j,  BrownNoise.ar( BrownNoise.ar(l, e ),  FSinOsc.ar(e, n, k, l ) ), l, h ))*( Pulse.ar(e, i,  PinkNoise.ar(g, a ),  SinOsc.ar( Perlin3.ar(n, f, m ), n, k, b ) ))*( LFNoise1.ar( LFNoise0.ar(i,  MostChange.ar(m, a ),  LFTri.ar(a, l, i, b ) ),  LFNoise2.ar(f,  Pulse.ar(k, k, f, k ), h ), n ) )))) })
[ a, 1.7961808679583, b, 1.1145503191026, c, 1.0017040967941, d, 1, e, -0.7217768667223, f, 15.777927721136, g, 373.86020042575, h, 2.3125746250153, i, 0.0012485366524118, j, 0.73437178134918, k, 1.0710909229299, l, 0.34003221988678, m, 1.0489227771759, n, 0.73266768455505 ]
SCORE: 5.44





-------------  START gep_gen003_003 --------------
SynthDef('gep_gen003_003', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(f, n,  Impulse.ar( LFPar.ar( Dust2.ar(a, e, m ), j, g, c ),  SawDPW.ar(f, d, i, m ),  Saw.ar(i, b, g ),  BrownNoise.ar(g, e ) ) ))*( LFNoise0.ar(h,  SawDPW.ar(g,  BrownNoise.ar(m, e ), k, l ),  SinTone.ar( LFSaw.ar(n, m, g, d ), d, k, k ) ))*( Impulse.ar( LFNoise1.ar( GrayNoise.ar(e, n ), d,  SawDPW.ar(e, e, e, a ) ), g, g,  Perlin3.ar(f, f, c ) ) )))) })
[ a, 0.1, b, 0.013240258717957, c, 1.0054639552867, d, 0.1, e, 0.1, f, 1.0315124988556, g, 2.1390931895989, h, 0.1, i, -0.67681978457445, j, 1.7365760803223, k, -1.2178775684938, l, 1.1239568162633, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 5.97
-------------  START gep_gen003_004 --------------
SynthDef('gep_gen003_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( Dust2.ar( LFTri.ar(l, k, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( LFDNoise1.ar( LFDNoise1.ar( WhiteNoise.ar(g, n ),  SinOscFB.ar(j, n, n, k ), a ), g,  SyncSaw.ar( BrownNoise.ar(i, f ),  LeastChange.ar(g, c ), g, l ) ))*( PinkNoise.ar( ClipNoise.ar(d,  WhiteNoise.ar( LFNoise0.ar( ClipNoise.ar(m, j ), b, b ), f ) ), f ) )))) })
[ a, -0.052694201469421, b, 4.2857567736952, c, -0.052694201469421, d, 0.18317329883575, e, 0.73351967334747, f, -0.68082547187805, g, 29.031997570809, h, 125.95045505672, i, 3.4128198228919, j, 3.4128198228919, k, 0.28767403221072, l, 4200, m, -0.068335179786715, n, 0.014177158627812 ]
SCORE: 6.75
-------------  START gep_gen003_008 --------------
SynthDef('gep_gen003_008', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar( Blip.ar( LFNoise1.ar(j, g, c ),  LeastChange.ar(e, d ), c,  ClipNoise.ar(f, c ) ),  LFDNoise0.ar( Saw.ar(j, h, l ), b, f ), b ))*( LFTri.ar( Perlin3.ar( LFNoise2.ar(f, b, n ), f,  LFDNoise1.ar(e, i, c ) ),  LeastChange.ar( LFNoise0.ar(c, j, d ), l ), c,  Blip.ar(j, d, a, c ) ))*( Crackle.ar(g, g, g ) )))) })
[ a, -0.19227492071425, b, 0.73198926448822, c, 0.260115190298, d, 0.86583817005157, e, 0.89726105060042, f, -6.8163049137335, g, 0.37666374587209, h, 1.1642908830325, i, 0.570498489884, j, 1.8833537113866, k, 7.9191394980532, l, 15.702463532341, m, -3.4217295725755, n, 0.25208483305777 ]
SCORE: 5.86
-------------  START gep_gen003_015 --------------
SynthDef('gep_gen003_015', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFClipNoise.ar( SinOsc.ar(d, d, k, k ), h,  GrayNoise.ar(f, k ) ))*( Perlin3.ar( SinTone.ar(e,  Blip.ar(i, m, h, m ),  SinOscFB.ar(j, g, l, a ),  GaussTrig.ar(f, m, a, m ) ), b, a ))*( StkPluck.ar( LFPar.ar( Blip.ar(h, d, j, g ),  Dust2.ar(n, g, h ), k,  LeastChange.ar(m, m ) ),  MostChange.ar(d, k ),  Impulse.ar(f, i, k, g ),  LFCub.ar(h, n, a, c ) ) )))) })
[ a, 45.537657793734, b, 968.55328342576, c, 968.55328342576, d, 123.9117311844, e, 103.68391386696, f, 0.043827295303345, g, 968.55328342576, h, -0.6844955357635, i, 0.56169784069061, j, 0.45114079093454, k, -0.56169784069061, l, 0.069710508247013, m, 1.0795683860779, n, 0.043827295303345 ]
SCORE: 5.86
-------------  START gep_gen003_022 --------------
SynthDef('gep_gen003_022', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise2.ar( SawDPW.ar( SinOsc.ar(d, m, g, c ),  LFDNoise3.ar(l, j, i ), d, j ), c, b ))*( SinOsc.ar(d, f, i,  LFCub.ar(l,  MostChange.ar(l, m ), b,  Dust.ar(j, a, h ) ) ))*( LFSaw.ar(l, g,  LFSaw.ar(d, n, n,  StkPluck.ar(h, c, h, m ) ), n ) )))) })
[ a, 2.3125746250153, b, -0.7217768667223, c, 0.0012485366524118, d, 21.582776335914, e, 1.1755881052559, f, 0.4164125919342, g, 0.27440467796011, h, 373.86020042575, i, 0.0012485366524118, j, 1.7961808679583, k, 0.63666808618945, l, 0.34003221988678, m, 1.0489227771759, n, 0.73266768455505 ]
SCORE: 6.66
-------------  START gep_gen003_024 --------------
SynthDef('gep_gen003_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinTone.ar( LFSaw.ar( Pulse.ar(f, h, b, k ), k, n,  LFClipNoise.ar(h, j, i ) ),  LeastChange.ar(d, h ),  Blip.ar(h, c, g, l ), a ))*( LFDNoise3.ar(d, j,  LFDNoise3.ar(e,  Impulse.ar( GrayNoise.ar(k, e ), n, d, m ), k ) ))*( Pulse.ar(e, i,  PinkNoise.ar(g, a ),  SinOsc.ar( Perlin3.ar(n, f, m ), n, k, b ) ) )))) })
[ a, 0.018578380640285, b, 2.2891817092896, c, 1.640742166935, d, 0.73427121124536, e, 1.7630605697632, f, 0.47373760132438, g, 236.10253359433, h, 1109.1926135661, i, -0.32349896453383, j, 1.3991057872772, k, -0.42854456939943, l, 235.33947302457, m, 235.97509838697, n, 0.16210910837731 ]
SCORE: 5.28
-------------  START gep_gen003_026 --------------
SynthDef('gep_gen003_026', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GaussTrig.ar(k,  Impulse.ar(g, h,  LFSaw.ar(e, c, i, n ), g ),  Perlin3.ar(a, i, d ),  GrayNoise.ar(l, m ) ))*( GrayNoise.ar( Dust2.ar(f,  Saw.ar(f, e, e ),  MostChange.ar(g, h ) ),  SinTone.ar( LeastChange.ar(b, h ),  SyncSaw.ar(a, d, c, d ),  MostChange.ar(m, a ), m ) ))*( Dust.ar( WhiteNoise.ar( Impulse.ar(j, j, n, h ),  WhiteNoise.ar(g, b ) ),  StkPluck.ar(l, g,  MostChange.ar(e, c ), g ),  LeastChange.ar(k, a ) ) )))) })
[ a, 45.537657793734, b, 968.55328342576, c, 968.55328342576, d, 123.9117311844, e, 103.68391386696, f, 0.043827295303345, g, 968.55328342576, h, -0.6844955357635, i, 0.56169784069061, j, 0.45114079093454, k, -0.56169784069061, l, 0.069710508247013, m, 1.0795683860779, n, 0.043827295303345 ]
SCORE: 5.67
-------------  START gep_gen003_034 --------------
SynthDef('gep_gen003_034', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFNoise2.ar( SawDPW.ar( SinOsc.ar(d, m, g, c ),  LFDNoise3.ar(l, j, i ), d, j ), c, b ))*( SinOsc.ar(d, f, i,  LFCub.ar(l,  MostChange.ar(l, m ), b,  Dust.ar(j, a, h ) ) ))*( LFSaw.ar(l, g,  LFSaw.ar(d, n, n,  StkPluck.ar(h, c, h, m ) ), n ) )))) })
[ a, 35.446709403596, b, -1.0615422725677, c, 35.446709403596, d, -0.11586366172672, e, 0.4420679807663, f, 2.4531457428776, g, 1.0947344534244, h, 0.55543679048057, i, 0.14763925689856, j, 100, k, 0.03973234273477, l, 0.0031794912366695, m, 0.2116836309433, n, 0.57675364478303 ]
SCORE: 6.66
-------------  START gep_gen003_035 --------------
SynthDef('gep_gen003_035', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  FSinOsc.ar(f, m, k,  Perlin3.ar(m,  LFSaw.ar( Pulse.ar(i, f, b, m ), j, k, b ), b ) ))*( LFDNoise1.ar(l, n, g ))*( LFDNoise1.ar( SinOsc.ar( LFSaw.ar(j, j, j, j ), h, e,  Dust.ar(b, l, i ) ), m, j ) )))) })
[ a, -0.19227492071425, b, 0.73198926448822, c, 0.260115190298, d, 0.86583817005157, e, 0.89726105060042, f, -6.8163049137335, g, 0.37666374587209, h, 1.1642908830325, i, 0.570498489884, j, 1.8833537113866, k, 7.9191394980532, l, 15.702463532341, m, -3.4217295725755, n, 0.25208483305777 ]
SCORE: 5.29
-------------  START gep_gen003_037 --------------
SynthDef('gep_gen003_037', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar( Blip.ar( LFNoise1.ar(j, g, c ),  LeastChange.ar(e, d ), c,  ClipNoise.ar(f, c ) ),  LFDNoise0.ar( Saw.ar(j, h, l ), b, f ), b ))*( LFTri.ar( Perlin3.ar( LFNoise2.ar(f, b, n ), f,  LFDNoise1.ar(e, i, c ) ),  LeastChange.ar( LFNoise0.ar(c, j, d ), l ), c,  Blip.ar(j, d, a, c ) ))*( Crackle.ar(g, g, g ) )))) })
[ a, 2.3125746250153, b, -0.7217768667223, c, 0.0012485366524118, d, 21.582776335914, e, 1.1755881052559, f, 0.4164125919342, g, 0.27440467796011, h, 373.86020042575, i, 0.0012485366524118, j, 1.7961808679583, k, 0.63666808618945, l, 0.34003221988678, m, 1.0489227771759, n, 0.73266768455505 ]
SCORE: 5.86
-------------  START gep_gen003_039 --------------
SynthDef('gep_gen003_039', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c,  GaussTrig.ar( SinOsc.ar(b, f, k, e ), i, m,  LFNoise0.ar(l, b, i ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, j, b ) ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, c ), b, a ),  LFDClipNoise.ar(c, j, b ) ))*( LFTri.ar(n, l,  FSinOsc.ar(n,  Dust2.ar(j, d, a ), e, l ),  SinOsc.ar(b, k, e, i ) ) )))) })
[ a, 1, b, 9.837556294152, c, 0.21231081290982, d, 2.978923075168, e, 0.1329550743103, f, 1.1568495035172, g, 0, h, 1.6601070165634, i, -1.6320171210738, j, 0.2422798871994, k, -1.6699720621109, l, 0.36383391630506, m, 1.3694920323945, n, 1.2898045778275 ]
SCORE: 5.04




-------------  START gep_gen004_001 --------------
SynthDef('gep_gen004_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  ClipNoise.ar(k,  StkPluck.ar( SyncSaw.ar(n, d, b, k ), g, l, m ) ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar( GrayNoise.ar(n, i ), h, m, a ), k,  Dust.ar(a, b, h ) ), e, g ))*( PinkNoise.ar( ClipNoise.ar(j,  LFSaw.ar(h, e,  Dust.ar(j, j, j ), j ) ), f ) )))) })
[ a, 0.043827295303345, b, -0.092946293785592, c, 45.537657793734, d, 0.01766497796596, e, 968.55328342576, f, -0.56169784069061, g, 0.06690583197171, h, 107.59618256257, i, 0.011571610172467, j, 1.9957923755486, k, 0.21205985827686, l, 968.55328342576, m, -26.703527199302, n, 45.537657793734 ]
SCORE: 5.79
-------------  START gep_gen004_005 --------------
SynthDef('gep_gen004_005', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Pulse.ar(c,  GaussTrig.ar( SinOsc.ar(i, f, g, c ), i, m,  LFNoise0.ar(k, d, h ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, n, k ) ))*( LFPar.ar( Dust2.ar( LFTri.ar(l, k, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( Perlin3.ar( MostChange.ar( SinTone.ar( ClipNoise.ar(c, a ),  LFTri.ar(e, j, l, e ),  SinOscFB.ar(n, j, a, d ), c ), n ), b, d ) )))) })
[ a, 0.043827295303345, b, -0.092946293785592, c, 45.537657793734, d, 0.01766497796596, e, 968.55328342576, f, -0.56169784069061, g, 0.06690583197171, h, 107.59618256257, i, 0.011571610172467, j, 1.9957923755486, k, 0.21205985827686, l, 968.55328342576, m, -26.703527199302, n, 45.537657793734 ]
SCORE: 5.68
-------------  START gep_gen004_016 --------------
SynthDef('gep_gen004_016', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, j ), h, i ) ))*( SinTone.ar(h,  LFPar.ar(c,  Saw.ar(j, m, l ), j, j ),  Saw.ar(g, e, l ), m ) )))) })
[ a, 1.3464362621307, b, 100, c, 35.446709403596, d, -0.11586366172672, e, 0.4420679807663, f, 0.19359545440058, g, 0.19359545440058, h, 0.60009971136974, i, 0.1133639095353, j, 0.19359545440058, k, 0.58490358086809, l, 0.46430146694183, m, -0.24975893025471, n, 0.22904137619255 ]
SCORE: 5.58
-------------  START gep_gen004_018 --------------
SynthDef('gep_gen004_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar( Pulse.ar(n,  BrownNoise.ar( SinTone.ar(k, l, h, g ),  LFNoise2.ar(b, b, f ) ),  Dust.ar(n, a, k ), b ), g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, c ), b, a ),  LFDClipNoise.ar(c, j, b ) ))*( LFDClipNoise.ar(d, n, l ) )))) })
[ a, 0.18317329883575, b, 4.2857567736952, c, -0.052694201469421, d, 0.23586750030518, e, 0.076532634773422, f, -42.354965247184, g, 0.077397517639968, h, 818.4407609312, i, 4200, j, 0.0055932117658625, k, 2.1573887440809, l, 4200, m, -0.068335179786715, n, 0.014177158627812 ]
SCORE: 4.69
-------------  START gep_gen004_022 --------------
SynthDef('gep_gen004_022', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  FSinOsc.ar(f, m, k,  Perlin3.ar(m,  LFSaw.ar( Pulse.ar(i, f, b, m ), j, k, b ), b ) ))*( GrayNoise.ar( SinTone.ar( Dust2.ar( MostChange.ar(a, d ),  LeastChange.ar(c, d ), m ),  SinTone.ar(f, e, e, g ), f,  Saw.ar(h, b, h ) ), f ))*( SinTone.ar( LFDNoise0.ar(d, i, d ), k,  FSinOsc.ar(f, h, f, j ),  Blip.ar(b, e, m, c ) ) )))) })
[ a, 2.3125746250153, b, -0.7217768667223, c, 0.0012485366524118, d, 21.582776335914, e, 2.2160016534807, f, 385.12325988108, g, 0.1011841040199, h, 0.65516893540236, i, 0.73437178134918, j, -0.05596143033344, k, 0.41982078552246, l, 0.53680193599126, m, 0.83452928066254, n, 0.0017040967941284 ]
SCORE: 6.21
-------------  START gep_gen004_034 --------------
SynthDef('gep_gen004_034', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, j ), h, i ) ))*( SinTone.ar(h,  LFPar.ar(c,  Saw.ar(j, m, l ), j, j ),  Saw.ar(g, e, l ), m ) )))) })
[ a, 0.1, b, 0.013240258717957, c, 1.0054639552867, d, 0.1, e, 0.1, f, 1.0315124988556, g, 2.1390931895989, h, 0.1, i, -0.67681978457445, j, 1.7365760803223, k, -1.2178775684938, l, 1.1239568162633, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 5.58
-------------  START gep_gen004_037 --------------
SynthDef('gep_gen004_037', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Saw.ar( LFNoise1.ar(b,  Dust.ar(c, l, j ),  Pulse.ar(a, c, d, i ) ),  Dust.ar(n, n, f ), f ))*( SawDPW.ar( Dust2.ar( LFNoise2.ar(c, n, d ),  ClipNoise.ar(m, j ), e ),  Impulse.ar( Saw.ar(f, m, d ), l, b, i ), n,  BrownNoise.ar(l, i ) ))*( StkPluck.ar(b, b,  LFDNoise0.ar( Impulse.ar(k, k, l, b ),  LFNoise1.ar(f, h, g ),  GaussTrig.ar(b, b, e, m ) ),  Pulse.ar( LFCub.ar(n, d, b, d ), a, j, d ) ) )))) })
[ a, 0.18317329883575, b, 4.2857567736952, c, -0.052694201469421, d, 0.23586750030518, e, 0.076532634773422, f, -42.354965247184, g, 0.077397517639968, h, 818.4407609312, i, 4200, j, 0.0055932117658625, k, 2.1573887440809, l, 4200, m, -0.068335179786715, n, 0.014177158627812 ]
SCORE: 6




-------------  START gep_gen005_004 --------------
SynthDef('gep_gen005_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, j ), h, i ) ))*( SinTone.ar(h,  LFPar.ar(c,  SawDPW.ar(g, n, f, b ),  MostChange.ar(e, c ),  LFNoise1.ar(l, l, h ) ),  Saw.ar(l, l, f ), m ) )))) })
[ a, 2.6997172832489, b, 0.28922717303614, c, 0.0044643944428377, d, -1.3768745590744, e, 0.48654624882078, f, 0.4420679807663, g, 0.19359545440058, h, 0.19359545440058, i, -0.73533795352817, j, 0.1133639095353, k, 6.3068055453575, l, 0.58035337924957, m, 6.4415581765449, n, 0.52030980587006 ]
SCORE: 5.59
-------------  START gep_gen005_007 --------------
SynthDef('gep_gen005_007', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar( Pulse.ar(n,  BrownNoise.ar( SinTone.ar(k, l, h, g ),  LFNoise2.ar(b, b, f ) ),  Dust.ar(n, a, k ), b ), g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ))*( LFDClipNoise.ar(d, n, l ) )))) })
[ a, 0.06690583197171, b, 0.043827295303345, c, -0.092946293785592, d, 33.642541997244, e, 20, f, 0.30785477161407, g, 968.59711072106, h, 107.59618256257, i, 0.011571610172467, j, 1.9957923755486, k, 0.21205985827686, l, 968.55328342576, m, -26.703527199302, n, 45.537657793734 ]
SCORE: 5.71
-------------  START gep_gen005_009 --------------
SynthDef('gep_gen005_009', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise1.ar( LFDNoise1.ar( GrayNoise.ar(a, d ),  Dust.ar(l, d, d ),  ClipNoise.ar(c, m ) ), g,  SyncSaw.ar(h, k, h, e ) ))*( SinTone.ar(a, c, a, c ))*( PinkNoise.ar( ClipNoise.ar(j,  LFSaw.ar(h, e, d, b ) ), f ) )))) })
[ a, 0.09512744306744, b, 1.6376903057098, c, 0.63546763057765, d, 0.86583817005157, e, 0.89726105060042, f, -6.8163049137335, g, 0.37666374587209, h, 1.1642908830325, i, 0.99304413795471, j, 2.903741790449, k, 7.9191394980532, l, 0.39270306357956, m, -0.59012658417612, n, 1.668132283179 ]
SCORE: 6.04
-------------  START gep_gen005_014 --------------
SynthDef('gep_gen005_014', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, j ), h, i ) ))*( SinTone.ar(h,  LFPar.ar(c,  SawDPW.ar(g, n, f, b ),  MostChange.ar(e, c ),  LFNoise1.ar(l, l, h ) ),  Saw.ar(l, l, f ), m ) )))) })
[ a, 0.35253179073334, b, 2.9260127057189, c, -0.19378173351288, d, -0.13153854616156, e, 0.44161384015628, f, 0.38676512241364, g, 0.12667764908796, h, 0.1, i, -0.67681978457445, j, 1.7365760803223, k, -1.2178775684938, l, 1.1239568162633, m, 0.36460012845336, n, 0.12667764908796 ]
SCORE: 5.59
-------------  START gep_gen005_020 --------------
SynthDef('gep_gen005_020', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  StkPluck.ar( SyncSaw.ar(k,  StkPluck.ar(m, b, c, k ),  SyncSaw.ar(f, l, c, k ), g ), g,  ClipNoise.ar(b, k ), m ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar( GrayNoise.ar(g, m ), h, g, d ), k,  Dust.ar(i, e, c ) ), e, g ))*( SinOsc.ar(j,  PinkNoise.ar(g,  Dust2.ar( Dust.ar(b, n, f ),  PinkNoise.ar(m, f ), k ) ), f, c ) )))) })
[ a, 29.21153435815, b, 0.58823237077328, c, 0.028037470360079, d, 32.74921574644, e, 0.0065714436801009, f, 63.908297871137, g, -0.18317329883575, h, 0.66257035094705, i, 4200, j, 0.18317329883575, k, 63.908297871137, l, 0.15306526954684, m, -0.54916870594025, n, 0.014177158627812 ]
SCORE: 5.47
-------------  START gep_gen005_023 --------------
SynthDef('gep_gen005_023', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GaussTrig.ar(k,  Impulse.ar( SinOsc.ar(i, i, e, a ), i, m,  LFNoise0.ar(a, i, f ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, n, k ) ))*( LFPar.ar( Dust2.ar( LFTri.ar(l, h, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( Perlin3.ar( MostChange.ar( SinTone.ar( ClipNoise.ar(c, a ),  LFTri.ar(e, j, l, e ),  SinOscFB.ar(n, j, a, d ), c ), n ), b, d ) )))) })
[ a, 29.21153435815, b, 0.58823237077328, c, 0.028037470360079, d, 32.74921574644, e, 0.0065714436801009, f, 63.908297871137, g, -0.18317329883575, h, 0.66257035094705, i, 4200, j, 0.18317329883575, k, 63.908297871137, l, 0.15306526954684, m, -0.54916870594025, n, 0.014177158627812 ]
SCORE: 5.77
-------------  START gep_gen005_024 --------------
SynthDef('gep_gen005_024', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDNoise1.ar( LFDNoise1.ar( GrayNoise.ar(a, d ),  Dust.ar(l, d, d ),  ClipNoise.ar(c, m ) ), g,  SyncSaw.ar(h, k, h, e ) ))*( SinTone.ar(a, c, a, c ))*( PinkNoise.ar( ClipNoise.ar(j,  LFSaw.ar(h, e, d, b ) ), f ) )))) })
[ a, 2.6997172832489, b, 0.28922717303614, c, 0.0044643944428377, d, -1.3768745590744, e, 0.48654624882078, f, 0.4420679807663, g, 0.19359545440058, h, 0.19359545440058, i, -0.73533795352817, j, 0.1133639095353, k, 6.3068055453575, l, 0.58035337924957, m, 6.4415581765449, n, 0.52030980587006 ]
SCORE: 6.04
-------------  START gep_gen005_027 --------------
SynthDef('gep_gen005_027', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  PinkNoise.ar( Dust.ar(k, m, n ),  Saw.ar(k,  ClipNoise.ar(h, j ), n ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, j ), h, i ) ))*( SinTone.ar(h,  LFPar.ar(c,  SawDPW.ar(g, n, f, b ),  MostChange.ar(e, c ),  LFNoise1.ar(l, l, h ) ),  Saw.ar(l, l, f ), m ) )))) })
[ a, 0.06690583197171, b, 0.043827295303345, c, -0.092946293785592, d, 33.642541997244, e, 20, f, 0.30785477161407, g, 968.59711072106, h, 107.59618256257, i, 0.011571610172467, j, 1.9957923755486, k, 0.21205985827686, l, 968.55328342576, m, -26.703527199302, n, 45.537657793734 ]
SCORE: 5.59
-------------  START gep_gen005_031 --------------
SynthDef('gep_gen005_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(f, n,  Impulse.ar( LFPar.ar( Dust2.ar(a, e, m ), j, g, c ),  SawDPW.ar(f, d, i, m ),  Saw.ar(i, b, g ),  BrownNoise.ar(g, e ) ) ))*( LFNoise0.ar(h, i,  SinTone.ar(g,  BrownNoise.ar( LFSaw.ar(k, k, m, e ), d ), k, l ) ))*( Impulse.ar( LFNoise1.ar( GrayNoise.ar(e, n ), d,  SawDPW.ar(e, e, e, a ) ), g, g,  Perlin3.ar(f, f, c ) ) )))) })
[ a, 29.21153435815, b, 0.58823237077328, c, 0.028037470360079, d, 32.74921574644, e, 0.0065714436801009, f, 63.908297871137, g, -0.18317329883575, h, 0.66257035094705, i, 4200, j, 0.18317329883575, k, 63.908297871137, l, 0.15306526954684, m, -0.54916870594025, n, 0.014177158627812 ]
SCORE: 5.69





-------------  START gep_gen006_004 --------------
SynthDef('gep_gen006_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( Dust2.ar( LFTri.ar(l, h, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( StkPluck.ar( SyncSaw.ar(k,  StkPluck.ar(m, b, c, k ),  SyncSaw.ar(f, l, c, k ), g ), g,  ClipNoise.ar(b, k ), m ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar(b, m, k, h ), k,  Dust.ar(h, l, i ) ), e, g ) )))) })
[ a, 1.7563799799111, b, 0.41811668872833, c, -0.65628731250763, d, 100, e, 1.074404001236, f, 0.0011629397816032, g, 0.41982078552246, h, 1.7961808679583, i, 0.0012485366524118, j, 0.015861936135088, k, 1224.3587367094, l, 15.777927721136, m, 0.72445727493275, n, 1.0489227771759 ]
SCORE: 5.25
-------------  START gep_gen006_010 --------------
SynthDef('gep_gen006_010', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( Dust2.ar( LFTri.ar(l, h, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( StkPluck.ar( SyncSaw.ar(k,  StkPluck.ar(m, b, c, k ),  SyncSaw.ar(f, l, c, k ), g ), g,  ClipNoise.ar(b, k ), m ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar(b, m, k, h ), k,  Dust.ar(h, l, i ) ), e, g ) )))) })
[ a, 0.38136883534993, b, 0.99727916717529, c, 0.15875005722046, d, 0.38136883534993, e, 0.1, f, 1.0315124988556, g, 2.1390931895989, h, 5.660615663196, i, 1.0315124988556, j, -0.18714793915595, k, 0.54968583999126, l, 29.131817390396, m, -0.48519897460938, n, 1.9955469763997 ]
SCORE: 5.25
-------------  START gep_gen006_016 --------------
SynthDef('gep_gen006_016', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(f, n,  Impulse.ar( LFPar.ar(j, h, e, a ),  SawDPW.ar(d, l, d, d ),  Saw.ar(c, b, g ), j ) ))*( LFNoise0.ar(i,  Dust.ar(k,  Blip.ar(d, k, k, m ), h ),  WhiteNoise.ar( LFNoise0.ar(e, n, m ),  LFSaw.ar(g, d, i, n ) ) ))*( SinTone.ar(h,  LFPar.ar(c,  SawDPW.ar(g, n, f, b ),  MostChange.ar(e, e ),  LFNoise1.ar(i, e, j ) ),  Saw.ar(l, l, f ), m ) )))) })
[ a, 1.7563799799111, b, 0.41811668872833, c, -0.65628731250763, d, 100, e, 1.074404001236, f, 0.0011629397816032, g, 0.41982078552246, h, 1.7961808679583, i, 0.0012485366524118, j, 0.015861936135088, k, 1224.3587367094, l, 15.777927721136, m, 0.72445727493275, n, 1.0489227771759 ]
SCORE: 5.13
-------------  START gep_gen006_018 --------------
SynthDef('gep_gen006_018', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GrayNoise.ar( Saw.ar(k,  LFNoise1.ar(j, g, c ), c ),  Dust2.ar(k,  BrownNoise.ar(f, d ),  Dust2.ar(i, m, i ) ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, c ), h, i ) ))*( LFDNoise0.ar(n,  LFDNoise0.ar(f, g,  Perlin3.ar(k, e, g ) ),  LFPar.ar( LFDNoise0.ar(c, b, f ),  SinOscFB.ar(c, f, i, j ), d, m ) ) )))) })
[ a, 0.13475263118744, b, 0.095631718635559, c, -0.84985864162445, d, 35.446709403596, e, -0.03912091255188, f, 2.4531457428776, g, 0.25366344923901, h, 0.32481189240545, i, 0.19359545440058, j, 0.0026979011661336, k, 55.071320738619, l, 0.98107798542962, m, 6.4415581765449, n, 0.25366344923901 ]
SCORE: 6.82
-------------  START gep_gen006_023 --------------
SynthDef('gep_gen006_023', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(l, g,  LFSaw.ar(d, n, g,  MostChange.ar(g, k ) ), n ))*( LFNoise2.ar( SawDPW.ar( SinOsc.ar(d, m, g, c ),  LFDNoise3.ar(l, j, i ), d, j ), c, b ))*( SinOsc.ar(h, d, f, i ) )))) })
[ a, 0.38136883534993, b, 0.99727916717529, c, 0.15875005722046, d, 0.38136883534993, e, 0.1, f, 1.0315124988556, g, 2.1390931895989, h, 5.660615663196, i, 1.0315124988556, j, -0.18714793915595, k, 0.54968583999126, l, 29.131817390396, m, -0.48519897460938, n, 1.9955469763997 ]
SCORE: 5.53
-------------  START gep_gen006_031 --------------
SynthDef('gep_gen006_031', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( Dust2.ar( LFTri.ar(l, h, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( StkPluck.ar( SyncSaw.ar(k,  StkPluck.ar(m, b, c, k ),  SyncSaw.ar(f, l, c, k ), g ), g,  ClipNoise.ar(b, k ), m ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar(b, m, k, h ), k,  Dust.ar(h, l, i ) ), e, g ) )))) })
[ a, 0.13475263118744, b, 0.095631718635559, c, -0.84985864162445, d, 35.446709403596, e, -0.03912091255188, f, 2.4531457428776, g, 0.25366344923901, h, 0.32481189240545, i, 0.19359545440058, j, 0.0026979011661336, k, 55.071320738619, l, 0.98107798542962, m, 6.4415581765449, n, 0.25366344923901 ]
SCORE: 5.25
-------------  START gep_gen006_034 --------------
SynthDef('gep_gen006_034', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  SinOsc.ar(j,  PinkNoise.ar(g,  Dust2.ar( Dust.ar(b, n, f ),  PinkNoise.ar(m, f ), k ) ), f, c ))*( GaussTrig.ar(k,  Impulse.ar( SinOsc.ar(i, i, e, a ), i, m,  LFNoise0.ar(a, i, f ) ),  Pulse.ar(b, e, h, a ),  LFCub.ar(c, b, n, k ) ))*( PinkNoise.ar( ClipNoise.ar(j,  LFSaw.ar(h, e, d,  GrayNoise.ar(h, g ) ) ), f ) )))) })
[ a, 29.21153435815, b, 0.58823237077328, c, 0.028037470360079, d, 32.74921574644, e, 0.0065714436801009, f, 63.908297871137, g, -0.18317329883575, h, 0.66257035094705, i, 4200, j, 0.18317329883575, k, 63.908297871137, l, -1.3089567422867, m, -0.068335179786715, n, 818.4922774641 ]
SCORE: 5.79
-------------  START gep_gen006_039 --------------
SynthDef('gep_gen006_039', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GrayNoise.ar( Saw.ar(k,  LFNoise1.ar(j, g, c ), c ),  Dust2.ar(k,  BrownNoise.ar(f, d ),  Dust2.ar(i, m, i ) ) ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(j, l, g ),  GaussTrig.ar(d, g, i, f ) ), l,  Impulse.ar( LFPar.ar(i, n, b, g ),  LFNoise1.ar(e, d, c ), h, i ) ))*( LFDNoise0.ar(n,  LFDNoise0.ar(f, g,  Perlin3.ar(k, e, g ) ),  LFPar.ar( LFDNoise0.ar(c, b, f ),  SinOscFB.ar(c, f, i, j ), d, m ) ) )))) })
[ a, 0.13475263118744, b, 0.095631718635559, c, -0.84985864162445, d, 35.446709403596, e, -0.03912091255188, f, 2.4531457428776, g, 0.25366344923901, h, 0.32481189240545, i, 0.19359545440058, j, 0.0026979011661336, k, 55.071320738619, l, 0.98107798542962, m, 6.4415581765449, n, 0.25366344923901 ]
SCORE: 6.82



-------------  START gep_gen007_001 --------------
SynthDef('gep_gen007_001', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFPar.ar( Dust2.ar( LFTri.ar(l, h, a, e ),  LFDClipNoise.ar(c, i, j ), h ), i, b,  SawDPW.ar(d, a, b, i ) ))*( StkPluck.ar( SyncSaw.ar(k,  StkPluck.ar(m, b, c, k ),  SyncSaw.ar(f, l, c, k ), g ), g,  ClipNoise.ar(b, k ), m ))*( LFCub.ar(i,  LFDNoise1.ar( Pulse.ar(b, m, k, h ), k,  Dust.ar(h, l, i ) ), e, g ) )))) })
[ a, 5.0316871868833, b, 0.095631718635559, c, 0.40779066085815, d, -0.84985864162445, e, 35.446709403596, f, -0.03912091255188, g, 1.0947344534244, h, 0.1, i, -35.35107768496, j, -0.73533795352817, k, 8.8867862436224, l, 2.5709053624997, m, 0.60257939253646, n, 35.446709403596 ]
SCORE: 5.27
-------------  START gep_gen007_004 --------------
SynthDef('gep_gen007_004', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFDClipNoise.ar(k, e, m ))*( GaussTrig.ar(k,  Impulse.ar( SinOsc.ar(f, i, n, b ), i, m,  LFNoise0.ar(g, e, d ) ),  Pulse.ar(h, i, j, l ),  LFCub.ar(g, d, g, i ) ))*( LFDNoise0.ar(n,  LFDNoise0.ar(f, g,  Perlin3.ar(k, e, g ) ),  LFPar.ar( LFDNoise0.ar(c, b, f ),  SinOscFB.ar(l, f, i, j ), d, m ) ) )))) })
[ a, 0.25340480811538, b, 0.26402747631073, c, 1.0438272953033, d, 562.723112295, e, 799.75896698943, f, 0.087654590606689, g, 2.7177940976472, h, 123.9117311844, i, 107.59618256257, j, 0.012334798667838, k, 14.345039580784, l, 2842.8041833878, m, 0.11911356449127, n, 0.25340480811538 ]
SCORE: 4.91
-------------  START gep_gen007_011 --------------
SynthDef('gep_gen007_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Perlin3.ar(d, k, d ))*( LFNoise0.ar(i,  Dust.ar(k,  Blip.ar(d, k, k, m ), h ),  WhiteNoise.ar( LFNoise0.ar(e, n, m ),  LFSaw.ar(g, d, i, n ) ) ))*( Impulse.ar(n,  LFNoise1.ar( SinOsc.ar(g, n, f, b ), n,  Dust2.ar(j, c, l ) ), g,  FSinOsc.ar(e, l, l, f ) ) )))) })
[ a, 0.25340480811538, b, 0.26402747631073, c, 1.0438272953033, d, 562.723112295, e, 799.75896698943, f, 0.087654590606689, g, 2.7177940976472, h, 123.9117311844, i, 107.59618256257, j, 0.012334798667838, k, 14.345039580784, l, 2842.8041833878, m, 0.11911356449127, n, 0.25340480811538 ]
SCORE: 6.01
-------------  START gep_gen007_012 --------------
SynthDef('gep_gen007_012', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GrayNoise.ar(i, a ))*( LFTri.ar(e,  WhiteNoise.ar( Perlin3.ar(h, a, c ),  GaussTrig.ar(b, n, k, i ) ), l,  Impulse.ar( LFPar.ar(i, e, a, a ),  LFNoise1.ar(i, f, j ), b, e ) ))*( PinkNoise.ar( ClipNoise.ar(j,  LFSaw.ar(h, e, d,  GrayNoise.ar(h, g ) ) ), f ) )))) })
[ a, 0.25340480811538, b, 0.26402747631073, c, 1.0438272953033, d, 562.723112295, e, 799.75896698943, f, 0.087654590606689, g, 2.7177940976472, h, 123.9117311844, i, 107.59618256257, j, 0.012334798667838, k, 14.345039580784, l, 2842.8041833878, m, 0.11911356449127, n, 0.25340480811538 ]
SCORE: 6.15
-------------  START gep_gen007_017 --------------
SynthDef('gep_gen007_017', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar( Pulse.ar(n,  BrownNoise.ar( SinTone.ar(k, l, h, g ),  LFNoise2.ar(b, b, f ) ),  Dust.ar(n, a, k ), b ), g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ))*( LFDClipNoise.ar(d, n, l ) )))) })
[ a, 0.076380372047424, b, 0.96168101131565, c, 0.0017040967941284, d, 100, e, 1.074404001236, f, 0.0011629397816032, g, 0.41982078552246, h, 1.7961808679583, i, 0.65799140930176, j, 11.558729233869, k, 1.8851561546326, l, 1.7961808679583, m, -0.098587532729168, n, 0.73096358776093 ]
SCORE: 5.3
-------------  START gep_gen007_020 --------------
SynthDef('gep_gen007_020', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFSaw.ar(l, g,  LFSaw.ar(d, n, g,  MostChange.ar(g, k ) ), n ))*( LFNoise2.ar( SawDPW.ar( SinOsc.ar(d, m, g, c ),  LFDNoise3.ar(l, j, i ), d, j ), c, b ))*( SinOsc.ar(l, b, l, h ) )))) })
[ a, 0.25340480811538, b, 0.26402747631073, c, 1.0438272953033, d, 562.723112295, e, 799.75896698943, f, 0.087654590606689, g, 2.7177940976472, h, 123.9117311844, i, 107.59618256257, j, 0.012334798667838, k, 14.345039580784, l, 2842.8041833878, m, 0.11911356449127, n, 0.25340480811538 ]
SCORE: 6.44
-------------  START gep_gen007_023 --------------
SynthDef('gep_gen007_023', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar( Pulse.ar(n,  BrownNoise.ar( SinTone.ar(k, l, h, g ),  LFNoise2.ar(b, b, f ) ),  Dust.ar(n, a, k ), b ), g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ))*( LFDClipNoise.ar(d, n, l ) )))) })
[ a, 0.25340480811538, b, 0.26402747631073, c, 1.0438272953033, d, 562.723112295, e, 799.75896698943, f, 0.087654590606689, g, 2.7177940976472, h, 123.9117311844, i, 107.59618256257, j, 0.012334798667838, k, 14.345039580784, l, 2842.8041833878, m, 0.11911356449127, n, 0.25340480811538 ]
SCORE: 5.3
-------------  START gep_gen007_037 --------------
SynthDef('gep_gen007_037', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  GrayNoise.ar(f, k ))*( LFDNoise1.ar( LFDNoise1.ar( GrayNoise.ar(k, i ),  Dust.ar(k, m, n ),  ClipNoise.ar(i, c ) ), g,  SyncSaw.ar(h, k, g, e ) ))*( SinTone.ar(i,  LFPar.ar(c,  SawDPW.ar(m, h, m, h ),  MostChange.ar(b, h ),  LFNoise1.ar(j, c, k ) ),  Saw.ar(b, c, h ), m ) )))) })
[ a, 5.0316871868833, b, 0.095631718635559, c, 0.40779066085815, d, -0.84985864162445, e, 35.446709403596, f, -0.03912091255188, g, 1.0947344534244, h, 0.1, i, -35.35107768496, j, -0.73533795352817, k, 8.8867862436224, l, 2.5709053624997, m, 0.60257939253646, n, 35.446709403596 ]
SCORE: 4.71




-------------  START gep_gen009_006 --------------
SynthDef('gep_gen009_006', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  LFCub.ar( GaussTrig.ar( GaussTrig.ar(g, e, d, c ), k,  Impulse.ar(m, n, f, f ),  Pulse.ar(a, n, n, d ) ),  Impulse.ar(h, i, j, l ),  Pulse.ar(g, d, g, i ),  LFCub.ar(f, i, n, b ) ))*( PinkNoise.ar(g, h ))*( Saw.ar(h, i,  SinTone.ar(g,  BrownNoise.ar( Impulse.ar(b, b, d, h ), h ), k, l ) ) )))) })
[ a, 0.69287252426147, b, -1.3768745590744, c, 0.40425789356232, d, 0.25366344923901, e, 0.34643626213074, f, 100, g, 0.94549036026001, h, 1.2854526812499, i, -0.03912091255188, j, 0.48118889331818, k, -0.16980716173619, l, 0.60009971136974, m, -32.875804041096, n, 0.60313065340281 ]
SCORE: 5.43
-------------  START gep_gen009_011 --------------
SynthDef('gep_gen009_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(i, k ))*( LFDNoise1.ar( LFDNoise1.ar( FSinOsc.ar(h, k, l, c ),  Dust.ar(e, n, e ),  ClipNoise.ar(e, e ) ), g, g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ) )))) })
[ a, 0.69287252426147, b, -1.3768745590744, c, 0.40425789356232, d, 0.25366344923901, e, 0.34643626213074, f, 100, g, 0.94549036026001, h, 1.2854526812499, i, -0.03912091255188, j, 0.48118889331818, k, -0.16980716173619, l, 0.60009971136974, m, -32.875804041096, n, 0.60313065340281 ]
SCORE: 5.4
-------------  START gep_gen009_025 --------------
SynthDef('gep_gen009_025', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  Impulse.ar(n,  LFNoise1.ar( SinOsc.ar(m, n, i, c ), n,  Dust2.ar(d, m, j ) ),  SyncSaw.ar(e, g, e, k ),  GrayNoise.ar(i, k ) ))*( GrayNoise.ar(f, k ))*( Dust.ar( WhiteNoise.ar( Impulse.ar(i, j, d, a ),  WhiteNoise.ar(e, a ) ),  StkPluck.ar(l, n,  StkPluck.ar(c, g, g, k ), h ),  LeastChange.ar(k, e ) ) )))) })
[ a, 0.69287252426147, b, -1.3768745590744, c, 0.40425789356232, d, 0.25366344923901, e, 0.34643626213074, f, 100, g, 0.94549036026001, h, 1.2854526812499, i, -0.03912091255188, j, 0.48118889331818, k, -0.16980716173619, l, 0.60009971136974, m, -32.875804041096, n, 0.60313065340281 ]
SCORE: 5.95
-------------  START gep_gen009_028 --------------
SynthDef('gep_gen009_028', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(i, k ))*( LFDNoise1.ar( LFDNoise1.ar( FSinOsc.ar(h, k, l, c ),  Dust.ar(e, n, e ),  ClipNoise.ar(e, e ) ), g, g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ) )))) })
[ a, 0.1, b, 2.9260127057189, c, 0.35253179073334, d, -1.1560292243958, e, 0.1, f, 0.012035501790615, g, 2.1390931895989, h, 5.660615663196, i, 0.19289024572822, j, 0.030917565886327, k, 0.54968583999126, l, 98.138067447938, m, 0.38136883534993, n, 0.71321403980255 ]
SCORE: 5.4
-------------  START gep_gen009_038 --------------
SynthDef('gep_gen009_038', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  BrownNoise.ar(i, k ))*( LFDNoise1.ar( LFDNoise1.ar( FSinOsc.ar(h, k, l, c ),  Dust.ar(e, n, e ),  ClipNoise.ar(e, e ) ), g, g ))*( LFTri.ar(j, g,  Pulse.ar( Dust.ar(m, i, l ),  BrownNoise.ar(m, i ), b, a ),  LFDClipNoise.ar(c, j, b ) ) )))) })
[ a, 0.1, b, 2.9260127057189, c, 0.35253179073334, d, -1.1560292243958, e, 0.1, f, 0.012035501790615, g, 2.1390931895989, h, 5.660615663196, i, 0.19289024572822, j, 0.030917565886327, k, 0.54968583999126, l, 98.138067447938, m, 0.38136883534993, n, 0.71321403980255 ]
SCORE: 5.4