g=UGenGraphGEP()


g.ugenCollection

x=g.ugenCollection.collect({|ugen|  
	var args;
	if (ugen.class.methods.select({|mth| mth.name == 'ar' }).notNil) {
		args = ugen.class.methods.select({|mth| mth.name == 'ar' }).first.argNames
	}
	{
		args = ugen.class.superclass.methods.select({|mth| mth.name == 'ar' }).first.argNames
	};
	(ugen: ugen, args: args )  
})

y = x.select({|ev| (ev.args.size - 1 < 5).and(ev.args.size - 1 > 1) }).select({|ev| (ev.args.includes(\bufnum).not).and( ev.args.includes(\in).not).and( ev.args.includes(\ienvelope).not) })

z = x.select({|ev| (ev.args.size - 1 < 6).and(ev.args.size - 1 > 1) }).select({|ev| (ev.args.includes(\bufnum).not).and(ev.args.includes(\in)).and(ev.ugen.name.asString.find("Foa").isNil) })

x.size
y.size
z.size
y.do({|ev| 
	Post << ev.ugen.name << ": " << ev.args.drop(1) << Char.nl;
})


z.do({|ev| 
	Post << ev.ugen.name << ": " << ev.args.drop(1) << Char.nl;
})

LFNoise0.class.methods

LFNoise2.class.methods.select({|mth| mth.name == 'ar' })