OSCFunc.trace(true,true);
OSCFunc.trace(false);
z = NetAddr("localhost", 4001)
(
Tdef(\zas, {
	var tick = 0;
	inf.do{|i|
		// var note = Scale.minor.degrees[i.mod(7).asInteger];
		var note = Scale.minor.degrees.choose;
		z.sendMsg("/noteOn", 0, note, rrand(12,72));
		0.5.wait;
		z.sendMsg("/noteOff", 0, note);
	};
}).play.quant_(1);
)
Tdef(\zas).stop;
z.sendMsg("/part0/partefx[]", 0, note, rrand(12,72));
z.sendMsg("/part0/kit0/adpars/VoicePar0/octave", 5);
OSCFunc.trace(true)
127.collect(z.sendMsg("/noteOff", 0, _))
z.sendMsg("/part0/kit0/adpars/VoicePar0/PVolume", 100)
z.sendMsg("/part0/kit0/adpars/VoicePar0/PVolume")
z.sendMsg("/noteOn", 0, 60, 100)
z.sendMsg("/noteOff", 0, 60, 100)