import couchdb, json, os, random, sys
import numpy as np
import progressbar as pb
# import spacy
from pymongo import MongoClient
import ssl
from smlib.db import connect_pg, execute_query, commit_query
from psycopg2.extras import Json
import argparse
import glob

conn_str = "mongodb+srv://darkjazz:{pwd}@gep.2uoeb.mongodb.net/{db_name}?retryWrites=true&w=majority"

feature_query = """
select {feature} from ges.feature_frames where defname = '{defname}';
"""

freesound_query = """
select
	value -> 'lowlevel.mfcc.mean' mfcc_mean,
	value -> 'lowlevel.mfcc.cov' mfcc_cov
from ges.audio_features
where defname = '{defname}';
"""

insert_tags = """
insert into ges.freesound_tags (defname, sounds)
values ('{defname}', {sounds})
"""

missing_defnames = """
select
	af.defname,
	af.value -> 'lowlevel.mfcc.mean' mfcc_mean,
	af.value -> 'lowlevel.mfcc.cov' mfcc_cov
from ges.audio_features af
	left join ges.freesound_tags ft on ft.defname = af.defname
where ft.defname is null;
"""

select_tags = """
select * from ges.freesound_tags
"""

select_all_defnames = """
select distinct defname from ges.feature_frames;
"""

select_features = """
select defname, {features} from ges.audio_features;
"""

select_features_by_defnames = """
select defname, {features} from ges.audio_features where defname in ({defnames})
"""

select_melbands = """
select melbands from gtzan.melbands128 where name = '{name}'
"""

select_bpm = """
with rhythm as (
	select defname,
		af.value -> 'rhythm.bpm' bpm,
		abs((af.value -> 'rhythm.bpm')::numeric - {bpm}) dist,
		af.value -> 'rhythm.beats_position' beats_position,
		af.value -> 'lowlevel.mfcc.mean' mfcc
	from ges.audio_features af
)
select defname, bpm, beats_position, mfcc from rhythm order by dist limit {num};
"""

class MongoCloud:
	def __init__(self):
		self.cli = MongoClient(conn_str.format(pwd="Q7JHhiDfwuvVFnMV", db_name="gep"))
		self.db = self.cli.gep
		self.coll = self.db.ges_ld_00
		try:
			self.couch = couchdb.Server()["ges_ld_00"]
		except Exception as e:
			print("WARNING! cannot connect to couchdb")

	def sync(self):
		synced = 0
		prg = pb.ProgressBar(max_value=len(self.couch))
		self.ids = []
		for _i, _id in enumerate(self.couch):
			if self.coll.count_documents({"_id": _id}) == 0:
				_doc = self.couch[_id]
				_id = self.coll.insert_one(_doc)
				self.ids.append(_id)
				synced += 1
			prg.update(_i)
		prg.finish()
		print("synced {synced} synths to cloud".format(synced=synced))

	def get_root_ugen_names(self):
		self.root_names = {}
		prg = pb.ProgressBar(max_value=self.coll.count_documents({}))
		for _i, _synth in enumerate(self.coll.find({})):
			try:
				_genes = _synth["ges:environment"]["ges:numgenes"]
				_genome = _synth["ges:genome"]
				self.root_names[_synth["ges:defname"]] = [ c for i, c in
					enumerate(_genome) if i%int(len(_genome)/_genes)==0
				]
			except Exception as e:
				print("ERROR", _synth)
			prg.update(_i)
		prg.finish()
		with open("train_ugen_tags.json", "w") as f:
			json.dump(self.root_names, f)

