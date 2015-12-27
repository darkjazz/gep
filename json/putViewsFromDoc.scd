~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_ld_00")

~db.putViewsFromDoc("/Users/alo/dev/gep/json/views_02_ld.js")
