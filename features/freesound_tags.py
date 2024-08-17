import freesound as fs
import numpy as np
from data import Postgres
import time

API_KEY = 'jmHZFoblxiXYy2wdkhKBIKlv9P9XxO9mntUOeSrV'
DB = 'ges-features'
NAME = 'gep_gen000_009_141105_185342'

class TagSearch:
    def __init__(self):
        self.fs_client = fs.FreesoundClient()
        self.fs_client.set_token(API_KEY, "token")
        self.pg = Postgres()

    def run(self):
        self.defs = self.pg.get_missing_defnames()
        for _row in self.defs:
            try:
                _stats = { "mfcc": { "mean": _row[1], "cov": _row[2] } }
                _re = self.query(_row[0], _stats)
                _sounds = [ self.to_dict(_s) for _s in list(_re)[:15] ]
                self.pg.write_tags(_row[0], {"sounds": _sounds })
                print("wrote {num} similar sounds for {defname}".format(num=len(_sounds), defname=_row[0]))
            except Exception as e:
                print("ERROR", _row[0], str(e))
            time.sleep(2)

    def query(self, name, stats):
        mfcc_mean = ",".join(["%.3f"%x for x in stats["mfcc"]["mean"]])
        mfcc_var = ",".join(["%.3f"%x for x in np.array(stats["mfcc"]["cov"]).diagonal().tolist()])
        trgt = "lowlevel.mfcc.mean:" + mfcc_mean + " lowlevel.mfcc.var:" + mfcc_var
        flds = "id,name,url,tags"
        desc = "lowlevel.mfcc.mean"
        filt = "duration:3 TO 33"
        results = self.fs_client.content_based_search(target=trgt, fields=flds, descriptors=desc, filter=filt)
        # for sound in results:
        #     print(sound.name, sound.url, sound.tags)
        return results

    def to_dict(self, sound):
        return {
            "id": sound.id,
            "url": sound.url,
            "name": sound.name,
            "tags": sound.tags
        }

# TagSearch().run()