class TagData:
	def __init__(self):
		self.pg = Postgres()
		self.dir = "/home/darkjazz/dev/av/gep/features/"
		self.tags_path = os.path.join(self.dir, "tags.list")
		self.train_data_path = os.path.join(self.dir, "train_ugen_tags.json")

	#shuffle synths
	# def load(self, model='lg', include_pos=None):
	# 	self.nlp = spacy.load('en_core_web_%s' % model)
	# 	self.tags = { }
	# 	self.unique_tags = [ ]
	# 	bar = pb.ProgressBar(max_value=len(self.db.view(self.view)))
	# 	for _i, row in enumerate(self.db.view(self.view)):
			# _valid_tags = []
			# for _tag in row.value:
			# 	_tokens = self.nlp(_tag.lower().replace("-", " "))
			# 	for _token in _tokens:
			# 		if _token.has_vector and (include_pos and _token.pos_ in include_pos):
			# 			_valid_tags.append(_token.text)
		# 	self.tags[row.key] = self.nlp(" ".join([ _w.lower().replace("-", " ") for _w in row.value ]))
		# 	[ self.unique_tags.append(_t.text) for _t in self.tags[row.key] if not _t.text in self.unique_tags ]
		# 	bar.update(_i)
		# bar.finish()
		# print('loaded tokens for %d synths' % len(self.tags))

	def collect_stats(self):
		self.fs_tags = self.pg.get_tags()
		self.synth_stats = {}
		self.global_stats = {}
		for _row in self.fs_tags:
			_name = _row[0]
			_sounds = _row[1]
			self.synth_stats[_name] = {}
			self.collect_synth_stats(_name, _sounds)

	def collect_synth_stats(self, name, sounds):
		for _tag in self.merge_tag_list(sounds):
			if not _tag in self.global_stats:
				self.global_stats[_tag] = 1
			else:
				self.global_stats[_tag] += 1
			if not _tag in self.synth_stats[name]:
				self.synth_stats[name][_tag] = 1
			else:
				self.synth_stats[name][_tag] += 1

	def sort_stats(self):
		self.global_stats = { _k: _v for _k, _v in sorted(self.global_stats.items(), key=lambda x: x[1], reverse=True) }
		for _name, _stats in self.synth_stats.items():
			self.synth_stats[_name] = { _k: _v for _k, _v in sorted(_stats.items(), key=lambda x: x[1], reverse=True) }

	def merge_tag_list(self, sounds):
		tags = []
		for _sound in sounds:
			_tags = [ self.clean_tag(_t) for _t in _sound["tags"] if self.include_tag(_t) ]
			tags.extend(_tags)
		return tags

	def clean_tag(self, tag):
		return tag.replace("-", " ").lower()

	def include_tag(self, tag):
		re = (not tag.isnumeric()) and len(tag.split(" ")) == 1
		re = re and len(tag.split("-")) == 1
		re = re and len([ _c for _c in tag if _c.isnumeric() ]) == 0
		return re and len(tag) > 2

	def make_dict(self):
		self.dict = { }
		for _name in self.tags:
			_tokens = self.tags[_name]
			for _token in _tokens:
				if not _token.text in self.dict:
					self.dict[_token.text] = [ _name ]
				elif not _token.text in self.dict[_token.text]:
					self.dict[_token.text].append(_name)

	def save_dict(self):
		for _word in self.dict:
			self.dict_db.save({ '_id': _word, 'names': self.dict[_word	] })

	def load_dict(self):
		self.dict = { }
		for _row in self.dict_db.view('views/names_by_tag'):
			self.dict[_row.key] = _row.value

	def search(self, text):
		names = [ ]
		words = { }
		for _word in text.split(" "):
			if _word in self.dict:
				words[_word] = self.dict[_word]
				names = self.dict[_word]
		names = [ set(names) & set(_names) for _names in words.values() ]
		return list(names[0])

	def load_json(self, path):
		with open(path, encoding="utf8") as f:
			self.data = json.load(f)

	def insert_tags(self):
		for _fn, _doc in self.tag_data.items():
			_co = self.pg.write_tags(_fn, _doc)
			print(_fn, _co)

	def load_train_data(self):
		self.load_json(self.train_data_path)

