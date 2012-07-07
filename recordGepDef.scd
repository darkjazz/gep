s.quit;

s.options.maxSynthDefs = 2048;

s.boot
s.loadDirectory("/Users/alo/Data/gep/synthdefs/");


~data = UGenExpressionTree.loadMetadata("gep_gen000_116_120618_120643")

(
x=Synth(\gep_gen000_116_120618_120643, ~data.args);
s.record;

s.stopRecording;

x.free

