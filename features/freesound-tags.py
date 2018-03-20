import freesound as fs
import couchdb as cdb
import numpy as np

API_KEY = 'jmHZFoblxiXYy2wdkhKBIKlv9P9XxO9mntUOeSrV'
DB = 'ges-features'
NAME = 'gep_gen000_009_141105_185342'

class TagSearch:
    def __init__(self):
        self.fs_client = fs.FreesoundClient()
        self.fs_client.set_token(API_KEY, "token")
        srv = cdb.Server()
        self.db = srv[DB]

    def run(self):
        for row in self.db.view("views/stats_by_name", key=NAME):
            self.query(row.key, row.value)

    def query(self, name, stats):
        mfcc_mean = ",".join(["%.3f"%x for x in stats["mfcc"]["mean"]])
        mfcc_var = ",".join(["%.3f"%x for x in np.array(stats["mfcc"]["cov"]).diagonal().tolist()])
        trgt = "lowlevel.mfcc.mean:" + mfcc_mean + " lowlevel.mfcc.var:" + mfcc_var
        flds = "id,name,url,tags"
        desc = "lowlevel.mfcc.mean"
        filt = "duration:0 TO 11"
        results = self.fs_client.content_based_search(target=trgt, fields=flds, descriptors=desc, filter=filt)
        for sound in results:
            print sound.name, sound.url, sound.tags

TagSearch().run()
