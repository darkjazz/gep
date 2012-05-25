// NRT

SynthDef(\analyze, {|in, rate|
	var input, fft, mfcc, flat, cent, amp, error, trig;
	trig = Impulse.kr(rate);
	input = In.ar(in);
	fft = FFT(LocalBuf(1024), input);
	mfcc = MFCC.kr(fft);
	flat = SpecFlatness.kr(fft);
	cent = SpecCentroid.kr(fft);
	amp = Amplitude.kr(input);
	error = CheckBadValues.kr(input + amp + flat + cent + mfcc.sum);
	SendReply.kr(trig, '/mfcc', mfcc);
	SendReply.kr(trig, '/flat', flat);
	SendReply.kr(trig, '/cent', cent);
	SendReply.kr(trig, '/amp', amp);
	SendReply.kr(trig, '/err', error);	
}).add;

SynthDef('gep_gen000_011', {|out=0,a,b,c,d,e,f,g,h,i,j,k,l,m,n|  Out.ar(out, Pan2.ar(Normalizer.ar((  MostChange.ar( MostChange.ar( LFSaw.ar(g, j, i, n ),  Saw.ar(k, b, h ) ),  SinOsc.ar(g,  Crackle.ar(g, l, l ), g, m ) ))*( LFDNoise3.ar( LFNoise2.ar(d,  BrownNoise.ar(k, m ), k ), i,  LFDNoise3.ar( Dust.ar(l, f, n ), e, m ) ))*( Dust2.ar(n, a,  LFNoise1.ar(e,  Perlin3.ar( Impulse.ar(j, d, i, k ), a, m ),  LFNoise0.ar(f, d, a ) ) ) )))) }).add


[ a, 0.047718110439139, b, 1.0061161518097, c, 74.321776959799, d, 0.54304659664513, e, 0.42526769638062, f, 1, g, 821.27271571984, h, 821.27271571984, i, -0.65697418541308, j, 2.4630497694016, k, 0.60706286413931, l, 45.357623346218, m, 252.52942411568, n, 0.01414287237133 ]

(
var score, file;
score = [
	[],
	[0.0, [\s_new, \analyze, 1000, 0, 0, \freq, 440]],
	[0.2, [\s_new, \helpscore, 1001, 0, 0, \freq, 660]],
	[0.3, [\s_new, \helpscore, 1002, 0, 0, \freq, 220]],
	[1, [\c_set, 0, 0]]
];
o = ServerOptions.new.numOutputBusChannels = 1; // mono output
Score.recordNRT(g, "help-oscFile", "helpNRT.aiff", options: o); // synthesize
)
