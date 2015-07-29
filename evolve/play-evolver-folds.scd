~buf = Buffer.read(s, "/Users/alo/sounds/evolver-folds.aif")

Ndef('bufplay', {
	var rates;
	rates = [0.5, 1, 2, 4, 8, 16];
	Mix.fill(rates.size, {|i|
		PlayBuf.ar(2, ~buf, rates[i], loop: 1) * 0.1
	})
})

MasterEQ(2)

Ndef('bufplay').play

Ndef('bufplay').clear


s.scope