~db = CouchDB(NetAddr(JsonLoader.localIP, JsonLoader.localPort), "ges_00")

~db.requestGuid


Platform

thisProcess.platform.arch


~features = ('ges:features': ('ges:flatness': ('ges:mean': 0.421365476, 'ges:std_dev': 0.02354256)))


~features['ges:features']['ges:flatness']['ges:mean']



~chrm = ~gep.chromosomes.first

~res = "{\"ok\":true,\"id\":\"dea880ff0fcfcde78086408cce005333\",\"rev\":\"1-792fb06adff67f531d5e57fbc44fd542\"}"

~ev = ~res.replace("{", "(").replace("}", ")").replace("\"", "'").interpret
~ev['id']


~gep.linker.ownerClass.name

Method


~loader = JsonLoader("ges_ld_00")

~loader.getPlayerDataByDefName('gep_gen000_004_150814_154251')