class FeatureData:
	def __init__(self):
		self.pg = Postgres()
		self.tags = TagData()
		self.feature = "melbands128"
		self.num_frames = 256

	def load(self):
		self.tags.load_train_data()
		self.features = { }
		self.defnames = [ _r[0] for _r in self.pg.get_all_defnames() ]
		bar = pb.ProgressBar(max_value=len(self.defnames))
		for _i, _name in enumerate(self.defnames):
			_ftr = self.pg.get_frames(self.feature, _name)
			if len(_ftr) == 1 and len(_ftr[0][0]) >= self.num_frames:
				self.features[_name] = _ftr[0][0][:self.num_frames]
			bar.update(_i)
		bar.finish()
		# self.prepare()
		print('loaded features for %d synths' % len(self.features))

	def load_gtzan(self, basedir="/home/darkjazz/io/genres"):
		self.features = { }
		self.tags = TagData()
		self.tags.data = { }
		bar = pb.ProgressBar(max_value=1000)
		i = 0
		for dir in glob.glob(os.path.join(basedir, "*")):
			for path in glob.glob(os.path.join(dir, "*")):
				name = os.path.basename(path)
				ftr = self.pg.get_gtzan_frames(name)[0][0]
				self.features[name] = ftr
				self.tags.data[name] = [ dir ]
				bar.update(i)
				i += 1
		bar.finish()
		self.prepare()
		print('loaded features for %d synths' % len(self.features))

	def prepare(self):
		self.x = []
		self.y = []
		self.err = []
		for _name in self.tags.data:
			if _name in self.features:
				_ftr = [ band[:1290] for band in self.features[_name] ]
				for _tag in self.tags.data[_name]:
					self.x.append(_ftr)
					self.y.append(_tag)
			else:
				self.err.append(_name)
		self.tags.unique = list(set([ _t for _t in self.y ]))
		self.tags.unique.sort()
		inds = list(range(len(self.x)))
		random.shuffle(inds)
		self.x = [ self.x[_i] for _i in inds ]
		self.y = [ self.y[_i] for _i in inds ]

	def get_tagless(self):
		self.tagless = { _k: _v for _k, _v in self.features.items() if not _k in self.tags.data }
		return self.tagless.values()

	def collect_features(self, feature_keys, filename=None, write_to_disk=False):
		self.results = self.pg.get_features(feature_keys)
		self.features = { _f[0]: { _k: self.wrap_feature(_f[feature_keys.index(_k)+1]) for _k in feature_keys } for _f in self.results }
		if filename and write_to_disk:
			with open(filename, "w") as f:
				json.dump(self.features, f)

	def collect_features_by_defname(self, feature_keys, defnames):
		self.results = self.pg.get_defname_features(feature_keys, defnames)
		self.features = { _f[0]: { _k: self.wrap_feature(_f[feature_keys.index(_k)+1]) for _k in feature_keys } for _f in self.results }

	def collect_synths_by_bpm(self, bpm, num, filename=None):
		feature_keys = ["bpm", "beats_position", "mfcc"]
		self.results = self.pg.get_synths_by_bpm(bpm, num)
		self.synths = { _f[0]: { _k: _f[feature_keys.index(_k)+1] for _k in feature_keys } for _f in self.results }
		if filename:
			with open(filename, "w") as f:
				json.dump(self.synths, f)
		else:
			return json.dumps(self.synths)

	def wrap_feature(self, feature):
		if isinstance(feature, list):
			return feature
		else:
			return [feature]

class Postgres:
	def __init__(self):
		self.config = {
			"host": "localhost",
			"db": "synth",
			"user": "postgres",
			"pwd": "p05tgr35"
		}

	def get_tags(self):
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, select_tags)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_frames(self, feature, defname):
		self.query = feature_query.format(feature=feature, defname=defname)
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_gtzan_frames(self, name):
		self.query = select_melbands.format(name=name)
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_freesound_features(self, defname):
		self.query = freesound_query.format(defname=defname)
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def write_tags(self, defname, doc):
		self.query = insert_tags.format(defname=defname, sounds=Json(doc["sounds"]))
		self.conn = None
		count = 0
		try:
			self.conn = connect_pg(self.config)
			count = commit_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return count

	def get_missing_defnames(self):
		self.query = missing_defnames;
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_all_defnames(self):
		self.query = select_all_defnames
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_features(self, feature_keys):
		keys = [ "value -> '{key}'".format(key=_k) for _k in feature_keys ]
		self.query = select_features.format(features=",".join(keys))
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_defname_features(self, feature_keys, defnames):
		keys = [ "value -> '{key}'".format(key=_k) for _k in feature_keys ]
		names = [ "'{name}'".format(name=_n) for _n in defnames ]
		self.query = select_features_by_defnames.format(features=",".join(keys), defnames=",".join(names))
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result

	def get_synths_by_bpm(self, bpm, num):
		self.query = select_bpm.format(bpm=bpm, num=num)
		self.conn = None
		self.result = []
		try:
			self.conn = connect_pg(self.config)
			colnames, self.result = execute_query(self.conn, self.query)
		except Exception as e:
			print(str(e))
		finally:
			if self.conn:
				self.conn.close()
			return self.result


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument("-b", "--bpm")
	parser.add_argument("-n", "--num")

	args = parser.parse_args()

	if args.bpm and args.num:
		data = FeatureData()
		sys.stdout.write(data.collect_synths_by_bpm(args.bpm, args.num))
