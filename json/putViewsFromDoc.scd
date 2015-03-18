~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_00")

~db.putViewsFromDoc("/Users/alo/SuperCollider/gep/json/views_00.js")
